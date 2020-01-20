import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/net/requests/dio_requests.dart';
import 'package:yuyan_app/state_manage/toppest.dart';
import 'package:yuyan_app/state_manage/dataManage/data/selection_data.dart';
import 'package:yuyan_app/views/explore_page/selection/view/first_item.dart';
import 'package:yuyan_app/views/explore_page/selection/view/sec_item.dart';

class SelectionPage extends StatefulWidget {
  SelectionPage({Key key}) : super(key: key);

  @override
  _SelectionPageState createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true; //非常重要
  List<Data> selecdatas;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ScopedModelDescendant<TopStateModel>(
        builder: (context, child, model) {
      List<Data> selecdatas = model.selectManage.selectData.data;
      return Scaffold(
        backgroundColor: AppColors.background,
        body: ListView.builder(
          itemCount: selecdatas.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return firstItemUI(context, selecdatas[index]);
            } else {
              return secItemUI(context, selecdatas[index]);
            }
          },
        ),
      );
    });
  }
}
