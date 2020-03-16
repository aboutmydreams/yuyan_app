import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/group/group_page.dart';
import 'package:yuyan_app/models/component/group/topic/topic_detail_page.dart';
import 'package:yuyan_app/models/component/user/user_page.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/group/group_data.dart';

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
  static user(BuildContext context,
      {String login,
      String name,
      int userId,
      String avatarUrl,
      String description,
      String tag,
      int pageIndex: 0}) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return UserPage(
        login: login,
        name: name,
        userId: userId,
        avatarUrl: avatarUrl,
        description: description,
        tag: tag,
        pageIndex: pageIndex,
      );
    }));
  }

  // 打开团队页面
  static group(BuildContext context, {GroupData groupdata, int pageIndex: 0}) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return GroupPage(groupdata: groupdata, pageIndex: pageIndex);
    }));
  }

  // 打开文档知识库

  // 打开画板知识库

  // 打开话题知识库

  // 打开话题
  static topic(BuildContext context, {int id, int iid, int groupId}) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return TopicDetail(id: id, iid: iid, groupId: groupId);
    }));
  }
}
