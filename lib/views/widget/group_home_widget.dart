import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/model/document/book_stack/book_stack.dart';
import 'package:yuyan_app/model/document/book_stack/summary.dart';
import 'package:yuyan_app/model/document/user.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/util/util.dart';

class GroupHomeWidget extends StatelessWidget {
  final List<BookStackSeri> stack;

  const GroupHomeWidget({
    Key key,
    this.stack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var data = stacks;
    return ListView.builder(
      itemCount: stack.length,
      itemBuilder: (_, i) {
        return _homeItem(stack[i]);
      },
    );
  }

  _homeItem(BookStackSeri item) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                "${item.name}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.textStyleB,
              ),
            ),
          ),
          ...item.books.map((e) => _bookItem(e)),
        ],
      ),
    );
  }

  _bookItem(BookSeri item) {
    return GestureDetector(
      onTap: () {
        // openUrl(context, "https://www.yuque.com/${data.login}");
      },
      child: Container(
        margin: EdgeInsets.only(left: 15, top: 2, bottom: 8, right: 15),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.background,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(25, 0, 0, 0),
              offset: Offset(1, 2),
              blurRadius: 4,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 14,
                  height: 14,
                  child: AppIcon.iconType(item.type, size: 17),
                ),
                Container(
                  width: Get.width * 0.4,
                  margin: EdgeInsets.only(left: 20),
                  child: Container(
                    child: Text(
                      "${item.name}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.textStyleB,
                    ),
                  ),
                ),
              ],
            ),
            if (item.type == 'Design')
              Row(
                children: item.summary.map((d) {
                  return _designItem(d, item.user);
                }).toList(),
              ),
            if (item.type != 'Design')
              ...item.summary.map((e) {
                return _docItem(e, item.user);
              }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _designItem(SummarySeri item, UserSeri user) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 7, 0, 2),
      width: (Get.width - 70) / 3,
      child: CachedNetworkImage(imageUrl: item.image),
    );
  }

  Widget _docItem(SummarySeri item, UserSeri user) {
    return InkWell(
      onTap: () {
        // OpenPage.docWeb(
        //   context,
        //   login: login,
        //   bookSlug: bookSlug,
        //   bookId: data.bookId,
        //   docId: data.id,
        // );
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 7, 0, 2),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(item.title ?? item.titleDraft),
            ),
            Text(
              Util.timeCut(item.contentUpdatedAt ?? item.createdAt),
              style: AppStyles.textStyleCC,
            ),
          ],
        ),
      ),
    );
  }
}
