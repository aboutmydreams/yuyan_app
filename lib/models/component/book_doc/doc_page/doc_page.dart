import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/book_doc/doc_page/view/doc_title.dart';
import 'package:yuyan_app/models/component/book_doc/doc_page/view/floating_collapsed.dart';
import 'package:yuyan_app/models/component/group/topic/view/the_comment.dart';
import 'package:yuyan_app/models/component/group/topic/view/the_panel.dart';
import 'package:yuyan_app/models/net/requests_api/doc/data/comments_data.dart';
import 'package:yuyan_app/models/net/requests_api/doc/data/doc_data_v2.dart';
import 'package:yuyan_app/models/net/requests_api/doc/doc.dart';
import 'package:yuyan_app/models/net/requests_api/user/user.dart';
import 'package:yuyan_app/models/widgets_big/html/body_html.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/toast.dart';

class DocPage extends StatefulWidget {
  DocPage({Key key, this.bookId, this.docId}) : super(key: key);

  final int bookId;
  final int docId;

  @override
  _DocPageState createState() => _DocPageState(bookId: bookId, docId: docId);
}

class _DocPageState extends State<DocPage> {
  _DocPageState({Key key, this.bookId, this.docId});
  final int bookId;
  final int docId;

  // DocDataV2 theDoc = DocDataV2(title: "", bodyHtml: "<p>loading</p>");
  // Abilities theAbileties = Abilities(destroy: false, update: false);
  DocV2 doc;
  Comments comments;

  // 浏览量 点赞 收藏
  int hits = 0;
  int likeCount = 0;
  bool ifMark = false;
  bool ifLike = false;

  // 下方抽屉
  PanelController _pc = PanelController();
  TextEditingController _tc = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDocContextData();
    getIfLike();
    getIfMark();
    getDocComment();
  }

  getDocContextData() async {
    DocV2 docData = await DioDoc.getDocV2(bookId, docId);
    setState(() {
      doc = docData;
    });
  }

  getDocComment() async {
    Comments ans = await DioUser.getComments(docId: docId);
    var theHit = await DioDoc.getHits(docId: docId);

    setState(() {
      comments = ans;
      hits = theHit;
    });
  }

  getIfMark() async {
    var ans = await DioUser.ifMark(targetId: docId);
    setState(() {
      ifMark = ans;
    });
  }

  changeMark() async {
    if (ifMark) {
      setState(() {
        ifMark = !ifMark;
      });
      var ans = await DioUser.cancelMark(targetId: docId);
    } else {
      setState(() {
        ifMark = !ifMark;
      });
      var ans = await DioUser.mark(targetId: docId);
    }
  }

  getIfLike() async {
    Map ifLikeIt = await DioDoc.getAction(docId: docId);
    setState(() {
      ifLike = ifLikeIt["like"];
      likeCount = ifLikeIt["count"];
    });
  }

  changeLike() async {
    if (ifLike) {
      setState(() {
        ifLike = !ifLike;
        likeCount -= 1;
      });
      var ans = await DioUser.deleteLike(docId: docId);
    } else {
      setState(() {
        ifLike = !ifLike;
        likeCount += 1;
      });
      var ans = await DioUser.addLike(docId: docId);
    }
  }

  // 点击下方评论
  clickBottom() {
    _pc.open();
  }

  pulishComment(String com) async {
    var ans = await DioUser.addComment(
        type: "Doc", comment: com, commentId: docId, parentId: null);
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
          getDocComment();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Abilities theAbileties = doc.abilities;
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    return SlidingUpPanel(
      controller: _pc,
      minHeight: 0,
      // maxHeight: MediaQuery.of(context).viewInsets.bottom,// 键盘
      panel: HidePanel(
        textControl: _tc,
        panelControl: _pc,
        onpressed: _pulishClickListener,
      ),
      borderRadius: radius,
      body: Scaffold(
        appBar: AppBar(
          title: Text("详情"),
        ),
        body: (doc == null) || (comments == null)
            ? loading()
            : Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    bottom: 60,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // 文档标题
                          docTitle(doc.data.title),

                          // 作者
                          docAuthor(doc.data),

                          // 文档内容
                          getHtml(
                            context,
                            doc.data.bodyHtml,
                            padding: EdgeInsets.all(16),
                          ),

                          // 浏览 评论数
                          Container(
                            margin: EdgeInsets.only(left: 16),
                            child: Row(
                              children: <Widget>[
                                Text(
                                    "浏览量 $hits   评论 ${comments.data.length}   稻谷 ${likeCount * 7}",
                                    style: AppStyles.textStyleC),
                              ],
                            ),
                          ),

                          // 评论
                          TheComment(
                            comment: comments,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: FloatingCollaps(
                      onTap: clickBottom,
                      ifLike: ifLike,
                      ifMark: ifMark,
                      markFunc: changeMark,
                      likeFunc: changeLike,
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
