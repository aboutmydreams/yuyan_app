import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/net/requests_api/doc/data/doc_data_v2.dart';
import 'package:yuyan_app/models/net/requests_api/doc/doc.dart';

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

  DocDataV2 theDoc = DocDataV2(title: "", bodyHtml: "<p>loading</p>");
  Abilities theAbileties = Abilities(destroy: false, update: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDocContextData();
  }

  getDocContextData() async {
    DocV2 docData = await DioDoc.getDocV2(bookId, docId);
    print(docData.data.title);
    setState(() {
      theDoc = docData.data;
      theAbileties = docData.abilities;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('详情'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 文档标题
            Container(
              margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text(
                theDoc.title,
                style: AppStyles.textStyleA,
              ),
            ),

            // 文档内容
            HtmlWidget(
              theDoc.bodyHtml,
              bodyPadding: EdgeInsets.all(16),
              webView: true,
              onTapUrl: (url) {
                openUrl(context, url);
              },
            )
          ],
        ),
      ),
    );
  }
}
