import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';

Widget threeWidget(BuildContext context) {
  return Container(
    child: Column(
      children: <Widget>[
        oneColumn(context, text: "建议与反馈", width: 250),
        oneColumn(context, text: "关于语燕", width: 250),
        oneColumn(context, text: "设置", width: 250)
      ],
    ),
  );
}

Widget oneColumn(BuildContext context,
    {String text, double width, String routeName}) {
  return Container(
    width: width,
    height: 59,
    margin: EdgeInsets.only(top: 20, bottom: 5),
    decoration: BoxDecoration(
      color: AppColors.background,
      boxShadow: [
        BoxShadow(
          color: Color.fromARGB(255, 187, 187, 187),
          offset: Offset(1, 2),
          blurRadius: 4,
        ),
      ],
      borderRadius: BorderRadius.all(Radius.circular(29.5)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(left: 22),
          child: Text(
            "$text",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.accentText,
              fontFamily: "PingFang SC",
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
        Spacer(),
        Container(
          width: 16,
          margin: EdgeInsets.only(right: 16),
          child: Icon(Icons.arrow_right),
        ),
      ],
    ),
  );
}
