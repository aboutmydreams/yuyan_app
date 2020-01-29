import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
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

  String kHtml = "<p>loading</p>";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDocContextData();
  }

  getDocContextData() async {
    DocV2 docData = await DioDoc.getDocV2(bookId, docId);
    print(docData.data.bodyHtml);
    setState(() {
      kHtml = docData.data.bodyHtml;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HelloWorldScreen'),
      ),
      body: SingleChildScrollView(
        child: HtmlWidget(
          kHtml,
          webView: true,
          onTapUrl: (url) {
            openUrl(context, url);
          },
        ),
      ),
    );
  }
}
