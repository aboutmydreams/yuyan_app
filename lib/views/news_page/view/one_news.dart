import 'package:flutter/material.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/model/document/doc.dart';
import 'package:yuyan_app/model/document/organization_lite.dart';
import 'package:yuyan_app/model/document/user.dart';
import 'package:yuyan_app/model/notification/notification_item.dart';
import 'package:yuyan_app/config/app_ui.dart';
import 'package:yuyan_app/model/topic/topic.dart';
import 'package:yuyan_app/util/time_cut.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/widget/user_widget.dart';

class NotificationItemWidget extends StatelessWidget {
  // 几种通知
  final Map<String, String> newsType = {
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
    "private_book": "取消公开了知识库",
    "rename_book": "重命名了知识库",
    "follow_user": "关注了你",
    "like_artboard": "赞赏了画板稻谷",
    "upload_artboards": "更新了画板",
    "apply_join_group": "申请加入团队",
    "new_group_member": "邀请新成员加入团队",
    "join_organization_user": "加入了组织成员",
    "join_group_user": "加入了团队成员",
    "joined_a_group": "将你添加到了团队",
    "join_collaborator": "加入了协作",
    "group_invitation": "邀请你加入团队",
    "close_topic": "关闭了话题",
    "reopen_topic": "重新开启了话题",
    "user_member_will_expire": "会员即将到期",
    "system": "系统通知",
    "apply_collaborator": "申请文档协作",
    "remove_from_a_group": "移出了团队"
  };

  NotificationItemWidget({
    Key key,
    @required this.data,
    this.unread = false,
  }) : super(key: key);

  final NotificationItemSeri data;
  final bool unread;

  @override
  Widget build(BuildContext context) {
    // String lastSub = clearSub(data);
    String tag = Util.genHeroTag();

    final userAvatar = GestureDetector(
      onTap: () {
        if (data.actor != null) {
          MyRoute.user(
            user: data.actor.toUserLiteSeri(),
            heroTag: tag,
          );
        }
      },
      child: Container(
        margin: EdgeInsets.only(right: 20),
        child: Hero(
          tag: tag,
          child: UserAvatarWidget(
            avatar: data.actor?.avatarUrl,
            height: 45,
          ),
        ),
      ),
    );

    final titleWidget = Row(
      children: [
        Expanded(
          child: Text(
            "${data.actor != null ? data.actor.name : '系统消息'}",
            style: AppStyles.textStyleB,
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 12),
          child: Text(
            "${timeCut(data.createdAt)}",
            style: AppStyles.textStyleCC,
          ),
        )
      ],
    );
    final notifySub = getNotificationSub();
    final contentWidget = Row(
      children: [
        Expanded(
          child: Text(
            "${newsType[data.notifyType] ?? data.notifyType}"
            "${notifySub.onlyIf(notifySub == '', elseif: () => ' [$notifySub]')}",
            style: AppStyles.textStyleC,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 15),
          child: CircleAvatar(
            radius: 3,
            backgroundColor: unread ? Colors.red : Colors.transparent,
          ),
        )
      ],
    );

    return GestureDetector(
      onTap: () {
        switch (data.subjectType) {
          case 'User':
            return MyRoute.user(
              user: data.actor.toUserLiteSeri(),
              heroTag: tag,
            );
          case 'Doc':
            throw 'unImplement';
          case 'Topic':
            var topic = data.subject.serialize<TopicSeri>();
            return MyRoute.topic(topic.iid, topic.groupId);
          case 'Comment':
            if (data.secondSubjectType == 'Topic') {
              var item = data.secondSubject.serialize<TopicSeri>();
              return MyRoute.topic(item.iid, item.groupId);
            }
        }
        return Util.goUrl('/go/notification/${data.id}');
        // if (((data.subjectType == "Comment") &&
        //     (data.secondSubjectType == "Doc"))) {
        //   // 如果是评论的话 Comment 看 second_subject_type 定位
        //   // print(data.subjectType);
        //   OpenPage.docWeb(
        //     context,
        //     login: data.thirdSubject.user.login,
        //     bookSlug: data.thirdSubject.slug,
        //     bookId: data.thirdSubjectId,
        //     docId: data.secondSubjectId,
        //   );
        // }
      },
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 16),
        color: AppColors.background,
        child: Row(
          children: [
            userAvatar,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 26,
                    child: titleWidget,
                  ),
                  Container(
                    height: 24,
                    child: contentWidget,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getNotificationSub() {
    switch (data.subjectType) {
      case 'User':
        return data.subject.serialize<UserSeri>().name;
      case 'Doc':
        return data.subject.serialize<DocSeri>().title;
      case 'Book':
        return data.subject.serialize<BookSeri>().name;
      case 'Topic':
        var topic = data.subject.serialize<TopicSeri>();
        return topic.title;
      case 'OrganizationUser':
        var org = data.secondSubject.serialize<OrganizationLiteSeri>();
        return org.name;
      case 'Comment':
        if (data.secondSubjectType == 'Topic') {
          var item = data.secondSubject.serialize<TopicSeri>();
          return item.title;
        } else if (data.secondSubjectType == 'Doc') {
          var item = data.secondSubject.serialize<DocSeri>();
          return item.title;
        }
    }
    return '';
  }
}
