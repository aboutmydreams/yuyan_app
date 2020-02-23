import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/net/requests_api/group/data/one_topic/topic_detail_data.dart';
import 'package:yuyan_app/models/widgets_big/html/body_html.dart';

class TheTopic extends StatelessWidget {
  const TheTopic({Key key, this.topicDetail}) : super(key: key);
  final TopicDetailJson topicDetail;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // 文档标题
        Container(
          margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Text(
            topicDetail.data.title,
            style: AppStyles.textStyleA,
          ),
        ),

        // 文档内容
        getHtml(context, topicDetail.data.bodyHtml)
        // HtmlWidget(
        //   topicDetail.data.bodyHtml,
        //   bodyPadding: EdgeInsets.all(16),
        //   webView: true,
        //   onTapUrl: (url) {
        //     openUrl(context, url);
        //   },
        // ),
      ],
    );
  }
}
