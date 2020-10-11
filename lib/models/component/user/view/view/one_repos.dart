import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/open_page.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/tools/clear_text.dart';

Widget oneRepos(BuildContext context, Map data) {
  return GestureDetector(
    onTap: () {
      if (data["type"] == "Book") {
        OpenPage.docBook(
          context,
          bookId: data["bookId"],
          bookSlug: data["bookSlug"],
        );
      } else {
        String url =
            "https://www.yuque.com/${data["login"]}/${data["bookSlug"]}";
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
            child: AppIcon.iconType(data["type"]),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 16),
              child:
                  (data["description"] != null) && (data["description"] != "")
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                clearText(data["name"], 10),
                                style: AppStyles.textStyleB,
                              ),
                            ),
                            SizedBox(height: 2),
                            Container(
                              child: Text(
                                "${data["description"]}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppStyles.textStyleC,
                              ),
                            ),
                          ],
                        )
                      : Container(
                          child: Text(
                            "${data["name"]}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.textStyleB,
                          ),
                        ),
            ),
          ),
        ],
      ),
    ),
  );
}
