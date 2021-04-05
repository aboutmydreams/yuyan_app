import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:yuyan_app/model/dashboard/quick_link_seri.dart';
import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/model/document/comment.dart';
import 'package:yuyan_app/model/document/design.dart';
import 'package:yuyan_app/model/document/doc.dart';
import 'package:yuyan_app/model/document/doc_lite.dart';
import 'package:yuyan_app/model/document/group.dart';
import 'package:yuyan_app/model/document/group_home/book_stack.dart';
import 'package:yuyan_app/model/document/group_user.dart';
import 'package:yuyan_app/model/document/note/doclet.dart';
import 'package:yuyan_app/model/document/user.dart';
import 'package:yuyan_app/model/events/book_event_seri.dart';
import 'package:yuyan_app/model/events/doc_event_seri.dart';
import 'package:yuyan_app/model/events/event_seri.dart';
import 'package:yuyan_app/model/events/user_event_seri.dart';
import 'package:yuyan_app/model/events/user_lite_seri.dart';
import 'package:yuyan_app/model/topic/topic.dart';

class Serializer {
  String _serializer;

  String get serializer => _serializer;

  bool ofType(String type) {
    if (_serializer == null) return false;
    return _serializer == type;
  }

  dynamic _data;

  dynamic get raw => _data;

  Serializer({String serializer, json})
      : _serializer = serializer,
        _data = json;

  Serializer.fromJson(json) {
    if (json == null) {
      debugPrint('Serializer received null input => $json');
      return;
    }
    if (json is Map) {
      _data = json;
      _serializer = json["_serializer"];
    } else if (json is List) {
      _data = json.map((e) => Serializer.fromJson(e)).toList();
      _serializer = '_convert.list';
    }
  }

  Map<String, Function> _doSerializer() {
    return {
      'web.user_event': () => UserEventSeri.fromJson(_data),
      'web.quick_link': () => QuickLinkSeri.fromJson(_data),
      'web.book_stack': () => BookStackSeri.fromJson(_data),
      'web.user_lite': () => UserLiteSeri.fromJson(_data),
      'web.book_event': () => BookEventSeri.fromJson(_data),
      'web.doc_event': () => DocEventSeri.fromJson(_data),
      'web.event': () => EventSeri.fromJson(_data),
      'web.doc': () => DocSeri.fromJson(_data),
      'web.book': () => BookSeri.fromJson(_data),
      'web.user': () => UserSeri.fromJson(_data),
      'web.group_user': () => GroupUserSeri.fromJson(_data),
      'web.group': () => GroupSeri.fromJson(_data),
      'web.comment': () => CommentSeri.fromJson(_data),
      'web.topic': () => TopicSeri.fromJson(_data),
      'web.doclet': () => DocletSeri.fromJson(_data),
      'web.doc_lite': () => DocLiteSeri.fromJson(_data),
      'web.design': () => DesignSeri.fromJson(_data),
      '_convert.list': <T>() =>
          (_data as List<Serializer>).map((e) => e.serialize<T>()).toList(),
    };
  }

  T serialize<T>([String serializer]) {
    if (_data == null) {
      return null;
    }
    var seri = serializer ?? _serializer;
    if (seri == null) {
      seri = '${T.toString()}';
    }
    if (seri.endsWith('Seri')) {
      seri = seri.replaceFirst('Seri', '');
    }
    if (!seri.startsWith('_') && !seri.startsWith('web')) {
      seri = 'web.' + ReCase(seri).snakeCase;
    }
    var func = _doSerializer()[seri];
    return func?.call() as T;
  }

  List<T> list<T>([String serializer]) {
    var func = _doSerializer()[serializer ?? _serializer];
    var lst = func?.call<T>() as List<T>;
    return lst;
  }

  toJson() => _data;
}
