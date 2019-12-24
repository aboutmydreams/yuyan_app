import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BrowserWithBar extends StatelessWidget {
  const BrowserWithBar({Key key, this.url, this.appbar}) : super(key: key);

  final String url;
  final AppBar appbar;

  _onListCookies(WebViewController controller, BuildContext context) async {
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
      ),
    );
  }
}
