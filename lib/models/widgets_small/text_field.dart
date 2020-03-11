import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';

class CommentTextfierd extends StatelessWidget {
  const CommentTextfierd(
      {Key key,
      this.hintText: "说点什么吧⋯⋯",
      this.w: 340,
      this.controller,
      this.autofocus: false})
      : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final bool autofocus;
  final double w;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        maxLines: 3,
        // 是否自动更正
        autocorrect: true,
        // 是否自动对焦
        autofocus: autofocus,
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
          hintText: hintText,
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
}
