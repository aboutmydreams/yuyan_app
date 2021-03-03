import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/models/net/requests/dio_requests.dart';
import 'package:yuyan_app/util/write_json.dart';
import 'package:yuyan_app/state_manage/dataManage/data/recent_data.dart';

class RecentManage extends Model {
  int offset = 0;
  RecentJson _recentData = RecentJson(data: []);

  RecentJson get recentData => _recentData;

  getSaveData() async {
    var recentDoc = await readJson('recent');
    RecentJson recentionsData = RecentJson.fromJson(recentDoc);
    _recentData = recentionsData;
    notifyListeners();
    return recentionsData;
  }

  getMoreData() async {
    offset += 20;
    var dioData = await DioReq.get(
        "/mine/recent?limit=20&offset=$offset&type=group%2Cbook%2Cdesign%2Csheet%2Cdoc%2Cresourcee");
    RecentJson recentionsData = RecentJson.fromJson(dioData);
    _recentData.data.addAll(recentionsData.data);
    notifyListeners();
  }

  saveRecentData() async {
    var dioData = await DioReq.get(
        "/mine/recent?limit=20&offset=0&type=group%2Cbook%2Cdesign%2Csheet%2Cdoc%2Cresource");
    await writeJson('recent', dioData);
    return 1;
  }

  void update() {
    saveRecentData().then((res) {
      getSaveData();
    });
  }
}
