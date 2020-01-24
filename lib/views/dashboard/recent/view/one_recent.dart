import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/tools/clear_text.dart';
import 'package:yuyan_app/state_manage/dataManage/data/recent_data.dart';

Widget oneRecent(BuildContext context, Recent data) {
  String action = "${actionType[data.action]}${subjectType[data.subjectType]}";
  String url =
      data.url[0] == '/' ? "https://www.yuque.com" + data.url : data.url;
  return GestureDetector(
    onTap: () {
      openUrl(context, url);
    },
    child: Container(
      height: 70,
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
            child: iconType[data.subjectType],
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    clearText(data.title, 10),
                    style: AppStyles.textStyleB,
                  ),
                ),
                Container(
                  child: Text(
                    action,
                    style: AppStyles.textStyleC,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          data.canEdit
              ? Container(
                  margin: EdgeInsets.only(right: 16),
                  child: IconButton(
                    onPressed: () {
                      openUrl(context, url + "/edit");
                    },
                    color: AppColors.primaryText,
                    icon: Icon(Icons.edit),
                  ),
                )
              : Text("")
        ],
      ),
    ),
  );
}

Map<String, String> actionType = {
  "Follow": "关注了",
  "Update": "更新了",
  "Create": "新建了",
  "Edit": "编辑了",
  "Join": "加入了"
};

Map<String, String> subjectType = {
  "Doc": "文档",
  "Book": "知识库",
  "Sheet": "表格文档",
  "Group": "团队",
  "Design": "画板"
};

Map<String, Icon> iconType = {
  "Doc": Icon(
    Icons.book,
    color: Colors.blue,
  ),
  "Book": Icon(
    Icons.event_note,
    color: Colors.blue,
  ),
  "Sheet": Icon(
    Icons.speaker_notes,
    color: Colors.blue,
  ),
  "Group": Icon(
    Icons.group,
    color: Colors.blue,
  ),
  "Design": Icon(
    Icons.description,
    color: Colors.blue,
  ),
};