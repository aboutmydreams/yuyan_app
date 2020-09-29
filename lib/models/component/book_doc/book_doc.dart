import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/group/view/home_page.dart';
import 'package:yuyan_app/models/net/requests_api/doc_book/book.dart';
import 'package:yuyan_app/models/net/requests_api/doc_book/data/doc_book_data.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/nothing.dart';

class BookDocPage extends StatefulWidget {
  BookDocPage({Key key, this.bookId}) : super(key: key);
  final int bookId;

  @override
  _BookDocPageState createState() => _BookDocPageState(bookId: bookId);
}

class _BookDocPageState extends State<BookDocPage> {
  _BookDocPageState({Key key, this.bookId});
  final int bookId;

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
                  dataList: docBookJson.data,
                  childBuilder: buildDoc,
                ),
    );
  }

  Widget buildDoc(BuildContext context, TocData data) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
        child: Text(
          data.title,
          style: AppStyles.textStyleB,
        ),
      ),
    );
    // return oneDoc(context, data, login, bookSlug)
  }
}
