import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';

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
  bool isload = true;
  WebViewController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Stack(
        children: <Widget>[
          Positioned(
            child: WebView(
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                _controller = controller;
              },
              onPageFinished: (url) {
                _controller.evaluateJavascript("document.title").then((result) {
                  setState(() {
                    // _title = result;
                    isload = false;
                  });
                });
              },
            ),
          ),
          Positioned(
            child: isload
                ? Center(child: loading())
                : Opacity(
                    opacity: 0,
                    child: Text(""),
                  ),
          ),
        ],
      ),
    );
  }
}
