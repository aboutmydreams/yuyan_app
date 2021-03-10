import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' hide WebView;
import 'package:get/get.dart';

class EmbedWebviewPage extends StatefulWidget {
  final String url;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final bool lockUrl;
  final Function(String) onUrlChanged;
  final Widget header;

  const EmbedWebviewPage({
    Key key,
    this.url,
    this.header,
    this.lockUrl = true,
    this.margin = const EdgeInsets.all(8),
    this.padding = EdgeInsets.zero,
    this.onUrlChanged,
  }) : super(key: key);

  @override
  _EmbedWebviewPageState createState() => _EmbedWebviewPageState();
}

class _EmbedWebviewPageState extends State<EmbedWebviewPage> {
  @override
  Widget build(BuildContext context) {
    debugPrint('webview: ${widget.url}');
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      margin: widget.margin,
      padding: widget.padding,
      child: Column(
        children: [
          if (widget.header != null) widget.header,
          SizedBox(
            height: Get.width,
            child: InAppWebView(
              initialUrl: widget.url,
              onScrollChanged: (c, x, y) {
                debugPrint('onscroll: ($x,$y)');
              },
              onLoadStart: (c, url) {
                if (url != widget.url) {
                  if (widget.lockUrl) c.goBack();
                  widget.onUrlChanged?.call(url);
                }
                debugPrint('page load!: $url');
              },
              gestureRecognizers: {
                Factory(() => EagerGestureRecognizer()),
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WebviewPage extends StatefulWidget {
  final String url;

  const WebviewPage({
    Key key,
    this.url,
  }) : super(key: key);

  @override
  _WebviewPageState createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  var _url = ''.obs;
  var _title = ''.obs;
  InAppWebViewController _controller;

  @override
  void initState() {
    super.initState();
    _url.value = widget.url;
    _title.value = widget.url;
    debugPrint('webview: ${widget.url}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(_title.value),
        ),
      ),
      body: Container(
        child: InAppWebView(
          initialUrl: widget.url,
          onTitleChanged: (c, title) {
            _title.value = title;
          },
          onLoadStart: (c, url) {
            _url.value = url;
          },
          onWebViewCreated: (c) {
            _controller = c;
          },
        ),
      ),
    );
  }
}
