import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/models/net/requests/dio_requests.dart';
import 'package:yuyan_app/models/tools/write_json.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_data.dart';

class MyInfoManage extends Model {
  MyInfoData _myInfoData = MyInfoData();
  MyInfoData get myInfoData => _myInfoData;

  getSaveData() async {
    var myInfoDoc = await readJson('myInfo');
    MyInfoData myInfoionsData = MyInfoData.fromJson(myInfoDoc);
    _myInfoData = myInfoionsData;
    notifyListeners();
    return myInfoionsData;
  }

  saveMyInfoData() async {
    var dioData = await DioReq.get("/v2/user");
    await writeJson('myInfo', dioData);
    return 1;
  }

  void update() {
    saveMyInfoData().then((res) {
      getSaveData();
    });
  }
}
