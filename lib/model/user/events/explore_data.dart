import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/model/document/doc.dart';
import 'package:yuyan_app/model/user/user.dart';

class DiscoverRecommendJson {
  List<BookSeri> books;
  List<DocSeri> docs;
  List<UserSeri> users;

  DiscoverRecommendJson.fromJson(data) {
    if (data == null) return;
    if (data['books'] != null) {
      books = (data['books'] as List).map((e) => BookSeri.fromJson(e)).toList();
    }
    if (data['docs'] != null) {
      docs = (data['docs'] as List).map((e) => DocSeri.fromJson(e)).toList();
    }
    if (data['users'] != null) {
      users = (data['users'] as List).map((e) => UserSeri.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() => {
        'books': books?.map((e) => e.toJson())?.toList(),
        'docs': docs?.map((e) => e.toJson())?.toList(),
        'users': users?.map((e) => e.toJson())?.toList(),
      };
}
