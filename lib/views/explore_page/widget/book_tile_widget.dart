import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/config/app_ui.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/widget/user_widget.dart';

class BookTileWidget extends StatelessWidget {
  final BookSeri item;

  const BookTileWidget({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = item;
    return GestureDetector(
      onTap: () {
        var book = data;
        MyRoute.bookDocs(book);
      },
      child: Container(
        height: 86,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.background,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(25, 0, 0, 0),
              offset: Offset(1, 2),
              blurRadius: 4,
            ),
          ],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            SizedBox(width: 4),
            UserAvatarWidget(
              avatar: data.user.avatarUrl,
              height: 50,
            ),
            Container(
              margin: EdgeInsets.only(left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      data.name.clip(10, ellipsis: true),
                      style: AppStyles.textStyleB,
                    ),
                  ),
                  SizedBox(height: 2),
                  Container(
                    width: 200,
                    child: Text(
                      "${data.description}",
                      style: AppStyles.textStyleC,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookTileWidgetFlat extends StatelessWidget {
  final BookSeri item;

  const BookTileWidgetFlat({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = item;
    var child = Container(
      height: 70,
      color: AppColors.background,
      child: Row(
        children: [
          SizedBox(width: 8),
          UserAvatarWidget(
            avatar: data.user.avatarUrl,
            height: 48,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  data.name.clip(10, ellipsis: true),
                  style: AppStyles.textStyleB,
                ),
                SizedBox(height: 2),
                Text(
                  "${data.description}",
                  style: AppStyles.textStyleC,
                  // overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  // maxLines: 1,
                ).onlyIf(!GetUtils.isNullOrBlank(data.description)),
              ],
            ),
          ),
        ],
      ),
    );
    return GestureDetector(
      onTap: () {
        var book = data;
        MyRoute.bookDocs(book);
      },
      child: child,
    );
  }
}
