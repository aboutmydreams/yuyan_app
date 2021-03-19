import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/open_page.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';

Widget autoText(
    {String title, String des, String user, String userImg, int maxLines: 2}) {
  des ??= "";
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        title,
        maxLines: 1,
        style: AppStyles.textStyleB,
      ),
      SizedBox(height: 2),
      Text(
        des,
        style: AppStyles.textStyleC,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
      SizedBox(height: 8),
      Row(
        children: [
          userAvatar(userImg, height: 22),
          SizedBox(width: 5),
          Text(user, style: AppStyles.textStyleC),
        ],
      )
    ],
  );
}

Widget buildDoc(BuildContext context, Map data) {
  String url =
      "https://www.yuque.com/${data['login']}/${data['bookSlug']}/${data['docId'].toString()}";
  return GestureDetector(
    onTap: () {
      bool onlyUser = data["onlyUser"] ?? false;
      if ((data["type"] == "Doc") || (data["type"] == "doc")) {
      } else {
        openUrl(context, url);
      }
    },
    child: Container(
      margin: EdgeInsets.only(left: 10, top: 6, bottom: 4, right: 10),
      padding: EdgeInsets.only(left: 16, top: 10, bottom: 10, right: 10),
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
      child: (data["cover"] != null) && (data["cover"] != "")
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: autoText(
                    title: data['title'],
                    userImg: data["avatar"],
                    des: data['description'],
                    user: data['user'],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: circularImage(data["cover"]),
                )
              ],
            )
          : autoText(
              title: data['title'],
              userImg: data["avatar"],
              des: data['description'],
              user: data['user'],
            ),
    ),
  );
}
