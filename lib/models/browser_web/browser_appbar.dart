import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
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

  final AppBar appbar;
  String url;
  double progress = 0;
  bool isload = true;
  InAppWebViewController _webController;
  String jsCode =
      'document.getElementById("header").style.display="none";document.getElementById("footer").style.display="none";';

  @override
  void initState() {
    super.initState();
    hideJs();
  }

  @override
  void dispose() {
    super.dispose();
  }

  hideJs() {
    Timer(Duration(milliseconds: 1000), () async {
      _webController.evaluateJavascript(source: jsCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Stack(
        children: <Widget>[
          Positioned(
            child: InAppWebView(
              initialUrl: url,
              initialOptions: InAppWebViewGroupOptions(
                android: AndroidInAppWebViewOptions(
                  databaseEnabled: true,
                  domStorageEnabled: true,
                ),
                ios: IOSInAppWebViewOptions(
                  disallowOverScroll: true,
                  enableViewportScale: true,
                  suppressesIncrementalRendering: true,
                  alwaysBounceVertical: true,
                  allowsLinkPreview: false,
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
              onLoadStart:
                  (InAppWebViewController controller, String otherUrl) {
                print(otherUrl);
                setState(() {
                  this.url = otherUrl;
                });
              },
              onLoadStop:
                  (InAppWebViewController controller, String url) async {
                // 页面加载完成后注入js方法, 获取页面总高度
                // 文档标题："document.title"
                var height = await _webController.evaluateJavascript(
                  source: """document.body.scrollHeight;""",
                );
                double theWebH = double.parse(height.toString());
                setState(() {
                  isload = false;
                });
              },
              onProgressChanged:
                  (InAppWebViewController controller, int progress) async {
                if (progress > 85) {
                  setState(() {
                    this.progress = progress / 100;
                    print(this.progress);
                  });
                }
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
