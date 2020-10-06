import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/open_page.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/tools/clear_text.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/group/group_data.dart';
import 'package:yuyan_app/state_manage/dataManage/data/quick_data.dart';

Widget oneQuick(BuildContext context, Data data) {
  String imageUrl = data.icon.toString().contains("http")
      ? data.icon
      : iconType[data.type] ?? "assets/images/dashboard/book.png";
  return GestureDetector(
    onTap: () {
      if (data.type == "Group") {
        OpenPage.group(
          context,
          groupdata: GroupData(
            id: data.targetId,
            name: data.title ?? "",
            avatarUrl: data.icon,
          ),
        );
      } else if (data.type == "Book") {
        OpenPage.docBook(
          context,
          bookId: data.targetId,
          bookSlug: data.url.split("/").last,
        );
      } else {
        String url =
            data.url[0] == '/' ? "https://www.yuque.com" + data.url : data.url;
        openUrl(context, url);
      }
    },
    child: Container(
      height: 50,
      margin: EdgeInsets.only(left: 5, top: 10, bottom: 10, right: 5),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(25, 0, 0, 0),
            offset: Offset(1, 2),
            blurRadius: 4,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: userAvatar(imageUrl, height: 50),
          ),
          Container(
            margin: EdgeInsets.only(right: 20),
            child: Text(
              clearText(data.title, 6),
              style: AppStyles.textStyleB,
            ),
          )
        ],
      ),
    ),
  );
}

Map<String, String> iconType = {
  "Normal": "assets/images/dashboard/link.png",
  "Design": "assets/images/dashboard/design.png",
  "Book": "assets/images/dashboard/book.png"
};
