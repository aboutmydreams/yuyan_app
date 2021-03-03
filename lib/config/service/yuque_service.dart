import 'package:yuyan_app/config/net/api.dart';
import 'package:yuyan_app/model/serializer/events/event_seri.dart';

class ApiRepository {
  static BaseApi api = BaseApi();

  static Future<List<EventSeri>> getAttendEvents([int offset = 0]) async {
    var resp = await api.get('/events', queryParameters: {
      'offset': offset,
    });
    var asp = resp.data as ApiResponse;
    var data = (asp.data as List).map((e) => EventSeri.fromJson(e)).toList();
    return data;
  }
}
