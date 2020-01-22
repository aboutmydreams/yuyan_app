import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/models/net/requests/dio_requests.dart';
import 'package:yuyan_app/models/tools/write_json.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/profile/profile_data.dart';
import 'data/my_page/my_data.dart';

class MyInfoManage extends Model {
  MyInfoData _myInfoData = MyInfoData();
  ProfileData _profileData = ProfileData();
  MyInfoData get myInfoData => _myInfoData;
  ProfileData get profileData => _profileData;

  getSaveData() async {
    var myInfoDoc = await readJson('myInfo');
    var myProfileDoc = await readJson('myProfile');
    MyInfoData myInfoData = MyInfoData.fromJson(myInfoDoc);
    ProfileData myProfileData = ProfileData.fromJson(myProfileDoc);
    _myInfoData = myInfoData;
    _profileData = myProfileData;
    notifyListeners();
    return 1;
  }

  saveMyInfoData() async {
    var dioData = await DioReq.get("/v2/user");
    int myId = dioData["data"]["id"];

    // 地址、职业的信息根据 id 从 profile 中取得
    var profileData = await DioReq.get("/users/$myId/profile?");
    await writeJson('myInfo', dioData);
    await writeJson('myProfile', profileData);
    return 1;
  }

  void update() {
    saveMyInfoData().then((res) {
      getSaveData();
    });
  }
}
