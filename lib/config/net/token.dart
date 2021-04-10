import 'package:flutter/material.dart';
import 'package:yuyan_app/config/app.dart';
import 'package:yuyan_app/config/net/base.dart';
import 'package:yuyan_app/config/storage_manager.dart';

class TokenJsonSeri {
  String accessToken;
  String session;
  String cToken;

  String allCookie;

  TokenJsonSeri.fromJson(Map json) {
    if (json['error'] != null) {
      throw 'error: ${json['error']} ${json['error_description']}';
    }

    accessToken = json['access_token'];
    // try load from store
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

class TokenProvider extends BaseSaveJson<TokenJsonSeri> {
  bool get isLogin =>
      !isNullOrEmpty && data.accessToken != null && data.session != null;

  @override
  String get key => 'token';

  @override
  TokenJsonSeri convert(json) {
    return TokenJsonSeri.fromJson(json);
  }
}

// used for api
// Header
// X-Auth-Token: access-token;
// Cookie: _yuque_session={};yuque_ctoken={};lang=zh-cn
// x-csrf-token: yuque_ctoken
mixin TokenMixin on BaseHttp {
  var token = App.tokenProvider;

  init() {
    super.init();
    debugPrint('init TokenMixin');
    setToken(token.data);
    token.addListener(() {
      debugPrint("!!!! change of token !!!!");
      setToken(token.data);
    });
  }

  setToken(TokenJsonSeri token) {
    if (token != null) {
      options.headers['X-Auth-Token'] = token.accessToken;
      options.headers['Cookie'] = token.getCookie();
      options.headers['x-csrf-token'] = token.cToken;
    }
  }
}

mixin OrganizationMixin on BaseHttp {
  var orgProvider = App.orgSpaceProvider;
  String _defaultBaseUrl;

  init() {
    super.init();
    _defaultBaseUrl = options.baseUrl;
    debugPrint('_defaultBaseUrl => $_defaultBaseUrl');
    //初始化orgSpace
    debugPrint('init OrganizationMixin');
    setOrgSpace(orgProvider.data?.login);
    orgProvider.addListener(() {
      debugPrint('!!!! change of organization !!!!!');
      setOrgSpace(orgProvider.data?.login);
    });
  }

  setOrgSpace(String space) {
    debugPrint("change namespace: $space");
    if (space == null) {
      options.baseUrl = _defaultBaseUrl;
    } else {
      options.baseUrl = _defaultBaseUrl.replaceFirst("www", space);
    }
  }
}
