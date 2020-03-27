import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/open_page.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/oauth2/random_string/random_string.dart';
import 'package:yuyan_app/models/tools/clear_text.dart';
import 'package:yuyan_app/models/tools/time_cut.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';
import 'package:yuyan_app/state_manage/dataManage/data/news_data.dart';

class OneNewsContainer extends StatelessWidget {
  OneNewsContainer({Key key, @required this.data, this.unread: true})
      : super(key: key);

  final Notifications data;
  final bool unread;

  @override
  Widget build(BuildContext context) {
    String lastSub = clearSub(data);
    String tag =
        randomString(5) + DateTime.now().microsecondsSinceEpoch.toString();
    return GestureDetector(
      onTap: () {
        if (data.subjectType == "User") {
          OpenPage.user(
            context,
            login: data.actor.login,
            name: data.actor.name,
            avatarUrl: data.actor.avatarUrl,
            userId: data.actor.id,
            tag: tag,
          );
        } else if (data.subjectType == "Doc") {
          OpenPage.doc(
            context,
            bookId: data.subject.bookId,
            docId: data.subject.id,
          );
        } else if (data.subjectType == "Topic") {
          OpenPage.topic(
            context,
            id: data.subjectId,
            iid: data.subject.iid,
            groupId: data.subject.groupId,
          );
        } else {
          // 如果是评论的话 Comment 看 second_subject_type 定位
          // print(data.subjectType);
          var url = "https://www.yuque.com/go/notification/${data.id}";
          openUrl(context, url);
        }
      },
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 16),
        color: AppColors.background,
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                // var url = "https://www.yuque.com/${data.actor.login}";
                // openUrl(context, url);
                if (data.actor != null) {
                  OpenPage.user(
                    context,
                    login: data.actor.login,
                    name: data.actor.name,
                    avatarUrl: data.actor.avatarUrl,
                    userId: data.actor.id,
                    tag: tag,
                  );
                }
              },
              child: Container(
                margin: EdgeInsets.only(right: 20),
                child: Hero(
                  tag: tag,
                  child: userAvatar(
                    data.actor != null
                        ? data.actor.avatarUrl
                        : "https://cdn.nlark.com/yuque/0/2019/png/84147/1547032500238-d93512f4-db23-442f-b4d8-1d46304f9673.png",
                    height: 45,
                  ),
                ),
              ),
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
                        "${data.actor != null ? data.actor.name : '系统消息'}",
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
                        "${newsType[data.notifyType] ?? data.notifyType}$lastSub",
                        style: AppStyles.textStyleC,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.only(right: 15),
                          child: CircleAvatar(
                            radius: 3,
                            backgroundColor:
                                unread ? Colors.red : Colors.transparent,
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
}

// 几种通知
Map<String, String> newsType = {
  "invite_collaborator": "邀请你协作",
  "update_doc": "更新了文档",
  "like_doc": "打赏了稻谷",
  "comment": "评论了话题",
  "mention": "在评论中@了你",
  "new_topic": "新建了讨论",
  "new_book": "新建了知识库",
  "topic_assign": "指派了话题",
  "publish_doc": "发布了文章",
  "watch_book": "关注了知识库",
  "delete_book": "删除了知识库",
  "public_book": "公开了知识库",
  "follow_user": "关注了你",
  "like_artboard": "赞赏了画板稻谷",
  "upload_artboards": "更新了画板",
  "apply_join_group": "申请加入团队",
  "join_group_user": "添加了团队成员",
  "joined_a_group": "将你添加到了团队",
  "group_invitation": "邀请你加入团队",
  "close_topic": "关闭了话题",
  "user_member_will_expire": "会员即将到期",
  "apply_collaborator": "申请文档协作"
};

// 处理了一堆复杂的数据orz
String clearSub(Notifications data) {
  var subTitle = data.secondSubject != null
      ? data.secondSubject.title != null
          ? data.secondSubject.title
          : data.secondSubject.name
      : data.thirdSubject != null
          ? data.subject != null
              ? data.subject.title
              : data.thirdSubject.name != null ? data.thirdSubject.name : null
          : null;
  var thTitle = data.thirdSubject != null
      ? data.thirdSubject.name != null
          ? data.thirdSubject.name
          : data.subject != null ? data.subject.title : null
      : null;

  var title =
      data.subject != null ? data.subject.title ?? data.subject.title : null;

  var lastSub = title ?? subTitle ?? thTitle ?? "";
  lastSub = lastSub != "" ? " [${clearText(lastSub, 10)}]" : "";
  return lastSub;
}
