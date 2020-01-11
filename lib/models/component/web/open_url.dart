import 'package:flutter/material.dart';
import 'package:yuyan_app/models/browser_web/browser_appbar.dart';

import '../appUI.dart';

openUrl(BuildContext context, String url) {
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
        elevation: 0,
        backgroundColor: AppColors.background,
      ),
    );
  }));
}
