import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yuyan_app/models/browser_web/browser_appbar.dart';

import '../appUI.dart';

openUrl(BuildContext context, String url, {title: ""}) {
  print(url);
  return Navigator.of(context).push(MaterialPageRoute(builder: (_) {
    return BrowserWithBar(
      url: url,
      appbar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(title),
        elevation: 0,
        backgroundColor: AppColors.background,
      ),
    );
  }));
}

openUrlOuter(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
