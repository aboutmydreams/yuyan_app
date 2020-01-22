import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/tools/clear_text.dart';
import 'package:yuyan_app/state_manage/dataManage/data/recent_data.dart';

Widget oneRecent(BuildContext context, Recent data) {
  print(data.title);
  return GestureDetector(
    onTap: () {
      var url =
          data.url[0] == '/' ? "https://www.yuque.com" + data.url : data.url;
      openUrl(context, url);
    },
    child: Container(
      height: 50,
      margin: EdgeInsets.only(left: 5, top: 2, bottom: 8, right: 5),
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
            margin: EdgeInsets.only(left: 20),
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
  "Design": "assets/images/dashboard/design.png"
};
