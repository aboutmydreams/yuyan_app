import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BrowserWithBar extends StatelessWidget {
  const BrowserWithBar({Key key, this.url, this.appbar}) : super(key: key);

  final String url;
  final AppBar appbar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
