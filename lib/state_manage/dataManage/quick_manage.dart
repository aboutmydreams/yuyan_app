// https://www.yuque.com/api/quick_links

import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/models/net/requests/dio_requests.dart';
import 'package:yuyan_app/models/tools/write_json.dart';
import 'package:yuyan_app/state_manage/dataManage/data/quick_data.dart';

class QuickManage extends Model {
  int page = 1;
  QuickData _quickData = QuickData(data: []);
  QuickData get quickData => _quickData;

  getSaveData() async {
    var quickDoc = await readJson('quick');
    QuickData quickData = QuickData.fromJson(quickDoc);
    _quickData = quickData;
    notifyListeners();
    return quickData;
  }

  saveQuictData() async {
    var dioData = await DioReq.get("/quick_links?");
    await writeJson('quick', dioData);
    return 1;
  }

  addQuick({Function callback}) async {
    var dioData = await DioReq.post("/quick_links");
    if (dioData["data"].containsKey("id")) {
      callback();
    }
  }

  void update() {
    saveQuictData().then((res) {
      getSaveData();
    });
  }
}
