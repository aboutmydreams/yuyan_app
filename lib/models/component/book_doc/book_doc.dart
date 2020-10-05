import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/book_doc/view/one_my_doc.dart';
import 'package:yuyan_app/models/component/group/view/home_page.dart';
import 'package:yuyan_app/models/net/requests_api/doc_book/book.dart';
import 'package:yuyan_app/models/net/requests_api/doc_book/data/doc_book_data.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/nothing.dart';

class BookDocPage extends StatefulWidget {
  BookDocPage({Key key, this.bookId, this.bookSlug}) : super(key: key);
  final int bookId;
  final String bookSlug;

  @override
  _BookDocPageState createState() =>
      _BookDocPageState(bookId: bookId, bookSlug: bookSlug);
}

class _BookDocPageState extends State<BookDocPage> {
  _BookDocPageState({Key key, this.bookId, this.bookSlug});
  final int bookId;
  final String bookSlug;

  DocBookJson docBookJson;

  @override
  void initState() {
    super.initState();
    getTocData(bookId: bookId);
  }

  getTocData({int bookId}) async {
    DocBookJson tocData = await DioDocBook.getData(bookId: bookId);
    print("tocData=====");
    print(tocData.data);
    setState(() {
      docBookJson = tocData;
    });
  }

  Map setData(TocData data) {
    return {
      "type": data.type,
      "title": data.title,
      "cover": data.cover,
      "slug": data.slug,
      "description": data.description,
      "user": data.user.name,
      "login": data.user.login,
      "avatar": data.user.avatarUrl,
      "bookId": data.bookId,
      "bookSlug": bookSlug,
      "docId": data.id
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("文档知识库"),
      ),
      body: docBookJson == null
          ? loading()
          : docBookJson.data.isEmpty
              ? NothingPage(
                  top: 50,
                  text: "暂无文档~",
                )
              : animationList(
                  context: context,
                  dataList:
                      docBookJson.data.map((data) => setData(data)).toList(),
                  childBuilder: buildDoc,
                ),
    );
  }
}
