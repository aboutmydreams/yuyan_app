import 'package:flutter/material.dart';

Widget memberIcon(BuildContext context) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      width: 21,
      height: 23,
      margin: EdgeInsets.only(left: 13),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(20, 0, 0, 0),
            offset: Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Image.asset(
        "assets/images/my_page/member.png",
        fit: BoxFit.cover,
      ),
    ),
  );
}
