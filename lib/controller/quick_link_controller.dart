// https://www.yuque.com/api/quick_links

import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/config/storage_manager.dart';
import 'package:yuyan_app/config/viewstate/view_controller.dart';
import 'package:yuyan_app/config/viewstate/view_state.dart';
import 'package:yuyan_app/model/dashboard/quick_link_seri.dart';

class QuickLinkDataProvider extends BaseSaveListJson<QuickLinkSeri> {
  @override
  List<QuickLinkSeri> convert(json) {
    return (json as List).map((e) => QuickLinkSeri.fromJson(e)).toList();
  }

  @override
  String get key => 'user_quick_links';
}

class QuickLinkController
    extends FetchSavableController<QuickLinkDataProvider> {
  QuickLinkController()
      : super(
          initData: QuickLinkDataProvider(),
          initialRefresh: true,
          state: ViewState.loading,
        );

  @override
  Future fetchMore() {
    throw UnimplementedError();
  }

  @override
  Future fetchData() {
    return ApiRepository.getUserQuickLinkList();
  }
}
//
// class QuickManage extends Model {
//   int page = 1;
//   QuickData _quickData = QuickData(data: []);
//
//   QuickData get quickData => _quickData;
//
//   getSaveData() async {
//     var quickDoc = await readJson('quick');
//     QuickData quickData = QuickData.fromJson(quickDoc);
//     _quickData = quickData;
//     notifyListeners();
//     return quickData;
//   }
//
//   saveQuictData() async {
//     var dioData = await DioReq.get("/quick_links?");
//     await writeJson('quick', dioData);
//     return 1;
//   }
//
//   addQuick({Function callback}) async {
//     var dioData = await DioReq.post("/quick_links");
//     if (dioData["data"].containsKey("id")) {
//       callback();
//     }
//   }
//
//   void update() {
//     saveQuictData().then((res) {
//       getSaveData();
//     });
//   }
// }
