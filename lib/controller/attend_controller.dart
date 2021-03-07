import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/config/storage_manager.dart';
import 'package:yuyan_app/config/viewstate/view_fetch_controller.dart';
import 'package:yuyan_app/config/viewstate/view_state.dart';
import 'package:yuyan_app/model/events/event_seri.dart';

class AttendDataProvider extends BaseSaveListJson<EventSeri> {
  @override
  String get key => 'attend_events';

  @override
  List<EventSeri> convert(json) {
    if (json == null) return null;
    var data = (json as List).map((e) => EventSeri.fromJson(e)).toList();
    return data;
  }
}

class AttendController extends FetchRefreshController<AttendDataProvider> {
  static Map<String, String> eventType = {
    "update_doc": "更新了文档",
    "like_doc": "打赏了稻谷",
    "publish_doc": "发布了文章",
    "watch_book": "关注了知识库",
    "follow_user": "关注了雀友",
    "like_artboard": "给画板赞赏了稻谷",
    "upload_artboards": "更新了画板"
  };

  AttendController()
      : super(
          initialRefresh: true,
          state: ViewState.loading,
          initData: AttendDataProvider(),
        );

  int offset = 0;

  Future _doFetch({bool refresh = false}) async {
    var resp = await ApiRepository.getAttendEvents(refresh ? 0 : offset);
    if (refresh) {
      offset = resp.length;
    } else {
      offset += resp.length;
    }
    return resp;
  }

  @override
  Future refreshData() => _doFetch(refresh: true);

  @override
  Future fetchMoreData() => _doFetch(refresh: false);
}
