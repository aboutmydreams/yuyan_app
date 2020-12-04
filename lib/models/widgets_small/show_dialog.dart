import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';

import 'list_animation.dart';

// 使用参考：https://juejin.cn/post/6844903822028963847
showWindow(BuildContext context, {String title, List<Widget> children}) {
  children ??= [];
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 12),
          title: Row(
            children: [
              Text(
                title,
                style: AppStyles.textStyleB,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                  ),
                ),
              )
            ],
          ),
          titlePadding: EdgeInsets.fromLTRB(26, 8, 10, 0),
          backgroundColor: AppColors.background,
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6))),
          children: [aniColumn(children: children)],
        );
      });
}
