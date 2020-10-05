import 'package:flutter/material.dart';

import '../tabbar_config.dart';

Widget suggestList(BuildContext context, {String query, Function onTap}) {
  return ListView.builder(
    itemCount: searchAll.keys.length,
    itemBuilder: (context, index) => ListTile(
      title: RichText(
        text: TextSpan(
          text: "搜索 ",
          style: TextStyle(color: Colors.grey),
          children: [
            TextSpan(
              text: query + " ",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: searchAll.keys.toList()[index],
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
      trailing: Icon(searchAll.values.toList()[index]),
      focusColor: Colors.amber,
      onTap: () {
        onTap(context, text: query, index: index);
      },
    ),
  );
}
