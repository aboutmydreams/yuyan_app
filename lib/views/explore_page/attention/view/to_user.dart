import 'package:flutter/material.dart';
import 'package:yuyan_app/state_manage/dataManage/data/attent_data.dart';

Widget toUser(BuildContext context, Data data) {
  print(data.avatarUrl);
  return Container(
    child: Text(data.who),
  );
}
