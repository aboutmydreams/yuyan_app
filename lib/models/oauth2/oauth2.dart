import 'random_string/random_string.dart';
import 'sha1/sha1.dart';

/// please look yuque doc
/// https://www.yuque.com/yuque/developer/authorizing-oauth-apps#evagmg
String getOauthUrl() {
  String clientId = "eeqJ55wPXkjEJZujqEQh";
  String clientSecret = "cUqsOf2mnphsHKEpsJLHWXrsu8oPwtnBxPStbD9f";
  Map<String, String> signData = {
    "client_id": clientId,
    "code": randomString(40),
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
