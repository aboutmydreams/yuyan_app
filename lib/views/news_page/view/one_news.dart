import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/tools/time_cut.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';
import 'package:yuyan_app/models/widgets_small/user_event.dart';
import 'package:yuyan_app/state_manage/dataManage/data/news_data.dart';

Widget oneNews(BuildContext context, Notifications data) {
  print(data.secondSubject == null ? 0 : data.secondSubject.name);
  return GestureDetector(
    onTap: () {
      print("objec!t");
      var url = "https://www.yuque.com/go/notification/${data.id}";
    },
    child: Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 16),
      color: AppColors.background,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 20),
            child: userAvatar(data.actor.avatarUrl, height: 45),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width - 81,
                height: 26,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${data.actor.name}",
                      style: AppStyles.textStyleB,
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.only(right: 12),
                        child: Text(
                          "${timeCut(data.createdAt)}",
                          style: AppStyles.textStyleCC,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 81,
                height: 24,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${newsType[data.notifyType] ?? data.notifyType}",
                      style: AppStyles.textStyleC,
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.only(right: 15),
                        child: CircleAvatar(
                          radius: 3,
                          backgroundColor: Colors.red,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}

// 几种通知
Map<String, String> newsType = {
  "update_doc": "更新了文档",
  "like_doc": "打赏了稻谷",
  "publish_doc": "发布了文章",
  "watch_book": "关注了知识库",
  "follow_user": "关注了你",
  "like_artboard": "给你的画板赞赏了稻谷",
  "upload_artboards": "更新了画板",
  "apply_join_group": "申请加入团队"
};
