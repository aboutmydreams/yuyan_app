import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BrowserWithBar extends StatefulWidget {
  BrowserWithBar({Key key, this.url, this.appbar}) : super(key: key);
  final String url;
  final AppBar appbar;

  @override
  _BrowserWithBarState createState() =>
      _BrowserWithBarState(url: url, appbar: appbar);
}

class _BrowserWithBarState extends State<BrowserWithBar> {
  _BrowserWithBarState({this.url, this.appbar});

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
