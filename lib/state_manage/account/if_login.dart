import 'package:yuyan_app/state_manage/get_pref.dart';

// 判断是否登录
ifLogin() async {
  var accessToken = await getToken();
  bool haveLogin = accessToken != null;
  return haveLogin;
}

ifGuide() async {
  var guideStatus = await getPrefStringData("if_guide");
  bool haveGuide = guideStatus != null;
  return haveGuide;
}
