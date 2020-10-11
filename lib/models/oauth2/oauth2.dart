import 'dart:convert';
import 'package:dio/dio.dart';
import 'random_string/random_string.dart';
import 'sha1/sha1.dart';
import 'sort_map/sort_map.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// please look yuque doc
/// https://www.yuque.com/yuque/developer/authorizing-oauth-apps#evagmg

/// if you want to test this code
/// test, delete shared_preferences and try
// main() {
//   var a = Oauth().getOauthUrl();
//   print(a);
// }

/// tha api return:
/// [验证失败 or 仍未验证]
// {
//     "error": "invalid_request",
//     "error_description": "authorization code is invalid"
// }

/// [授权成功]
// {
//     "access_token": "mytoken—long-and-you-should-save",
//     "token_type": "bearer",
//     "scope": "group,repo,doc,topic,artboard"
// }

/// [验证超时]
/// To do
/// 请求参数错误

class Oauth {
  /// 随机 code 之后获取 token 需要用到
  String codeString = randomString(40);
  String clientId = "eeqJ55wPXkjEJZujqEQh";
  String clientSecret = "cUqsOf2mnphsHKEpsJLHWXrsu8oPwtnBxPStbD9f";

  /// 获取授权 url
  String getOauthUrl() {
    Map<String, dynamic> signData = {
      "client_id": clientId,
      "code": codeString,
      "response_type": "code",
      "scope": "group,repo,doc,topic,artboard",
      "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
    };

    String theSign = getSha1(sortMap(signData), clientSecret);
    signData["sign"] = theSign;

    String lastUrl =
        "https://www.yuque.com/oauth2/authorize?" + sortSignMap(signData);
    // print(sortMap(signData));
    return lastUrl;
  }

  saveAccessToken() async {
    Dio dio = Dio();

    Options options = Options(
      validateStatus: (status) {
        return status < 500;
      },
      sendTimeout: 3000,
      receiveTimeout: 6000,
    );

    Map<String, String> codeData = {
      "client_id": clientId,
      "code": codeString,
      "grant_type": "client_code"
    };
    try {
      Response response = await dio.post("https://www.yuque.com/oauth2/token",
          options: options, data: codeData);
      Map tokenData = json.decode(json.encode(response.data));
      if (tokenData.keys.toList().indexOf("access_token") != -1) {
        // 将 access_token 存入缓存
        String accessToken = tokenData["access_token"];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("access_token", accessToken);
        print(accessToken);
        return true;
      } else if (tokenData.keys.toList().indexOf("error") != -1) {
        return false;
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.RESPONSE) {
        // e.response.statusCode >= 500 后端炸了
        print(e.response.statusCode);
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
