import 'package:flutter/material.dart';

Widget userAvatar(String imgUrl) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(19),
    child: Container(
      width: 38,
      height: 38,
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
