import 'package:dio/dio.dart';
import 'package:yuyan_app/config/app.dart';
import 'package:yuyan_app/config/net/api.dart';
import 'package:yuyan_app/config/net/token.dart';
import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/model/user/user.dart';
import 'package:yuyan_app/model/v2/user_detail.dart';

class Api2Repository {
  static String _baseUrl = "https://www.yuque.com/api/v2";
  static BaseApi api = BaseApi(baseUrl: _baseUrl);

  static Future<TokenJsonSeri> getTokenByCode({
    String code,
  }) async {
    if (api == null) {
      throw 'API instance not initialized';
    }
    var res = await api.post(
      'https://www.yuque.com/oauth2/token',
      data: {
        "client_id": Config.clientId,
        "client_secret": Config.clientSecret,
        "grant_type": "authorization_code",
        "code": code,
      },
    );
    
    var data = (res.data as ApiResponse).raw;
    return TokenJsonSeri.fromJson(data);
  }

  static Future<UserDetailSeri> getUserDetail({
    int userId,
    String userLogin,
  }) async {
    Response res;
    if (userId == null && userLogin == null) {
      res = await api.get("$_baseUrl/user");
    } else {
      res = await api.get("$_baseUrl/users/${userId ?? userLogin}");
    }
    var asp = (res.data as ApiResponse);
    return UserDetailSeri.fromJson(asp.data);
  }

  static Future<UserSeri> getGroupDetail({
    int groupId,
    String groupLogin,
  }) async {
    Response res = await api.get("$_baseUrl/groups/${groupId ?? groupLogin}");
    var asp = (res.data as ApiResponse);
    return UserSeri.fromJson(asp.data);
  }

  static Future<BookSeri> getBookDetail({int bookId}) async {
    var res = await api.get('$_baseUrl/repos/$bookId');
    var asp = (res.data as ApiResponse);
    return BookSeri.fromJson(asp.data);
  }
}
