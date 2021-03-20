import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';

Widget setBottom(BuildContext context) {
  return Container(
    height: 70,
    child: IconButton(
        onPressed: () {
          Navigator.pushNamed(context, "/quickset");
        },
        icon: Icon(
          Icons.settings,
          color: AppColors.primaryText,
        )),
  );
}
