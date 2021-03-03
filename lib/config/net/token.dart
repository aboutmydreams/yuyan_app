import 'package:flutter/material.dart';
import 'package:yuyan_app/config/app.dart';
import 'package:yuyan_app/config/net/base.dart';
import 'package:yuyan_app/config/storage_manager.dart';

class TokenJson {
  String accessToken;
  String session;
  String cToken;

  String allCookie;

  TokenJson.fromJson(Map json) {
    if (json['error'] != null) {
      throw 'error: ${json['error']} ${json['error_description']}';
    }

    accessToken = json['access_token'];
    //try load from store
    allCookie ??= json['all_cookie'];
    session ??= json['session'];
    cToken ??= json['ctoken'];
  }

  loadCookies(String cookie) {
    allCookie = cookie;

    List<String> cookiesList = cookie.split(";");
    Map<String, String> cookieData = {};
    for (var cookie in cookiesList) {
      var arr = cookie.split("=");
      var key = arr[0].trim(), val = arr[1].trim();
      cookieData[key] = val;
    }
    debugPrint(cookieData['_yuque_session']);
    debugPrint(cookieData['_TRACERT_COOKIE__SESSION']);
    cToken = cookieData['yuque_ctoken'];
    session = cookieData['_yuque_session'];
  }

  String getCookie() {
    return '_yuque_session=$session;yuque_ctoken=$cToken;lang=zh-cn';
  }

  Map<String, dynamic> toJson() => {
        'access_token': accessToken,
        'session': session,
        'ctoken': cToken,
        'all_cookie': allCookie,
      };
}

class TokenProvider extends BaseSaveJson<TokenJson> {
  bool get isLogin =>
      !isNullOrEmpty && data.accessToken != null && data.session != null;

  @override
  String get key => 'token';

  @override
  TokenJson convert(json) {
    return TokenJson.fromJson(json);
  }
}

//used for api
//Header
//  X-Auth-Token: access-token;
//  Cookie: _yuque_session={};yuque_ctoken={};lang=zh-cn
//  x-csrf-token: yuque_ctoken
mixin TokenMixin on BaseHttp {
  var token = App.token;

  init() {
    debugPrint('token mixin init called');

    debugPrint("token mixin ready");
    setToken(token.data);

    token.addListener(() {
      debugPrint("token listener triggered");
      setToken(token.data);
    });
  }

  setToken(TokenJson token) {
    options.headers['X-Auth-Token'] = token.accessToken;
    options.headers['Cookie'] = token.getCookie();
    options.headers['x-csrf-token'] = token.cToken;
  }
}
