import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/net/requests/dio_requests.dart';
import 'package:yuyan_app/models/net/requests_api/doc/data/all_doc_book_data.dart';
import 'package:yuyan_app/models/net/requests_api/doc/doc.dart';
import 'package:yuyan_app/models/tools/analytics.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';

class SelectView extends StatelessWidget {
  const SelectView({Key key, this.book}) : super(key: key);
  final AllDocBooks book;

  @override
  Widget build(BuildContext context) {
    analytics.logEvent(name: 'select_book');
    return ListTile(
      leading: userAvatar(book.user.avatarUrl, height: 30),
      title: Text(book.name),
      onTap: () async {
        String baseUrl = await DioReq.orgSpace();
        await DioDoc.createDocV2(bookId: book.id).then((slug) async {
          String url = baseUrl.substring(0, baseUrl.indexOf("api")) +
              book.user.login +
              "/" +
              book.slug +
              "/" +
              slug +
              "/edit";
          openUrl(context, url, title: "编辑文档");
        });
      },
    );
  }
}
