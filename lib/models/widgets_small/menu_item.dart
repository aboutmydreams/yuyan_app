import 'package:flutter/material.dart';

PopupMenuItem<String> menuItem(String id, String title) {
  return PopupMenuItem(
    value: id,
    child: Row(
      children: [
        Text('$title'),
      ],
    ),
  );
}
