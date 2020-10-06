import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/book_doc/view/one_my_doc.dart';
import 'package:yuyan_app/models/net/requests_api/search/data/doc_data.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/nothing.dart';

class SearchDocPage extends StatelessWidget {
  const SearchDocPage({Key key, this.docBookJson}) : super(key: key);

  final SearchDocJson docBookJson;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: docBookJson == null
          ? loading()
          : docBookJson.data.hits.isEmpty
              ? NothingPage(
                  top: 50,
                  text: "暂无文档~",
                )
              : animationList(
                  context: context,
                  aniWhich: 2,
                  dataList: docBookJson.data.hits
                      .map((data) => setData(data))
                      .toList(),
                  childBuilder: buildDoc,
                ),
    );
  }
}

Map setData(Hits data) {
  return {
    "type": data.type,
    "title": data.title.replaceAll("<em>", "").replaceAll("</em>", ""),
    "cover": data.rRecord.cover,
    "slug": data.slug,
    "description": data.rRecord.description,
    "user": data.groupName,
    "login": data.rRecord.book.user.login,
    "avatar": data.rRecord.book.user.avatarUrl,
    "bookId": data.rRecord.bookId,
    "bookSlug": data.rRecord.book.slug,
    "docId": data.rRecord.id
  };
}
