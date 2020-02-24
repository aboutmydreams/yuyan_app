import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/group/topic/view/the_comment.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/net/requests_api/doc/data/comments_data.dart';
import 'package:yuyan_app/models/net/requests_api/doc/data/doc_data_v2.dart';
import 'package:yuyan_app/models/net/requests_api/doc/doc.dart';
import 'package:yuyan_app/models/tools/time_cut.dart';
import 'package:yuyan_app/models/widgets_big/html/body_html.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDocContextData();
    getDocComment();
  }

  getDocContextData() async {
    DocV2 docData = await DioDoc.getDocV2(bookId, docId);
    setState(() {
      doc = docData;
    });
  }

  getDocComment() async {
    Comments ans = await DioDoc.getComments(docId);
    setState(() {
      comments = ans;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Abilities theAbileties = doc.abilities;
    return Scaffold(
      appBar: AppBar(
        title: Text('详情'),
      ),
      body: (doc == null) || (comments == null)
          ? loading()
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // 文档标题
                  Container(
                    margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Text(
                      doc.data.title,
                      style: AppStyles.textStyleA,
                    ),
                  ),

                  // 作者
                  Container(
                    padding: EdgeInsets.fromLTRB(16, 5, 16, 3),
                    child: Row(
                      children: <Widget>[
                        userAvatar(doc.data.creator.avatarUrl),
                        SizedBox(width: 10),
                        Text(
                          doc.data.creator.name,
                          style: AppStyles.textStyleB,
                        ),
                        Spacer(),
                        Text(
                          timeCut(doc.data.creator.updatedAt),
                          style: AppStyles.textStyleCC,
                        ),
                      ],
                    ),
                  ),

                  // 文档内容
                  getHtml(
                    context,
                    doc.data.bodyHtml,
                    padding: EdgeInsets.all(16),
                  ),

                  // 评论
                  TheComment(
                    comment: comments,
                  )
                ],
              ),
            ),
    );
  }
}
