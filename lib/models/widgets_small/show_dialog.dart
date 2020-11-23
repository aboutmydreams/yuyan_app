import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';

// 使用参考：https://juejin.cn/post/6844903822028963847
showWindow(BuildContext context, {String title, List<Widget> children}) {
  children ??= [];
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: Text(
            title,
            style: AppStyles.textStyleB,
          ),
          titlePadding: EdgeInsets.fromLTRB(16, 20, 0, 0),
          backgroundColor: AppColors.background,
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6))),
          children: []
            ..addAll(children)
            ..add(Center(
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              ),
            )),
        );
      });
}
