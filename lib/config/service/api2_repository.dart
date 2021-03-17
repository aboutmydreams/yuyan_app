import 'package:dio/dio.dart';
import 'package:yuyan_app/config/net/api.dart';
import 'package:yuyan_app/model/v2/user_detail.dart';

class Api2Repository {
  static BaseApi api = BaseApi(baseUrl: "https://www.yuque.com/api/v2");

  static Future<UserDetailSeri> getUserDetail({
    int userId,
    String userLogin,
  }) async {
    Response res;
    if (userId == null && userLogin == null) {
      res = await api.get("/user");
    } else {
      res = await api.get("/users/${userId ?? userLogin}");
    }
    var asp = (res.data as ApiResponse);
    return UserDetailSeri.fromJson(asp.data);
  }
}
