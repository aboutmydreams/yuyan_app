import 'package:flutter/material.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:quill_markdown/quill_markdown.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/edit_markdown/convert/to_markdown.dart';
import 'package:yuyan_app/models/component/edit_markdown/view/images.dart';
import 'package:yuyan_app/models/net/requests_api/notes/data/note_data.dart';
import 'package:yuyan_app/models/widgets_big/html/body_html.dart';
import 'dart:async';
import 'dart:convert';
import 'package:zefyr/zefyr.dart';
import 'package:yuyan_app/models/widgets_big/html/view/img.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/nothing.dart';
import 'package:yuyan_app/state_manage/dataManage/note_manage.dart';
import 'package:quill_delta/quill_delta.dart';

const NotusMarkdownCodec notusMarkdown = NotusMarkdownCodec();

class NoteList extends StatelessWidget {
  const NoteList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<NoteManage>(builder: (context, child, model) {
      List dataList = model.noteData.data;
      return Container(
        child: dataList == null
            ? loading()
            : dataList.isEmpty
                ? NothingPage(
                    top: 50,
                    text: "没有正在进行的话题~",
                  )
                : animationList(
                    context: context,
                    dataList: dataList,
                    childBuilder: oneTopic,
                  ),
      );
    });
  }
}

Widget oneTopic(BuildContext context, Data data) {
  return GestureDetector(
    onTap: () {
      // OpenPage.topic(
      //   context,
      //   id: data.id,
      //   iid: data.iid,
      //   groupId: data.groupId,
      // );
    },
    child: Container(
        margin: EdgeInsets.only(top: 2, bottom: 9, left: 10, right: 10),
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.background,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(25, 0, 0, 0),
              offset: Offset(1, 2),
              blurRadius: 4,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(9.5)),
        ),
        child: lake2md(context, data.description)),
  );
}

lake2md(BuildContext context, String htmlLake) {
  if (htmlLake.contains('name="image"')) {
    String startStr = 'data:%7B%22src%22%3A%22';
    String endStr = '%22%2C%22originWidth';
    int imgStart = htmlLake.toString().indexOf(startStr);
    int imgEnd = htmlLake.toString().indexOf(endStr);
    String imgUrl = Uri.decodeComponent(
        htmlLake.substring(imgStart + startStr.length, imgEnd));
    return imgHtml(context, imgUrl);
  } else {
    String markdown = html2md.convert(htmlLake);
    // Delta delta = notusMarkdown.decode(markdown);
    String deltaStr = markdownToQuill(markdown).replaceAll('"link"', '"a"');
    deltaStr = deltaStr.replaceAll('{"heading":4}', '{"heading":3}');
    deltaStr = deltaStr.replaceAll('{"heading":5}', '{"heading":3}');
    deltaStr = deltaStr.replaceAll('{"list":"bullet"}', '{"block":"ul"}');
    final ZefyrController _controller = ZefyrController(
        NotusDocument.fromDelta(Delta.fromJson(json.decode(deltaStr) as List)));
    final FocusNode _focusNode = FocusNode();
    bool _editing = false;
    StreamSubscription<NotusChange> _sub;
    bool _darkTheme = false;
    // return Text(deltaStr);
    return Container(
      height: 130,
      child: ZefyrScaffold(
        child: ZefyrEditor(
          controller: _controller,
          focusNode: _focusNode,
          mode: ZefyrMode.select,
          imageDelegate: CustomImageDelegate(),
          keyboardAppearance: _darkTheme ? Brightness.dark : Brightness.light,
        ),
      ),
    );
  }
}
