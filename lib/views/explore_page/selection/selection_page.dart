import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/models/net/requests/dio_requests.dart';
import 'package:yuyan_app/state_manage/toppest.dart';
import 'package:yuyan_app/views/explore_page/data/selection_data.dart';

class SelectionPage extends StatefulWidget {
  SelectionPage({Key key}) : super(key: key);

  @override
  _SelectionPageState createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  List<Data> selecdatas;

  // @override
  // void initState() {
  //   super.initState();
  //   getSelecdata();
  // }

  // getSelecdata() async {
  //   var dioData = await DioReq.get("/explore/selections?limit=20");
  //   SelectionsData selectionsData = SelectionsData.fromJson(dioData);
  //   setState(() {
  //     selecdatas = selectionsData.data;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<TopStateModel>(
        builder: (context, child, model) {
      List<Data> selecdatas = model.selectManage.selecData.data;
      return ListView.builder(
        itemCount: selecdatas.length,
        itemBuilder: (BuildContext context, int index) {
          return Text("${selecdatas[index].title}");
        },
      );
    });
  }
}
