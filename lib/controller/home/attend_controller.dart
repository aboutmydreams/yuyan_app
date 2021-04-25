import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/config/storage_manager.dart';
import 'package:yuyan_app/config/viewstate/view_controller.dart';
import 'package:yuyan_app/config/viewstate/view_state.dart';
import 'package:yuyan_app/model/user/events/event_seri.dart';

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

/// 我的关注
class AttendController extends FetchSavableController<AttendDataProvider> {
  AttendController()
      : super(
          initialRefresh: true,
          state: ViewState.loading,
          initData: AttendDataProvider(),
        );

  int offset = 0;

  Future _doFetch({bool refresh = false}) async {
    var resp = await ApiRepository.getAttendEvents(refresh ? 0 : offset);
    offset = resp.item2.meta['offset'];
    return resp.item1;
  }

  @override
  Future fetchData() => _doFetch(refresh: true);

  @override
  Future fetchMore() => _doFetch(refresh: false);
}
