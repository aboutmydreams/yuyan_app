import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_color/smart_color.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/model/topic/labels.dart';
import 'package:yuyan_app/model/topic/topic.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/widget/user_widget.dart';

class TopicRowItemWidget2 extends StatelessWidget {
  final TopicSeri topic;

  TopicRowItemWidget2({
    Key key,
    this.topic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // OpenPage.topic(
        //   context,
        //   id: data.id,
        //   groupId: data.groupId,
        //   iid: data.iid,
        // );
      },
      child: Container(
        // height: 70,
        margin: EdgeInsets.only(left: 15, top: 10, right: 15),
        padding: EdgeInsets.only(left: 15, top: 12, bottom: 10, right: 15),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    topic.title.clip(15, ellipsis: true),
                    style: AppStyles.textStyleB,
                  ),
                ),
                SizedBox(height: 3),
                if (!GetUtils.isNullOrBlank(topic.labels))
                  RichText(
                    text: TextSpan(
                      children: topic.labels.map((e) {
                        return _label(e);
                      }).toList(),
                    ),
                  ),
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
            Spacer(),
            Container(
              margin: EdgeInsets.only(right: 4),
              width: 45,
              child: Row(
                children: <Widget>[
                  Container(
                    child: Icon(
                      Icons.question_answer,
                      size: 19,
                    ),
                  ),
                  SizedBox(width: 7),
                  Text("${topic.commentsCount}")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  InlineSpan _label(LabelSeri label) {
    return TextSpan(
      text: ' ${label.name} ',
      style: TextStyle(
        backgroundColor: SmartColor.parse(
          label.color,
        ),
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
                  avatar: data.user.avatarUrl,
                  height: 25,
                ),
                SizedBox(width: 8),
                Text(
                  data.user.name,
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
