import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_color/smart_color.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/model/document/user.dart';
import 'package:yuyan_app/model/topic/labels.dart';
import 'package:yuyan_app/model/topic/topic.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/widget/user_widget.dart';

class TopicTileWidget extends StatelessWidget {
  final TopicSeri topic;
  final bool showLabel;

  TopicTileWidget({
    Key key,
    this.topic,
    this.showLabel = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget ans = Container(
      padding: EdgeInsets.only(left: 16, right: 4),
      alignment: Alignment.centerRight,
      width: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.question_answer, size: 16),
          Text(
            "${topic.commentsCount}",
            style: AppStyles.textStyleCC,
          )
        ],
      ),
    );
    Widget user = Row(
      children: [
        UserAvatarWidget(
          avatar: topic.user.avatarUrl,
          height: 18,
        ),
        SizedBox(width: 4),
        Container(
          child: Text(
            "${topic.user.name} 创建于 ${Util.timeCut(topic.createdAt)}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.textStyleCC,
          ),
        ),
      ],
    );
    Widget child = Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    '${topic.title}',
                    style: AppStyles.textStyleB,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 3),
                if (showLabel && !GetUtils.isNullOrBlank(topic.labels))
                  _labels(topic.labels),
                SizedBox(height: 3),
                user,
              ],
            ),
          ),
          ans,
        ],
      ),
    );
    return GestureDetector(
      onTap: () {
        MyRoute.topic(topic.iid, topic.groupId);
      },
      child: child,
    );
  }

  Widget _labels(List<LabelSeri> labels) {
    return RichText(
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      text: TextSpan(
        children: labels.map((e) {
          return TextSpan(
            text: ' ${e.name} ',
            style: TextStyle(
              backgroundColor: SmartColor.parse(e.color),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class TopicRowItemWidget2 extends StatelessWidget {
  final TopicSeri topic;

  TopicRowItemWidget2({
    Key key,
    this.topic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget ans = Container(
      margin: EdgeInsets.only(right: 8),
      width: 35,
      child: Row(
        children: [
          Icon(Icons.question_answer, size: 16),
          Expanded(
            child: Text(
              "${topic.commentsCount}",
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
    );
    Widget child = Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  topic.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.textStyleB,
                ),
              ),
              SizedBox(height: 3),
              if (!GetUtils.isNullOrBlank(topic.labels)) _labels(topic.labels),
              SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  UserAvatarWidget(
                    avatar: topic.user.avatarUrl,
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    margin: EdgeInsets.only(left: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 2),
                        Container(
                          child: Text(
                            "${topic.user.name} 创建于 ${Util.timeCut(topic.createdAt)}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.textStyleC,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ans,
      ],
    );
    return GestureDetector(
      onTap: () => MyRoute.topic(topic.iid, topic.groupId),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(25, 0, 0, 0),
              offset: Offset(1, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: child,
      ),
    );
  }

  Widget _labels(List<LabelSeri> labels) {
    return RichText(
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      text: TextSpan(
        children: labels.map((e) {
          return TextSpan(
            text: ' ${e.name} ',
            style: TextStyle(
              backgroundColor: SmartColor.parse(e.color),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class TopicRowItemWidget extends StatelessWidget {
  final TopicSeri data;

  const TopicRowItemWidget({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    data.labels ??= [];

    UserSeri user = data.user ?? data.group.toUserSeri();

    return GestureDetector(
      onTap: () {
        // var url = "https://www.yuque.com/${data.group.login}/topics/${data.iid}";
        // openUrl(context, url);
        // OpenPage.topic(
        //   context,
        //   id: data.id,
        //   iid: data.iid,
        //   groupId: data.groupId,
        // );
        MyRoute.topic(data.iid, data.groupId);
      },
      child: Container(
        margin: EdgeInsets.only(top: 2, bottom: 9, left: 10, right: 10),
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.background,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(25, 0, 0, 0),
              offset: Offset(1, 2),
              blurRadius: 4,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(9.5)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                UserAvatarWidget(
                  avatar: user.avatarUrl,
                  height: 25,
                ),
                SizedBox(width: 8),
                Text(
                  user.name,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.textStyleC,
                )
              ],
            ),
            SizedBox(height: 6),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: data.title + "  ",
                    style: AppStyles.textStyleB,
                  ),
                ]..addAll(data.labels.map(label)),
              ),
            ),
            SizedBox(height: 2),
          ],
        ),
      ),
    );
  }

  TextSpan label(LabelSeri label) {
    return TextSpan(
      text: label.name,
      style: TextStyle(
        backgroundColor: SmartColor.parse(
          label.color,
        ),
      ),
    );
  }
}
