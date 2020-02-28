import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:yuyan_app/models/component/group/topic/view/the_comment.dart';
import 'package:yuyan_app/models/component/group/topic/view/the_topic.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/net/requests_api/doc/data/comments_data.dart';
import 'package:yuyan_app/models/net/requests_api/group/data/one_topic/topic_comment_data.dart';
import 'package:yuyan_app/models/net/requests_api/group/data/one_topic/topic_detail_data.dart';
import 'package:yuyan_app/models/net/requests_api/group/group.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/menu_item.dart';
import 'package:yuyan_app/models/widgets_small/text_field.dart';

import '../../appUI.dart';

class TopicDetail extends StatefulWidget {
  TopicDetail({Key key, this.groupId, this.iid, this.id}) : super(key: key);
  final int id;
  final int iid;
  final int groupId;

  @override
  _TopicDetailState createState() =>
      _TopicDetailState(groupId: groupId, id: id, iid: iid);
}

class _TopicDetailState extends State<TopicDetail> {
  _TopicDetailState({Key key, this.groupId, this.iid, this.id});
  int groupId;
  int iid;
  int id;

  // 数据
  TopicDetailJson topicDetail;
  Comments topicComments;

  /// [下方抽屉]
  PanelController _pc = PanelController();
  TextEditingController _tc = TextEditingController();

  @override
  void initState() {
    super.initState();
    getTopic();
    getComment();
    _pc = PanelController();
  }

  // @override
  // void dispose() {
  //   _panelController.hide();
  //   super.dispose();
  // }

  getTopic() async {
    TopicDetailJson res =
        await DioGroup.getOneTopicData(groupId: groupId, iid: iid);
    setState(() {
      topicDetail = res;
    });
  }

  getComment() async {
    Comments res = await DioGroup.getComments(id);
    setState(() {
      topicComments = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: _pc,
      minHeight: 0,
      maxHeight: 500,
      panel: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Container(child: Text("data")),
              textfield(controller: _tc),
            ],
          ),
        ),
      ),
      body: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => _pc.open(),
          child: Icon(Icons.add),
        ),
        appBar: AppBar(title: Text("话题详情"), //
            actions: [
              PopupMenuButton(
                itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                  menuItem("A", "打开网页版"),
                ],
                onSelected: (String action) {
                  // 点击选项的时候
                  switch (action) {
                    case 'A':
                      openUrl(context,
                          "https://www.yuque.com/$groupId/topics/$iid");
                      break;
                    case 'B':
                      break;
                    case 'C':
                      break;
                  }
                },
              ),
            ]),
        backgroundColor: AppColors.background,
        body: (topicDetail == null) || (topicComments == null)
            ? loading()
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TheTopic(topicDetail: topicDetail),
                    TheComment(comment: topicComments),
                  ],
                ),
              ),
      ),
    );
  }
}
