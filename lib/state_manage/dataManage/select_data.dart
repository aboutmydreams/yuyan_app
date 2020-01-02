import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuyan_app/models/net/requests/dio_requests.dart';
import 'package:yuyan_app/state_manage/get_pref.dart';
import 'package:yuyan_app/views/explore_page/data/selection_data.dart';

class SelectManage extends Model {
  int page = 1;
  SelectionsData _selectData = SelectionsData(data: []);
  SelectionsData get selecData => _selectData;

  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    return File('$path/select.json');
  }

  Future<File> writeCounter(Map counter) async {
    final file = await _localFile;

    // Write the file.
    return file.writeAsString(jsonEncode(counter));
  }

  getSaveData() async {
    // var selectDoc = await getPrefStringData("select_doc");
    // print(json.decode(json.encode(selectDoc.toString())).runtimeType);
    // // print(selectDoc.toString())下面这行会报错 显示decode后仍然为string 原因不明;
    // // 正在寻找其他解决途径 以下没有注释的为解决方案，这个问题先留着
    // SelectionsData selectionsData =
    //     SelectionsData.fromJson(json.decode(selectDoc));
    // _selectData = selectionsData;
    // notifyListeners();
    // return selectionsData;
    var selectDoc = jsonDecode(await (await _localFile).readAsString());
    SelectionsData selectionsData = SelectionsData.fromJson(selectDoc);
    _selectData = selectionsData;
    notifyListeners();
    return selectionsData;
  }

  getMoreData() async {
    page += 1;
    var dioData = await DioReq.get("/explore/selections?limit=1&page=$page");
    SelectionsData selectionsData = SelectionsData.fromJson(dioData);
    _selectData.data.addAll(selectionsData.data);
  }

  saveSelecData() async {
    var dioData = await DioReq.get("/explore/selections?limit=20&page=$page");
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(dioData.runtimeType);
    // prefs.setString("select_doc", dioData.toString());
    await writeCounter(dioData);
    return 1;
  }

  void update() {
    saveSelecData().then((res) {
      getSaveData();
    });
  }
}
