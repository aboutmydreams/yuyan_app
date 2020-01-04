import 'package:yuyan_app/models/tools/get_pref.dart';

// 判断是否登录
ifLogin() async {
  var accessToken = await getToken();
  var session = await getPrefStringData("_yuque_session");
  bool haveLogin = (accessToken != null) && (session != null);
  return haveLogin;
}

ifGuide() async {
  var guideStatus = await getPrefStringData("if_guide");
  bool haveGuide = guideStatus != null;
  return haveGuide;
}
