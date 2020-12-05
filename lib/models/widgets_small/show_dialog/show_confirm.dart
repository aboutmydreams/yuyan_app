import 'package:flutter/material.dart';

void showConfirmDialog(BuildContext context,
    {String content, Function confirmCallback}) {
  showDialog(
    context: context,
    builder: (context) {
      return new AlertDialog(
        title: new Text("提示"),
        content: new Text(content),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              confirmCallback();
              Navigator.of(context).pop();
            },
            child: new Text("确认"),
          ),
          new FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: new Text("取消"),
          ),
        ],
      );
    },
  );
}
