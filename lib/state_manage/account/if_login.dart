import 'package:yuyan_app/util/get_pref.dart';

// 判断是否登录
Future<bool> ifLogin() async {
  var accessToken = await getToken();
  var allCookie = await getPrefStringData("all_cookies");
  print("=========accessToken=========");
  print(accessToken);

  print("========session=====");
  print(allCookie);
  bool haveLogin = (accessToken != null) && (allCookie != null);
  return haveLogin;
}

Future<bool> ifGuide() async {
  var guideStatus = await getPrefStringData("if_guide");
  bool haveGuide = guideStatus != null;
  return haveGuide;
}
