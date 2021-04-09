import 'package:flutter/material.dart';
import 'package:yuyan_app/config/app_ui.dart';
import 'package:yuyan_app/models/net/requests_api/doc/data/doc_data_v2.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';
import 'package:yuyan_app/util/time_cut.dart';

Widget docTitle(String text) {
  return Container(
    margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
    child: Text(
      text,
      style: AppStyles.textStyleA,
    ),
  );
}

Widget docAuthor(DocDataV2 docv2) {
  return Container(
    padding: EdgeInsets.fromLTRB(16, 5, 16, 3),
    child: Row(
      children: <Widget>[
        userAvatar(docv2.creator.avatarUrl),
        SizedBox(width: 10),
        Text(
          docv2.creator.name,
          style: AppStyles.textStyleB,
        ),
        SizedBox(width: 10),
        Text(
          timeCut(docv2.creator.updatedAt),
          style: AppStyles.textStyleCC,
        ),
      ],
    ),
  );
}
