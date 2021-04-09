import 'package:flutter/material.dart';
import 'package:yuyan_app/config/app_ui.dart';

class CommentTextfierd extends StatefulWidget {
  CommentTextfierd(
      {Key key,
      this.hintText: "说点什么吧⋯⋯",
      this.w: 340,
      this.controller,
      this.maxLines: 3,
      this.focusNode})
      : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final FocusNode focusNode;
  final double w;
  final int maxLines;

  @override
  _CommentTextfierdState createState() => _CommentTextfierdState(
      hintText: hintText,
      w: w,
      controller: controller,
      maxLines: maxLines,
      focusNode: focusNode);
}

class _CommentTextfierdState extends State<CommentTextfierd> {
  _CommentTextfierdState(
      {Key key,
      this.hintText: "说点什么吧⋯⋯",
      this.w: 340,
      this.controller,
      this.maxLines: 3,
      this.focusNode});

  final TextEditingController controller;
  final String hintText;
  final FocusNode focusNode;
  final double w;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        maxLines: maxLines,
        // 是否自动更正
        autocorrect: true,
        // 是否自动对焦
        // autofocus: autofocus,
        focusNode: focusNode,
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
