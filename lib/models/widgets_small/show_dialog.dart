import 'package:flutter/material.dart';

// 使用参考：https://juejin.cn/post/6844903822028963847
showWindow(BuildContext context) {
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: Text("SimpleDialog"),
          titlePadding: EdgeInsets.all(10),
          backgroundColor: Colors.amber,
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6))),
          children: <Widget>[
            ListTile(
              title: Center(
                child: Text("Item_1"),
              ),
            ),
            ListTile(
              title: Center(
                child: Text("Item_2"),
              ),
            ),
            ListTile(
              title: Center(
                child: Text("Item_3"),
              ),
            ),
            ListTile(
              title: Center(
                child: Text("Close"),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}
