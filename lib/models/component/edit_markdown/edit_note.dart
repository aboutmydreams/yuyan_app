import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuyan_app/controller/theme_controller.dart';
import 'package:yuyan_app/models/component/edit_markdown/convert/to_markdown.dart';
import 'package:yuyan_app/models/net/requests_api/notes/note.dart';
import 'package:yuyan_app/models/net/requests_api/util/convert.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/toast.dart';
import 'package:yuyan_app/state_manage/toppest.dart';
import 'package:yuyan_app/util/get_pref.dart';
import 'package:zefyr/zefyr.dart';
import 'view/images.dart';

class EditNotePage extends StatefulWidget {
  @override
  _EditNotePageState createState() => _EditNotePageState();
}

const NotusMarkdownCodec notusMarkdown = NotusMarkdownCodec();

enum _Options { darkTheme }

final doc1 =
    r'[{"insert":"Zefyr"},{"insert":"\n","attributes":{"heading":1}},{"insert":"Soft and gentle rich text editing for Flutter applications.","attributes":{"i":true}},{"insert":"\n"},{"insert":"​","attributes":{"embed":{"type":"image","source":"https://cdn.nlark.com/yuque/0/2020/jpeg/164272/1585392509901-05c7bcef-cb37-4dfb-86e4-505f296853a7.jpeg"}}},{"insert":"\n"},{"insert":"Photo by Hiroyuki Takeda.","attributes":{"i":true}},{"insert":"\nZefyr is currently in "},{"insert":"early preview","attributes":{"b":true}},{"insert":". If you have a feature request or found a bug, please file it at the "},{"insert":"issue tracker","attributes":{"a":"https://github.com/memspace/zefyr/issues"}},{"insert":'
    r'".\nDocumentation"},{"insert":"\n","attributes":{"heading":3}},{"insert":"Quick Start","attributes":{"a":"https://github.com/memspace/zefyr/blob/master/doc/quick_start.md"}},{"insert":"\n","attributes":{"block":"ul"}},{"insert":"Data Format and Document Model","attributes":{"a":"https://github.com/memspace/zefyr/blob/master/doc/data_and_document.md"}},{"insert":"\n","attributes":{"block":"ul"}},{"insert":"Style Attributes","attributes":{"a":"https://github.com/memspace/zefyr/blob/master/doc/attr'
    r'ibutes.md"}},{"insert":"\n","attributes":{"block":"ul"}},{"insert":"Heuristic Rules","attributes":{"a":"https://github.com/memspace/zefyr/blob/master/doc/heuristics.md"}},{"insert":"\n","attributes":{"block":"ul"}},{"insert":"FAQ","attributes":{"a":"https://github.com/memspace/zefyr/blob/master/doc/faq.md"}},{"insert":"\n","attributes":{"block":"ul"}},{"insert":"Clean and modern look"},{"insert":"\n","attributes":{"heading":2}},{"insert":"Zefyr’s rich text editor is built with simplicity and fle'
    r'xibility in mind. It provides clean interface for distraction-free editing. Think Medium.com-like experience.\nMarkdown inspired semantics"},{"insert":"\n","attributes":{"heading":2}},{"insert":"Ever needed to have a heading line inside of a quote block, like this:\nI’m a Markdown heading"},{"insert":"\n","attributes":{"block":"quote","heading":3}},{"insert":"And I’m a regular paragraph"},{"insert":"\n","attributes":{"block":"quote"}},{"insert":"Code blocks"},{"insert":"\n","attributes":{"headin'
    r'g":2}},{"insert":"Of course:\nimport ‘package:flutter/material.dart’;"},{"insert":"\n","attributes":{"block":"code"}},{"insert":"import ‘package:zefyr/zefyr.dart’;"},{"insert":"\n\n","attributes":{"block":"code"}},{"insert":"void main() {"},{"insert":"\n","attributes":{"block":"code"}},{"insert":" runApp(MyZefyrApp());"},{"insert":"\n","attributes":{"block":"code"}},{"insert":"}"},{"insert":"\n","attributes":{"block":"code"}},{"insert":"\n\n\n"}]';
final doc2 = r'[{"insert":"\n"}]';

Delta getDelta() {
  return Delta.fromJson(json.decode(doc1) as List);
}

class _EditNotePageState extends State<EditNotePage> {
  Delta doc = Delta();
  ZefyrController _controller = ZefyrController(
      NotusDocument.fromDelta(Delta.fromJson(json.decode(doc2) as List)));

  final FocusNode _focusNode = FocusNode();
  bool _editing = true;
  StreamSubscription<NotusChange> _sub;
  bool _darkTheme = false;
  bool isPublishing = false;

  @override
  void initState() {
    super.initState();

    _sub = _controller.document.changes.listen((change) {
      print('${change.source}: ${change.change}');
    });
  }

  getSaveNote() async {
    /// 每次进入页面时检查缓存是否有内容，如果有则渲染。
    String noteDoc = await getPrefStringData('save_note') ?? '[]';
    Delta docDelta = Delta.fromJson(json.decode(noteDoc) as List);
    setState(() {
      doc = docDelta;
      _controller = ZefyrController(NotusDocument.fromDelta(doc));
    });
    return;
  }

  updateNotePref() async {
    /// 仅当编辑器中存在内容时，用户更新内容或退出时调用。
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("save_note", '');
  }

  publishNote() async {
    /// 发布内容，清空 note 缓存
    /// 0、显示发布中
    /// 1、获取 Markdown 文档
    /// 2、调用语雀 convert 转为 lake
    /// 3、发布 note，清空 note 缓存
    /// 4、刷新 note 数据
    /// 5、发布成功，退回上一页面

    setState(() {
      isPublishing = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String markdown = notusMarkdown.encode(_controller.document.toDelta());
    int noteId = topModel.noteManage.noteData.meta.mirror.id;
    var lake = await DioUtil.toLake(
      markdown: markdown,
      referer: 'https://www.yuque.com/dashboard/notes',
    );
    await DioNote.addNotes(html: lake, id: noteId).then((ans) {
      if (ans.toString().contains('id')) {
        topModel.noteManage.update();
        prefs.remove('save_note');
        Timer(Duration(milliseconds: 400), () {
          myToast(context, '发布成功');
          setState(() {
            isPublishing = false;
          });
          Navigator.pop(context);
        });
      }
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final done = _editing
    //     ? IconButton(onPressed: _stopEditing, icon: Icon(Icons.save))
    //     : IconButton(onPressed: _startEditing, icon: Icon(Icons.edit));
    final result = Scaffold(
        // resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          title: Text('小记'),
          actions: [
            FlatButton.icon(
              onPressed: () {
                // _saveDocument(context);

                // final index = _controller.selection.baseOffset;
                // final length = _controller.selection.extentOffset - index;
                // String markdown =
                //     notusMarkdown.encode(_controller.document.toDelta());
                // Delta delta = notusMarkdown.decode(markdown);
                // print(_controller.document.toDelta().toJson());
                // print("index===$index, length===$length");
                // print(_controller.selection.affinity.index);
                publishNote();
              },
              icon: Icon(
                Icons.send_sharp,
                color: Colors.white,
              ),
              label: Text("发布"),
              // color: AppColors.primary,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
            ),
          ],
        ),
        body: Stack(
          children: [
            ZefyrScaffold(
              child: ZefyrEditor(
                controller: _controller,
                focusNode: _focusNode,
                mode: _editing ? ZefyrMode.edit : ZefyrMode.select,
                imageDelegate: CustomImageDelegate(),
                keyboardAppearance:
                    _darkTheme ? Brightness.dark : Brightness.light,
              ),
            ),
            Positioned(
              child: isPublishing ? loading() : SizedBox(height: 10),
            ),
          ],
        ));
    if (_darkTheme) {
      return Theme(data: ThemeData.dark(), child: result);
    }
    return Theme(
      data: ThemeData(primarySwatch: ThemeController.to.primarySwatchColor),
      child: result,
    );
  }

  void handlePopupItemSelected(value) {
    if (!mounted) return;
    setState(() {
      if (value == _Options.darkTheme) {
        _darkTheme = !_darkTheme;
      }
    });
  }

  List<PopupMenuEntry<_Options>> buildPopupMenu(BuildContext context) {
    return [
      CheckedPopupMenuItem(
        value: _Options.darkTheme,
        child: Text('Dark theme'),
        checked: _darkTheme,
      ),
    ];
  }

  void _startEditing() {
    setState(() {
      _editing = true;
    });
  }

  void _stopEditing() {
    setState(() {
      _editing = false;
    });
  }
}
