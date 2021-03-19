// import 'package:flutter/material.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';
// import 'package:yuyan_app/models/component/web/open_url.dart';
// import 'package:yuyan_app/models/net/requests_api/doc/data/comments_data.dart';
// import 'package:yuyan_app/models/net/requests_api/group/data/one_topic/topic_detail_data.dart';
// import 'package:yuyan_app/models/net/requests_api/group/group.dart';
// import 'package:yuyan_app/models/net/requests_api/user/user.dart';
// import 'package:yuyan_app/util/report.dart';
// import 'package:yuyan_app/models/widgets_small/loading.dart';
// import 'package:yuyan_app/models/widgets_small/menu_item.dart';
// import 'package:yuyan_app/models/widgets_small/toast.dart';
//
// import '../../appUI.dart';
//
// class TopicDetail extends StatefulWidget {
//   TopicDetail({Key key, this.groupId, this.iid, this.id}) : super(key: key);
//   final int id;
//   final int iid;
//   final int groupId;
//
//   @override
//   _TopicDetailState createState() =>
//       _TopicDetailState(groupId: groupId, id: id, iid: iid);
// }
//
// class _TopicDetailState extends State<TopicDetail> {
//   _TopicDetailState({Key key, this.groupId, this.iid, this.id});
//
//   int groupId;
//   int iid;
//   int id;
//
//   // 数据
//   TopicDetailJson topicDetail;
//   Comments topicComments;
//
//   // 下方抽屉
//   PanelController _pc = PanelController();
//   FocusNode myFocusNode;
//   TextEditingController _tc = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     myFocusNode = FocusNode();
//     getTopic();
//     getComment();
//     _pc = PanelController();
//   }
//
//   @override
//   void dispose() {
//     // Clean up the focus node when the Form is disposed.
//     myFocusNode.dispose();
//
//     super.dispose();
//   }
//
//   getTopic() async {
//     TopicDetailJson res =
//         await DioGroup.getOneTopicData(groupId: groupId, iid: iid);
//     setState(() {
//       topicDetail = res;
//     });
//   }
//
//   getComment() async {
//     Comments res = await DioGroup.getComments(commentId: id);
//     setState(() {
//       topicComments = res;
//     });
//   }
//
//   pulishComment(String com) async {
//     var ans = await DioUser.addComment(
//         type: "Topic", comment: com, commentId: id, parentId: null);
//     return ans;
//   }
//
//   _pulishClickListener() async {
//     if (_tc.text.length == 0) {
//       myToast(context, "评论不能为空");
//       return null;
//     } else {
//       pulishComment(_tc.text).then((ans) {
//         if (ans) {
//           _pc.close();
//           _tc.clear();
//           FocusScope.of(context).requestFocus(FocusNode());
//           getComment();
//         }
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SlidingUpPanel(
//       controller: _pc,
//       minHeight: 0,
//       // maxHeight: MediaQuery.of(context).viewInsets.bottom,
//       panel: HidePanel(
//         textControl: _tc,
//         panelControl: _pc,
//         onpressed: _pulishClickListener,
//         focusNode: myFocusNode,
//       ),
//       body: Scaffold(
//         backgroundColor: AppColors.background,
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             _pc.open();
//             myFocusNode.requestFocus();
//             setState(() {
//               myFocusNode.requestFocus();
//               // FocusScope.of(context).requestFocus(FocusNode());
//             });
//           },
//           child: Icon(Icons.add),
//         ),
//         appBar: AppBar(title: Text("话题详情"), //
//             actions: [
//               PopupMenuButton(
//                 itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
//                   menuItem("A", "打开网页版"),
//                   menuItem("B", "举报话题"),
//                 ],
//                 onSelected: (String action) {
//                   // 点击选项的时候
//                   switch (action) {
//                     case 'A':
//                       openUrl(context,
//                           "https://www.yuque.com/$groupId/topics/$iid");
//                       break;
//                     case 'B':
//                       fakeReport(context);
//                   }
//                 },
//               ),
//             ]),
//         body: (topicDetail == null) || (topicComments == null)
//             ? loading()
//             : SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                   ],
//                 ),
//               ),
//       ),
//     );
//   }
// }
