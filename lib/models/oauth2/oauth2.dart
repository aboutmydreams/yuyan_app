import 'dart:convert';

import 'package:dio/dio.dart';

import 'random_string/random_string.dart';
import 'sha1/sha1.dart';
import 'sort_map/sort_map.dart';

/// please look yuque doc
/// https://www.yuque.com/yuque/developer/authorizing-oauth-apps#evagmg
class Oauth {
  /// 随机 code 之后获取 token 需要用到
  String codeString = randomString(40);
  String clientId = "eeqJ55wPXkjEJZujqEQh";
  String clientSecret = "cUqsOf2mnphsHKEpsJLHWXrsu8oPwtnBxPStbD9f";

  /// 获取授权 url
  String getOauthUrl() {
    Map<String, String> signData = {
      "client_id": clientId,
      "code": codeString,
      "response_type": "code",
      "scope": "group,repo,doc,topic,artboard",
      "timestamp": DateTime.now().millisecondsSinceEpoch.toString()
    };

    String theSign = getSha1(sortMap(signData), clientSecret);

    String lastUrl = "https://www.yuque.com/oauth2/authorize?" +
        sortMap(signData) +
        '&sign=$theSign';
    return lastUrl;
  }

  getAccessToken() async {
    Dio dio = Dio();
    Options options = Options(
      headers: {"Content-Type": "application/json"},
      sendTimeout: 3000,
      receiveTimeout: 5000,
    );
    Map<String, String> codeData = {
      "client_id": clientId,
      "code": codeString,
      "grant_type": "client_code"
    };
    Response response = await dio.post("https://www.yuque.com/oauth2/token",
        options: options, data: codeData);
    return json.decode(response.data);

    /// 验证失败
    // {
    //     "error": "invalid_request",
    //     "error_description": "authorization code is invalid"
    // }

    /// 验证成功
    // {
    //     "access_token": "mytoken—long-and-you-should-save",
    //     "token_type": "bearer",
    //     "scope": "group,repo,doc,topic,artboard"
    // }
  }
}
