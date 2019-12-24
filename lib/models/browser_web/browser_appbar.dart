import 'dart:async';

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

  Completer<WebViewController> _controller = Completer<WebViewController>();
  String co;

  @override
  void initState() {
    super.initState();
    Timer dd = Timer(const Duration(milliseconds: 6000), () {
      _controller.future.then((data) {
        _onListCookies(data);
      });
    });
    // print(topic.topicId);
  }

  _onListCookies(WebViewController controller) async {
    final String cookies =
        await controller.evaluateJavascript('document.cookie');
    print(cookies);
    return _getCookieList(cookies);
  }

  _getCookieList(String cookies) {
    if (cookies == null || cookies == '""') {
      return null;
    }
    final List<String> cookieList = cookies.split(';');
    return cookieList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}
