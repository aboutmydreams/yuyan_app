import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/models/net/requests/dio_requests.dart';
import 'package:yuyan_app/models/tools/write_json.dart';
import 'package:yuyan_app/state_manage/dataManage/data/selection_data.dart';

class SelectManage extends Model {
  int page = 1;
  SelectionsData _selectData = SelectionsData(data: []);
  SelectionsData get selecData => _selectData;

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
    var selectDoc = await readJson('select');
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
    await writeJson('select', dioData);
    return 1;
  }

  void update() {
    saveSelecData().then((res) {
      getSaveData();
    });
  }
}
