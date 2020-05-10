import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:share/share.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:yuyan_app/models/component/book_doc/doc_page/view/comment_panel.dart';
import 'package:yuyan_app/models/component/book_doc/doc_page/view/floating_collapsed.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/net/requests_api/doc/data/comments_data.dart';
import 'package:yuyan_app/models/net/requests_api/doc/data/doc_data_v2.dart';
import 'package:yuyan_app/models/net/requests_api/doc/doc.dart';
import 'package:yuyan_app/models/net/requests_api/user/user.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/menu_item.dart';
import 'package:yuyan_app/models/widgets_small/toast.dart';

class DocPageWeb extends StatefulWidget {
  DocPageWeb(
      {Key key, this.login, this.bookSlug, this.url, this.bookId, this.docId})
      : super(key: key);

  final int bookId;
  final int docId;
  final String url;
  final String login;
  final String bookSlug;

  @override
  _DocPageWebState createState() => _DocPageWebState(
      login: login, bookSlug: bookSlug, url: url, bookId: bookId, docId: docId);
}

class _DocPageWebState extends State<DocPageWeb> {
  _DocPageWebState(
      {Key key, this.login, this.bookSlug, this.url, this.bookId, this.docId});
  final int bookId;
  final int docId;
  final String login;
  final String url;
  final String bookSlug;

  Comments comments = Comments(data: []);
  DocV2 doc;

  // 浏览量 点赞 收藏
  int hits = 0;
  int likeCount = 0;
  bool ifMark = false;
  bool ifLike = false;

  // 下方抽屉
  PanelController _pc = PanelController();
  TextEditingController _tc = TextEditingController();

  bool useWebView = true;
  String theUrl = "https://yuque.com/";
  String shareUrl = "https://yuque.com/";
  double progress = 0;
  InAppWebViewController _webController;

  @override
  void initState() {
    super.initState();
    // doc：https://pub.dev/documentation/flutter_inappwebview/latest/
    theUrl = url ??
        "https://www.yuque.com/$login/$bookSlug/$docId?view=doc_embed&from=yuyan&title=1&outline=1";
    theUrl = theUrl.contains("view=doc_embed")
        ? theUrl
        : theUrl + "?view=doc_embed&from=yuyan&title=1&outline=1";
    shareUrl =
        theUrl.replaceAll("?view=doc_embed&from=yuyan&title=1&outline=1", "");
    getIfLike();
    getIfMark();
    getDocComment();
    getDocContextData();
  }

  @override
  void dispose() {
    super.dispose();
    _webController = null;
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
          // 关闭抽屉，清空输入
          _pc.close();
          _tc.clear();
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
      maxHeight: MediaQuery.of(context).size.height * 0.8,
      backdropEnabled: true,
      // MediaQuery.of(context).size.height * 0.4 + 132,
      // maxHeight: MediaQuery.of(context).viewInsets.bottom, // 键盘
      panelBuilder: (ScrollController sc) => CommentPanel(
        scrollController: sc,
        textControl: _tc,
        panelControl: _pc,
        onpressed: _pulishClickListener,
        comments: comments,
      ),
      borderRadius: radius,
      body: Scaffold(
        appBar: AppBar(
          title: Text("详情"),
          actions: <Widget>[
            PopupMenuButton(
              itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                menuItem("A", "打开网页版"),
                menuItem("B", "从浏览器打开"),
                menuItem("C", "复制文档链接"),
                menuItem("D", "分享"),
              ],
              onSelected: (String action) {
                // 点击选项的时候
                switch (action) {
                  case 'A':
                    openUrl(context, shareUrl);
                    break;
                  case 'B':
                    openUrlOuter(shareUrl);
                    break;
                  case 'C':
                    Clipboard.setData(new ClipboardData(text: shareUrl));
                    myToast(context, "已复制剪贴板");
                    break;
                  case 'D':
                    Share.share(
                        '我上分享了语雀文档「${doc != null ? doc.data.title : '文档'}」快来瞧瞧！ $shareUrl');
                    break;
                }
              },
            ),
          ],
        ),
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              bottom: 60,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 30,
                padding: EdgeInsets.all(16),
                color: Colors.white,
                child: InAppWebView(
                  initialUrl: theUrl,
                  initialOptions: InAppWebViewWidgetOptions(
                    android: AndroidInAppWebViewOptions(
                      databaseEnabled: true,
                      domStorageEnabled: true,
                    ),
                    crossPlatform: InAppWebViewOptions(
                      debuggingEnabled: true,
                      cacheEnabled: true,
                      transparentBackground: true,
                      javaScriptCanOpenWindowsAutomatically: true,
                      horizontalScrollBarEnabled: false,
                      contentBlockers: [],
                    ),
                  ),
                  initialHeaders: {},
                  onWebViewCreated: (InAppWebViewController controller) {
                    _webController = controller;
                  },
                  onLoadStart: (InAppWebViewController controller, String url) {
                    setState(() {
                      this.theUrl = url;
                    });
                  },
                  onLoadStop:
                      (InAppWebViewController controller, String url) async {
                    // 页面加载完成后注入js方法, 获取页面总高度
                    var height = await _webController.evaluateJavascript(
                      source: """
                              document.body.scrollHeight;
                            """,
                    );
                    double theWebH = double.parse(height.toString());
                  },
                  onProgressChanged:
                      (InAppWebViewController controller, int progress) {
                    if (progress > 85) {
                      setState(() {
                        this.progress = progress / 100;
                        print(this.progress);
                      });
                    }
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: FloatingCollaps(
                onTap: clickBottom,
                ifLike: ifLike,
                ifMark: ifMark,
                commentCount: comments.data.length,
                markFunc: changeMark,
                likeFunc: changeLike,
              ),
            ),
            Positioned(
              top: 0,
              child: progress < 0.85
                  ? Container(
                      height: MediaQuery.of(context).size.height - 100,
                      width: MediaQuery.of(context).size.width,
                      child: loading(),
                    )
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
