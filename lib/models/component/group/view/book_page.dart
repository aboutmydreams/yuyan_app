import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/open_page.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/net/requests_api/group/data/group_book_data.dart';
import 'package:yuyan_app/models/tools/clear_text.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/nothing.dart';

class BookPage extends StatefulWidget {
  BookPage({Key key, this.bookJson}) : super(key: key);
  final GroupBookJson bookJson;

  @override
  _BookPageState createState() => _BookPageState(bookJson: bookJson);
}

class _BookPageState extends State<BookPage> {
  _BookPageState({Key key, this.bookJson});
  GroupBookJson bookJson;

  @override
  Widget build(BuildContext context) {
    return bookJson == null
        ? loading()
        : bookJson.data.isEmpty
            ? NothingPage(top: 190, text: "知识库空空")
            : SingleChildScrollView(
                child: aniColumn(
                  aniWhich: 4,
                  children: [SizedBox(height: 155)]
                    ..addAll(bookJson.data.map((a) {
                      return oneBook(context, a);
                    }).toList()),
                ),
              );
  }
}

Widget oneBook(BuildContext context, BookData data) {
  return GestureDetector(
    onTap: () {
      if (data.type == "Book") {
        OpenPage.docBook(
          context,
          bookId: data.id,
          bookSlug: data.slug,
        );
      } else {
        String url = "https://www.yuque.com/${data.user.login}/${data.slug}";
        openUrl(context, url);
      }
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
          SizedBox(width: 20),
          Container(
            margin: EdgeInsets.only(left: 6),
            child: AppIcon.iconType(data.type),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 20),
              child: (data.description != null) && (data.description != "")
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            clearText(data.name, 10),
                            style: AppStyles.textStyleB,
                          ),
                        ),
                        SizedBox(height: 2),
                        Container(
                          child: Text(
                            "${data.description}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.textStyleC,
                          ),
                        ),
                      ],
                    )
                  : Container(
                      child: Text(
                        "${data.name}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.textStyleB,
                      ),
                    ),
            ),
          ),
          // FollowButtom(data: data)
        ],
      ),
    ),
  );
}
