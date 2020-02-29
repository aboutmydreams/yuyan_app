import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';

Widget textfield({
  TextEditingController controller,
  String hintText: "评论",
  double w: 340,
}) {
  return Container(
    width: w,
    child: TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      maxLines: 3,
      // 是否自动更正
      autocorrect: true,
      // 是否自动对焦
      autofocus: true,
      decoration: InputDecoration(
        // labelText: "标 题",
        // labelStyle: TextStyle(textBaseline: TextBaseline.alphabetic),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        contentPadding: EdgeInsets.all(15.0),
        hintText: ' Ready to drive a car',
        hintStyle: TextStyle(
          color: Colors.black26,
          fontSize: 16,
        ),
      ),
      // 输入样式
      style: AppStyles.textStyleBBB,
    ),
  );
}
