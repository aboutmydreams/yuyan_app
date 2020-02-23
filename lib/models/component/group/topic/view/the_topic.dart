import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/net/requests_api/group/data/one_topic/topic_detail_data.dart';
import 'package:yuyan_app/models/tools/time_cut.dart';
import 'package:yuyan_app/models/widgets_big/html/body_html.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';

class TheTopic extends StatelessWidget {
  const TheTopic({Key key, this.topicDetail}) : super(key: key);
  final TopicDetailJson topicDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 文档标题
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text(
              topicDetail.data.title,
              style: AppStyles.textStyleA,
            ),
          ),

          Row(
            children: <Widget>[
              userAvatar(topicDetail.data.user.avatarUrl),
              SizedBox(width: 10),
              Text(
                topicDetail.data.user.name,
                style: AppStyles.textStyleB,
              ),
              Spacer(),
              Text(
                timeCut(topicDetail.data.updatedAt),
                style: AppStyles.textStyleCC,
              ),
            ],
          ),

          SizedBox(height: 8),

          // 文档内容
          getHtml(context, topicDetail.data.bodyHtml)
          // HtmlWidget(
          //   topicDetail.data.bodyHtml,
          //   bodyPadding: EdgeInsets.all(16),
          //   // webView: true,
          //   onTapUrl: (url) {
          //     openUrl(context, url);
          //   },
          // )
        ],
      ),
    );
  }
}
