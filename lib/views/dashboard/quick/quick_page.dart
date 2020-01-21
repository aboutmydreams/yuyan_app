import 'package:flutter/material.dart';
import 'package:yuyan_app/state_manage/dataManage/data/quick_data.dart';
import 'package:yuyan_app/state_manage/toppest.dart';
import 'package:yuyan_app/views/dashboard/quick/view/one_quick.dart';

class QuickPage extends StatelessWidget {
  const QuickPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Data> quickDataList = topModel.quickManage.quickData.data;

    return Container(
      child: ListView.builder(
        itemCount: quickDataList.length,
        itemBuilder: (BuildContext context, int index) {
          return oneQuick(context, quickDataList[index]);
        },
      ),
    );
  }
}
