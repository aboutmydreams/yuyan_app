import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/models/net/requests_api/doc/data/all_doc_book_data.dart';
import 'package:yuyan_app/models/widgets_small/toast.dart';
import 'package:yuyan_app/state_manage/dataManage/note_manage.dart';
import 'package:yuyan_app/state_manage/toppest.dart';
import 'package:yuyan_app/views/dashboard/quick/note/view/note_list.dart';
import 'package:yuyan_app/views/explore_page/search/search_bar.dart';

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
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            tooltip: '搜索小记',
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchBarDelegate(aboutMe: true),
              );
            },
          )
        ],
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
