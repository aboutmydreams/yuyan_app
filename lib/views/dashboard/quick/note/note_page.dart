import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/controller/global/my_controller.dart';
import 'package:yuyan_app/controller/global/user_controller.dart';
import 'package:yuyan_app/model/document/note/note.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/net/requests_api/doc/data/all_doc_book_data.dart';
import 'package:yuyan_app/models/widgets_small/toast.dart';
import 'package:yuyan_app/state_manage/dataManage/note_manage.dart';
import 'package:yuyan_app/state_manage/toppest.dart';
import 'package:yuyan_app/views/dashboard/quick/note/view/note_list.dart';
import 'package:yuyan_app/views/widget/animation_widget.dart';
import 'package:yuyan_app/views/widget/lake_render_widget.dart';

class QuickNotePage extends StatefulWidget {
  @override
  _QuickNotePageState createState() => _QuickNotePageState();
}

class _QuickNotePageState extends State<QuickNotePage> {
  @override
  void initState() {
    super.initState();

    Get.put(MyNoteController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarOpacity: 1.0,
        bottomOpacity: 5.0,
        elevation: 1,
        title: Text("小记"),
      ),
      floatingActionButton: GestureDetector(
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/edit/note');
          },
          child: Icon(Icons.add),
        ),
      ),
      body: GetBuilder<MyNoteController>(
        builder: (c) => c.builder(
          (state) => AnimationListWidget(
            itemCount: state.data.length,
            itemBuilder: (_, i) {
              return _buildNoteItem(state.data[i]);
            },
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }

  Widget _buildNoteItem(NoteSeri item) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 2, left: 10, right: 10),
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
      child: _buildNoteContent(item),
    );
  }

  _buildNoteContent(NoteSeri item) {
    return Column(
      children: [
        LakeRenderWidget(
          data: item.description,
        ),
        if (item.description.endsWith('<!-- note-viewmore -->'))
          FlatButton(
            onPressed: () {
              debugPrint('查看全部');
              Get.to(
                MyNoteDetailPage(),
                binding: BindingsBuilder.put(
                  () => NoteDetailController(item.id),
                ),
              );
            },
            child: Text('查看全部'),
          ),
      ],
    );
  }
}

class MyNoteDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('小记详情'),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<NoteDetailController>(
          builder: (c) => c.stageBuilder(
            onIdle: () => LakeRenderWidget(data: c.value.doclet.bodyAsl),
          ),
        ),
      ),
    );
  }
}

class NotePage extends StatefulWidget {
  NotePage({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<NotePage> {
  AllDocBookJson allDocBookJson;

  @override
  void initState() {
    super.initState();
    getNoteData();
  }

  getNoteData() async {
    // AllDocBookJson _books = await DioDoc.getAllDocBook();
    // setState(() {
    //   allDocBookJson = _books;
    // });
  }

  addNote() {
    // 9215477
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        toolbarOpacity: 1.0,
        bottomOpacity: 5.0,
        elevation: 1,
        title: Text("小记"),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(
        //       Icons.search,
        //       color: Colors.white,
        //     ),
        //     tooltip: '搜索小记',
        //     onPressed: () {
        //       showSearch(
        //         context: context,
        //         delegate: SearchBarDelegate(aboutMe: true),
        //       );
        //     },
        //   )
        // ],
      ),
      floatingActionButton: GestureDetector(
        onLongPress: () {
          Navigator.pushNamed(context, '/edit/note');
          myToast(context, "Thanks for looking forward 💕");
        },
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/edit/note');
          },
          child: Icon(Icons.add),
        ),
      ),
      body: ScopedModel<NoteManage>(
        model: topModel.noteManage,
        child: NoteList(),
      ),
    );
  }
}
