import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuyan_app/models/net/requests/dio_requests.dart';
import 'package:yuyan_app/state_manage/get_pref.dart';
import 'package:yuyan_app/views/explore_page/data/selection_data.dart';

class SelectManage extends Model {
  int page = 1;
  SelectionsData _selectData = SelectionsData(data: []);
  SelectionsData get selecData => _selectData;

  getSaveData() async {
    var selectDoc = await getPrefStringData("select_doc");
    SelectionsData selectionsData =
        SelectionsData.fromJson(json.decode(selectDoc));
    _selectData = selectionsData;
    notifyListeners();
    return selectionsData;
  }

  getMoreData() async {
    page += 1;
    var dioData = await DioReq.get("/explore/selections?limit=20&page=$page");
    SelectionsData selectionsData = SelectionsData.fromJson(dioData);
    _selectData.data.addAll(selectionsData.data);
  }

  saveSelecData() async {
    var dioData = await DioReq.get("/explore/selections?limit=20&page=$page");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("select_doc", dioData.toString());
    return 1;
  }

  void update() {
    saveSelecData().then((res) {
      getMoreData();
    });
  }
}
