import 'events/book_event_seri.dart';
import 'events/doc_event_seri.dart';
import 'events/event_seri.dart';
import 'events/user_lite_seri.dart';

class Serializer {
  String _serializer;

  String get serializer => _serializer;

  Map _data;

  Map get raw => _data;

  Serializer.fromJson(json) {
    if (json == null) return;
    _data = json;
    _serializer = json["_serializer"];
  }

  Map<String, Function> _doSerializer() {
    return {
      'web.user_lite': () => UserLiteSeri.fromJson(_data),
      'web.book_event': () => BookEventSeri.fromJson(_data),
      'web.doc_event': () => DocEventSeri.fromJson(_data),
      'web.event': () => EventSeri.fromJson(_data),
    };
  }

  T serialize<T>() {
    if (_serializer == null) {
      return null;
    }
    var func = _doSerializer()[_serializer];
    return func?.call() as T;
  }

  Map toJson() => _data;
}
