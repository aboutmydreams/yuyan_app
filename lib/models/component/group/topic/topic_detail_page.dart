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
import 'package:yuyan_app/models/net/requests_api/user/user.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/menu_item.dart';
import 'package:yuyan_app/models/widgets_small/text_field.dart';
import 'package:yuyan_app/models/widgets_small/toast.dart';

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

  // 下方抽屉
  PanelController _pc = PanelController();
  TextEditingController _tc = TextEditingController();

  @override
  void initState() {
    super.initState();
    getTopic();
    getComment();
    _pc = PanelController();
  }

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

  pulishComment(String com) async {
    print("pulish");
    var ans = await DioUser.addComment(
        type: "Topic", comment: com, commentId: id, parentId: null);
    return ans;
  }

  _pulishClickListener() async {
    if (_tc.text.length == 0) {
      myToast(context, "评论不能为空");
      return null;
    } else {
      pulishComment(_tc.text).then((ans) {
        if (ans) {
          _pc.close();
          getComment();
        }
      });
      // setState(() {
      //   // topicComments.data.add(CommentData());
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return SlidingUpPanel(
      controller: _pc,
      minHeight: 0,
      // maxHeight: MediaQuery.of(context).viewInsets.bottom,
      panel: Scaffold(
        body: Container(
          height: 110,
          margin: EdgeInsets.only(top: 26),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: w * 0.80,
                padding: EdgeInsets.fromLTRB(w * 0.02, 16, w * 0.02, 12),
                child: textfield(
                  controller: _tc,
                  w: w * 0.76,
                ),
              ),
              Container(
                height: 100,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.20,
                      child: FlatButton.icon(
                        onPressed: () {
                          _pc.close();
                        },
                        icon: Icon(Icons.swap_vert),
                        label: Text("收起", style: AppStyles.textStyleBBB),
                        padding: EdgeInsets.all(0),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.16,
                      child: FlatButton(
                        onPressed: _pulishClickListener,
                        autofocus: true,
                        color: AppColors.primary,
                        textColor: Colors.white.withAlpha(235),
                        child: Text("发表"),
                      ),
                    )
                  ],
                ),
              )
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
