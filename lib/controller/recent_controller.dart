import 'package:get/get.dart';
import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/config/storage_manager.dart';
import 'package:yuyan_app/config/viewstate/view_controller.dart';
import 'package:yuyan_app/model/dashboard/user_recent_seri.dart';

// class RecentManage extends Model {
//   int offset = 0;
//   RecentJson _recentData = RecentJson(data: []);
//
//   RecentJson get recentData => _recentData;
//
//   getSaveData() async {
//     var recentDoc = await readJson('recent');
//     RecentJson recentionsData = RecentJson.fromJson(recentDoc);
//     _recentData = recentionsData;
//     notifyListeners();
//     return recentionsData;
//   }
//
//   getMoreData() async {
//     offset += 20;
//     var dioData = await DioReq.get(
//         "/mine/recent?limit=20&offset=$offset&type=group%2Cbook%2Cdesign%2Csheet%2Cdoc%2Cresourcee");
//     RecentJson recentionsData = RecentJson.fromJson(dioData);
//     _recentData.data.addAll(recentionsData.data);
//     notifyListeners();
//   }
//
//   saveRecentData() async {
//     var dioData = await DioReq.get(
//         "/mine/recent?limit=20&offset=0&type=group%2Cbook%2Cdesign%2Csheet%2Cdoc%2Cresource");
//     await writeJson('recent', dioData);
//     return 1;
//   }
//
//   void update() {
//     saveRecentData().then((res) {
//       getSaveData();
//     });
//   }
// }

class RecentDataProvider extends BaseSaveListJson<UserRecentSeri> {
  @override
  List<UserRecentSeri> convert(json) {
    return (json as List).map((e) => UserRecentSeri.fromJson(e)).toList();
  }

  @override
  String get key => 'user_recent';
}

class RecentController extends FetchSavableController<RecentDataProvider> {
  static RecentController get to => Get.find();

  void remove(UserRecentSeri item){
    value.remove(item);
    update();
  }

  RecentController()
      : super(
          initialRefresh: true,
          initData: RecentDataProvider(),
        );

  @override
  Future fetchMore() async {
    return ApiRepository.getUserRecentList(offset: value.length);
  }

  @override
  Future fetchData() {
    return ApiRepository.getUserRecentList();
  }
}
