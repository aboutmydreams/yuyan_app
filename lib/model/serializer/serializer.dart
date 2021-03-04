import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/model/document/doc.dart';
import 'package:yuyan_app/model/document/user.dart';

import 'events/book_event_seri.dart';
import 'events/doc_event_seri.dart';
import 'events/event_seri.dart';
import 'events/user_lite_seri.dart';

class Serializer {
  String _serializer;

  String get serializer => _serializer;

  bool ofType(String type) {
    if (_serializer == null) return false;
    return _serializer == type;
  }

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
      'web.doc': () => DocSeri.fromJson(_data),
      'web.book': () => BookSeri.fromJson(_data),
      'web.user': () => UserSeri.fromJson(_data),
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
