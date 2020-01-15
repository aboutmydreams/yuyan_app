import 'package:flutter/material.dart';

Widget userAvatar(String imgUrl, {double height}) {
  height ??= 38;
  return ClipRRect(
    borderRadius: BorderRadius.circular(height / 2),
    child: Container(
      width: height,
      height: height,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(128, 116, 116, 116),
            offset: Offset(0, 0),
            blurRadius: 1,
          ),
        ],
      ),
      child: ClipOval(
        child: FadeInImage.assetNetwork(
          image: imgUrl,
          placeholder: 'assets/images/explore/book.png',
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}
