import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/book_doc/book_doc.dart';


class OpenPage {
  // 打开文档
  // static doc(BuildContext context, {int bookId, int docId}) {
  //   Navigator.of(context).push(MaterialPageRoute(builder: (_) {
  //     return DocPage(
  //       bookId: bookId,
  //       docId: docId,
  //     );
  //   }));
  // }

  // static docWeb(BuildContext context,
  //     {String login,
  //     String bookSlug,
  //     String url,
  //     int bookId,
  //     int docId,
  //     bool onlyUser}) {
  //   Navigator.of(context).push(MaterialPageRoute(builder: (_) {
  //     return DocPageWeb(
  //       login: login,
  //       url: url,
  //       bookSlug: bookSlug,
  //       bookId: bookId,
  //       docId: docId,
  //       onlyUser: onlyUser,
  //     );
  //   }));
  // }

  // 打开文档知识库
  static docBook(BuildContext context,
      {int bookId, String bookSlug, String login, bool onlyUser}) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return BookDocPage(
        bookId: bookId,
        bookSlug: bookSlug,
        login: login,
        onlyUser: onlyUser,
      );
    }));
  }

  // 打开画板知识库

  // 打开话题知识库
}
