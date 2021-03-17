import 'dart:io';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:package_info/package_info.dart';
import 'package:webview_flutter/webview_flutter.dart' as web;
import 'package:yuyan_app/config/net/token.dart';
import 'package:yuyan_app/controller/global/organization_controller.dart';
import 'package:yuyan_app/controller/global/my_controller.dart';

class App {
  static TokenProvider tokenProvider = TokenProvider();
  static OrgSpaceProvider orgSpaceProvider = OrgSpaceProvider();
  static MyUserProvider user = MyUserProvider();

  static PackageInfo version;

  static init() async {
    version = await PackageInfo.fromPlatform();

    // web.WebView.platform = web.SurfaceAndroidWebView();

    // if(Platform.isAndroid){
    //   await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    // }
  }
}

class Config {
  static get webview => InAppWebViewGroupOptions(
        // crossPlatform: InAppWebViewOptions(
        //   userAgent:
        //       'Mozilla/5.0 AppleWebKit/537.36 Chrome/88.0.4324.181 Mobile Safari/537.36 Yuyan',
        // ),
        // android: AndroidInAppWebViewOptions(
          // useHybridComposition: false,
        // ),
      );
}
