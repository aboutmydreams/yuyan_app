import 'package:dio/dio.dart';
import 'dart:async';
import 'package:yuyan_app/models/tools/get_pref.dart';

class DioReq {
  static Dio dio = Dio();

  static String baseUrl = "https://www.yuque.com/api";
  static get(String path,
      {Map<String, dynamic> headers, Map<String, dynamic> param}) async {
    var diopath = path[0] == "/" ? baseUrl + path : path;
    var token = await getToken();
    var ctoken = await getCtoken();
    // var _yuqueSession = await getSession();
    var _allCookie = await getPrefStringData("all_cookies");
    print(path);
    headers ??= {};
    headers["Content-Type"] = "application/json";
    // headers["Cookie"] = "_yuque_session=" + _yuqueSession.toString();
    // headers["ctoken"] = "ctoken=" + ctoken.toString();
    headers["Cookie"] = _allCookie;
    headers["x-csrf-token"] = ctoken.toString();
    headers["X-Auth-Token"] = token.toString();

    try {
      Options options = Options(
        headers: headers,
        sendTimeout: 10000,
        receiveTimeout: 10000,
      );

      Response response = await dio.get(
        diopath,
        queryParameters: param,
        options: options,
      );

      print(response.statusCode);

      return response.data;
    } on DioError catch (e) {
      print(e);
      if (e.type == DioErrorType.RESPONSE) {
        // print(e.response.statusCode); //403 权限不足（token过期）
        throw Exception('身份过期，重新登录');
      } else if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        throw Exception('连接超时，请检查网络');
      } else if (e.type == DioErrorType.DEFAULT) {
        throw Exception('网络错误，很幸运，这次你遇到了～');
      } else {
        throw Exception('TYPEPROM${e.toString()}');
      }
    } catch (e) {
      throw Exception('UNPROM${e.toString()}');
    }
  }

  static Future post(String path,
      {Map<String, dynamic> headers,
      Map<String, dynamic> data,
      Map<String, dynamic> param}) async {
    var diopath = path[0] == "/" ? baseUrl + path : path;
    var token = await getToken();
    var ctoken = await getCtoken();
    var _allCookie = await getPrefStringData("all_cookies");
    headers ??= {};
    headers["Content-Type"] = "application/json";
    headers["X-Auth-Token"] = token;
    headers["Cookie"] = _allCookie;
    headers["x-csrf-token"] = ctoken.toString();
    try {
      Options options = Options(
        headers: headers,
        sendTimeout: 10000,
        receiveTimeout: 10000,
      );

      Response response = await dio.post(
        diopath,
        queryParameters: param,
        data: data,
        options: options,
      );

      return response.data;
    } on DioError catch (e) {
      print(e);
      if (e.type == DioErrorType.RESPONSE) {
        // print(e.response.statusCode); //403 权限不足（token过期）
        throw Exception('身份过期，重新登录');
      } else if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        throw Exception('连接超时，请检查网络');
      } else if (e.type == DioErrorType.DEFAULT) {
        throw Exception('网络错误，很幸运，这次你遇到了～');
      } else {
        throw Exception('TYPEPROM${e.toString()}');
      }
    } catch (e) {
      throw Exception('UNPROM${e.toString()}');
    }
  }

  static Future put(String path,
      {Map<String, dynamic> headers,
      Map<String, dynamic> data,
      Map<String, dynamic> param}) async {
    var diopath = path[0] == "/" ? baseUrl + path : path;
    var token = await getToken();
    var ctoken = await getCtoken();
    var _yuqueSession = await getSession();
    headers ??= {};
    headers["Content-Type"] = "application/json";
    headers["X-Auth-Token"] = token;
    headers["Cookie"] = "_yuque_session=" + _yuqueSession;
    headers["x-csrf-token"] = ctoken.toString();
    try {
      Options options = Options(
        headers: headers,
        sendTimeout: 10000,
        receiveTimeout: 10000,
      );
      Response response = await dio.put(
        diopath,
        queryParameters: param,
        data: data,
        options: options,
      );
      return response.data;
    } on DioError catch (e) {
      print(e);
      if (e.type == DioErrorType.RESPONSE) {
        // print(e.response.statusCode); //403 权限不足（token过期）
        throw Exception('身份过期，重新登录');
      } else if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        throw Exception('连接超时，请检查网络');
      } else if (e.type == DioErrorType.DEFAULT) {
        throw Exception('网络错误，很幸运，这次你遇到了～');
      } else {
        throw Exception('TYPEPROM${e.toString()}');
      }
    } catch (e) {
      throw Exception('UNPROM${e.toString()}');
    }
  }

  static Future delete(String path,
      {Map<String, dynamic> headers,
      Map<String, dynamic> data,
      Map<String, dynamic> param}) async {
    var diopath = path[0] == "/" ? baseUrl + path : path;
    var token = await getToken();
    var ctoken = await getCtoken();
    var _yuqueSession = await getSession();
    headers ??= {};
    headers["Content-Type"] = "application/json";
    headers["X-Auth-Token"] = token;
    headers["Cookie"] = "_yuque_session=" + _yuqueSession;
    headers["x-csrf-token"] = ctoken.toString();
    try {
      Options options = Options(
        headers: headers,
        sendTimeout: 10000,
        receiveTimeout: 10000,
      );
      Response response = await dio.delete(
        diopath,
        queryParameters: param,
        data: data,
        options: options,
      );
      return response.data;
    } on DioError catch (e) {
      print(e);
      if (e.type == DioErrorType.RESPONSE) {
        // print(e.response.statusCode); //403 权限不足（token过期）
        throw Exception('身份过期，重新登录');
      } else if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        throw Exception('连接超时，请检查网络');
      } else if (e.type == DioErrorType.DEFAULT) {
        throw Exception('网络错误，很幸运，这次你遇到了～');
      } else {
        throw Exception('TYPEPROM${e.toString()}');
      }
    } catch (e) {
      throw Exception('UNPROM${e.toString()}');
    }
  }
}
