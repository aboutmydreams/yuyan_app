import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/util/styles/app_ui.dart';
import 'package:yuyan_app/util/util.dart';

class BookRowItemWidget extends StatelessWidget {
  final BookSeri book;

  const BookRowItemWidget({
    Key key,
    this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookTile = Row(
      children: [
        Text(
          book.name,
          maxLines: 1,
          style: AppStyles.textStyleB,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(width: 2),
        Icon(
          Icons.lock_rounded,
          size: 16,
        ).onlyIf(
          book.public == 0,
        ),
      ],
    );

    final child = Container(
      height: 70,
      margin: EdgeInsets.only(left: 15, top: 10, right: 15),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: 26),
            child: AppIcon.iconType(book.type),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  bookTile,
                  SizedBox(height: 2),
                  Container(
                    child: Text(
                      book.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.textStyleC,
                    ),
                  ).onlyIf(
                    !GetUtils.isNullOrBlank(book.description),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return GestureDetector(
      onTap: () {
        MyRoute.bookDocs(book);
      },
      child: child,
    );
  }
}
