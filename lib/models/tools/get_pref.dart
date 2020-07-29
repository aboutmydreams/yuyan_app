import 'package:shared_preferences/shared_preferences.dart';

getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String getIt(String key) => prefs.getString(key);
  String token = getIt("access_token");
  return token;
}

getSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String getIt(String key) => prefs.getString(key);
  String session = getIt("_yuque_session");
  return session;
}

getCtoken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String getIt(String key) => prefs.getString(key);
  String ctoken = getIt("ctoken");
  return ctoken;
}

getLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String getIt(String key) => prefs.getString(key);
  String login = getIt("login");
  return login;
}

getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int getIt(String key) => prefs.getInt(key);

  int userId = getIt("my_id");
  return userId;
}

getPrefStringData(String keyName) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String getIt(String key) => prefs.getString(key);
  String data = getIt("$keyName");
  return data;
}

getPrefIntData(String keyName) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int getIt(String key) => prefs.getInt(key);
  int data = getIt("$keyName");
  return data;
}

getPrefDoubleData(String keyName) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  double getIt(String key) => prefs.getDouble(key);
  double data = getIt("$keyName");
  return data;
}
