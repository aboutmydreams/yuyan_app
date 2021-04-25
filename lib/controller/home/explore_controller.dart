import 'package:get/get.dart';
import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/config/storage_manager.dart';
import 'package:yuyan_app/config/viewstate/view_controller.dart';
import 'package:yuyan_app/config/viewstate/view_state.dart';
import 'package:yuyan_app/model/document/doc.dart';
import 'package:yuyan_app/model/serializer/serializer.dart';
//
// class SelectManage extends Model {
//   int page = 1;
//   SelectionsData _selectData = SelectionsData(data: []);
//
//   SelectionsData get selectData => _selectData;
//
//   getSaveData() async {
//     // var selectDoc = await getPrefStringData("select_doc");
//     // print(json.decode(json.encode(selectDoc.toString())).runtimeType);
//     // // print(selectDoc.toString())下面这行会报错 显示decode后仍然为string 原因不明;
//     // // 正在寻找其他解决途径 以下没有注释的为解决方案，这个问题先留着
//     // SelectionsData selectionsData =
//     //     SelectionsData.fromJson(json.decode(selectDoc));
//     // _selectData = selectionsData;
//     // notifyListeners();
//     // return selectionsData;
//     var selectDoc = await readJson('select');
//     SelectionsData selectionsData = SelectionsData.fromJson(selectDoc);
//     _selectData = selectionsData;
//     notifyListeners();
//     return selectionsData;
//   }
//
//   getMoreData() async {
//     page += 1;
//     var dioData = await DioReq.get(
//         "https://www.yuque.com/api/explore/selections?limit=1&page=$page");
//     SelectionsData selectionsData = SelectionsData.fromJson(dioData);
//     _selectData.data.addAll(selectionsData.data);
//     notifyListeners();
//   }
//
//   saveSelectData() async {
//     var dioData = await DioReq.get(
//         "https://www.yuque.com/api/explore/selections?limit=20&page=$page");
//     // SharedPreferences prefs = await SharedPreferences.getInstance();
//     // print(dioData.runtimeType);
//     // prefs.setString("select_doc", dioData.toString());
//     await writeJson('select', dioData);
//     return 1;
//   }
//
//   void update() {
//     saveSelectData().then((res) {
//       getSaveData();
//     });
//   }
// }

class DiscoverSelectionProvider extends BaseSaveListJson<DocSeri> {
  @override
  List<DocSeri> convert(json) {
    return (json as List).map((e) => DocSeri.fromJson(e)).toList();
  }

  @override
  String get key => 'discover_selection';
}

/// 语雀精选
class ExploreSelectionController
    extends FetchSavableController<DiscoverSelectionProvider> {
  ExploreSelectionController()
      : super(
          initData: DiscoverSelectionProvider(),
          initialRefresh: true,
        );

  @override
  Future fetchMore() {
    throw UnimplementedError();
  }

  @override
  Future fetchData() {
    return ApiRepository.getExploreSelections();
  }
}

/// 语雀推荐
class DiscoverRecommendProvider extends BaseSaveListJson<Serializer> {
  @override
  String get key => 'discover_recommend';

  @override
  List<Serializer> convert(json) {
    return (json as List).map((e) => Serializer.fromJson(e)).toList();
  }
}

class ExploreRecommendController
    extends FetchSavableController<DiscoverRecommendProvider> {
  ExploreRecommendController()
      : super(
          initialRefresh: true,
          initData: DiscoverRecommendProvider(),
          state: ViewState.loading,
        );

  int _page = 1;

  @override
  onRefreshCallback() {
    super.onRefreshCallback();
    Get.find<ExploreSelectionController>().onRefreshCallback();
  }

  @override
  Future fetchMore() async {
    _page++;
    var data =
        await ApiRepository.getExploreRecommends(page: _page, isDoc: true);
    return data;
  }

  @override
  Future fetchData() async {
    var data = await ApiRepository.getExploreRecommends();
    _page = 1;
    return data;
  }
}
