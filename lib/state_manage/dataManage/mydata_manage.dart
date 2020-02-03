import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuyan_app/models/net/requests/dio_requests.dart';
import 'package:yuyan_app/models/net/requests_api/user/data/profile_data.dart';
import 'package:yuyan_app/models/tools/write_json.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/group/group_data.dart';

import 'data/my_page/my_data.dart';

class MyInfoManage extends Model {
  MyInfoData _myInfoData = MyInfoData();
  ProfileData _profileData = ProfileData();
  Group _groupData = Group();
  MyInfoData get myInfoData => _myInfoData;
  ProfileData get profileData => _profileData;
  Group get groupData => _groupData;

  getSaveData() async {
    var myInfoDoc = await readJson('myInfo');
    var myProfileDoc = await readJson('myProfile');
    var myGroup = await readJson('myGroup');
    MyInfoData myInfoData = MyInfoData.fromJson(myInfoDoc);
    ProfileData myProfileData = ProfileData.fromJson(myProfileDoc);
    Group myGroupData = Group.fromJson(myGroup);

    _myInfoData = myInfoData;
    _profileData = myProfileData;
    _groupData = myGroupData;
    notifyListeners();
    return 1;
  }

  saveMyInfoData() async {
    // 先获取个人 id 与 login 并缓存
    // 知识库 follow 页面要用
    // 为什么不写在这个 manage 里面是出于在满足一级页面UI的数据基础上减少 init 流量。
    var dioData = await DioReq.get("/v2/user");
    int myId = dioData["data"]["id"];
    String login = dioData["data"]["login"];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("my_id", myId);
    prefs.setString("login", login);

    // 地址、职业的信息根据 id 从 profile 中取得
    var profileData = await DioReq.get("/users/$myId/profile?");
    var groupData = await DioReq.get("/users/$myId/groups?limit=1000&offset=0");
    await writeJson('myInfo', dioData);
    await writeJson('myProfile', profileData);
    await writeJson('myGroup', groupData);
    return 1;
  }

  void update() {
    saveMyInfoData().then((res) {
      getSaveData();
    });
  }
}
