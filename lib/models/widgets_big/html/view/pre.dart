import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';

Widget preHtml(BuildContext context, String outerHtml) {
  return Container(
    constraints:
        BoxConstraints(minWidth: MediaQuery.of(context).size.width - 20),
    color: Colors.grey[200],
    child: Html(
      data:outerHtml,
      // bodyPadding: EdgeInsets.all(16),
      // webView: true,
      // onTapUrl: (url) {
      //   openUrl(context, url);
      // },
    ),
  );
}
