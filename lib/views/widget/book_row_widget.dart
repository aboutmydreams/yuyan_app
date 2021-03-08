import 'package:flutter/material.dart';
import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/util/util.dart';

class BookRowItemWidget extends StatelessWidget {
  final BookSeri book;

  const BookRowItemWidget({
    Key key,
    this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // if (data["type"] == "Book") {
        //   OpenPage.docBook(
        //     context,
        //     bookId: data["bookId"],
        //     bookSlug: data["bookSlug"],
        //     onlyUser: data["onlyUser"],
        //   );
        // } else {
        //   String url =
        //       "https://www.yuque.com/${data["login"]}/${data["bookSlug"]}";
        //   openUrl(context, url);
        // }
      },
      child: Container(
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
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Row(
          children: <Widget>[
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
                  children: <Widget>[
                    Container(
                      child: Text(
                        book.name.clip(10, ellipsis: true),
                        style: AppStyles.textStyleB,
                      ),
                    ),
                    SizedBox(height: 2),
                    if (book.description != null)
                      Container(
                        child: Text(
                          book.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.textStyleC,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
