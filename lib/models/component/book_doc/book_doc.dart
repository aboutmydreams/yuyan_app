import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/book_doc/view/one_my_doc.dart';
import 'package:yuyan_app/models/net/requests/dio_requests.dart';
import 'package:yuyan_app/models/net/requests_api/doc_book/book.dart';
import 'package:yuyan_app/models/net/requests_api/doc_book/data/doc_book_data.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/nothing.dart';

class BookDocPage extends StatefulWidget {
  BookDocPage({Key key, this.bookId, this.bookSlug, this.login})
      : super(key: key);
  final int bookId;
  final String bookSlug;
  final String login;

  @override
  _BookDocPageState createState() =>
      _BookDocPageState(bookId: bookId, bookSlug: bookSlug, login: login);
}

class _BookDocPageState extends State<BookDocPage> {
  _BookDocPageState({Key key, this.bookId, this.bookSlug, this.login});
  final int bookId;
  final String bookSlug;
  final String login;

  DocBookJson docBookJson;
  String reallyLogin;

  @override
  void initState() {
    super.initState();
    getTocData(bookId: bookId);
    if (login == null) {
      getReallyLogin(bookId: bookId);
    }
  }

  getTocData({int bookId}) async {
    DocBookJson tocData = await DioDocBook.getData(bookId: bookId);
    setState(() {
      docBookJson = tocData;
    });
  }

  getReallyLogin({int bookId}) async {
    String redirect =
        await DioReq.getRedirect("https://www.yuque.com/go/book/$bookId");
    setState(() {
      reallyLogin = redirect.split("/")[0];
    });
  }

  Map setData(TocData data) {
    return {
      "type": data.type,
      "title": data.title.replaceAll("<em>", "").replaceAll("</em>", ""),
      "cover": data.cover,
      "slug": data.slug,
      "description": data.description,
      "user": data.user.name,
      "login": login ?? reallyLogin ?? data.user.login,
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
