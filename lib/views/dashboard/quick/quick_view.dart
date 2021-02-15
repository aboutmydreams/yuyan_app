import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/state_manage/dataManage/quick_manage.dart';
import 'package:yuyan_app/views/dashboard/quick/view/note_quick.dart';
import 'package:yuyan_app/views/dashboard/quick/view/one_quick.dart';
import 'package:yuyan_app/views/dashboard/quick/view/set_buttom.dart';

class QuickView extends StatefulWidget {
  QuickView({Key key}) : super(key: key);

  @override
  _QuickViewState createState() => _QuickViewState();
}

class _QuickViewState extends State<QuickView> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<QuickManage>(builder: (context, child, model) {
      return model.quickData.data.isNotEmpty
          ? Container(
              height: 70,
              color: AppColors.eventBack,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: model.quickData.data.map((res) {
                  return oneQuick(context, res);
                }).toList()
                  ..add(setBottom(context))
                  ..insert(0, NoteButton())
                  ..insert(0, quickText("快捷入口")),
              ),
            )
          : Container(
              height: 70,
              color: AppColors.background,
              child: Row(
                children: <Widget>[quickText("设置快捷入口"), setBottom(context)],
              ),
            );
    });
  }
}

Widget quickText(String text) {
  return Container(
    height: 70,
    margin: EdgeInsets.only(left: 20, right: 10),
    child: Center(
      child: Text(
        "$text",
        style: AppStyles.textStyleB,
      ),
    ),
  );
}
