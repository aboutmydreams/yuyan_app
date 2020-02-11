import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/group/group_page.dart';

import 'book_doc/doc_page/doc_page.dart';

class OpenPage {
  // 打开文档
  static doc(BuildContext context, {int bookId, int docId}) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return DocPage(
        bookId: bookId,
        docId: docId,
      );
    }));
  }

  // 打开其他用户的页面
  static user(BuildContext context, {int bookId, int docId}) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return DocPage(
        bookId: bookId,
        docId: docId,
      );
    }));
  }

  // 打开团队页面
  static group(BuildContext context, {int groupId, int pageIndex: 0}) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return GroupPage(groupId: groupId, pageIndex: pageIndex);
    }));
  }

  // 打开文档知识库

  // 打开画板知识库

  // 打开话题知识库

  //
}
