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
    var _allCookie = await getPrefStringData("all_cookies");
    print(path);
    headers ??= {};
    headers["Content-Type"] = "application/json";
    headers["Cookie"] = _allCookie;
    headers["x-csrf-token"] = ctoken.toString();
    headers["X-Auth-Token"] = token.toString();

    try {
      Options options = Options(
        headers: headers,
        sendTimeout: 15000,
        receiveTimeout: 15000,
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
        return {"data": 403};
      } else if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        return {"data": "连接超时，请检查网络"};
      } else if (e.type == DioErrorType.DEFAULT) {
        return {"data": "网络错误"};
      } else {
        return {"data": "${e.toString()}"};
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
    print(path);
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
        return {"data": 403};
      } else if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        return {"data": "连接超时，请检查网络"};
      } else if (e.type == DioErrorType.DEFAULT) {
        return {"data": "网络错误"};
      } else {
        return {"data": "${e.toString()}"};
      }
    } catch (e) {
      throw Exception('UNPROM${e.toString()}');
    }
  }

  static Future put(String path,
      {Map<String, dynamic> headers,
      Map<String, dynamic> data,
      Map<String, dynamic> param}) async {
    print(path);
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
        return {"data": 403};
      } else if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        return {"data": "连接超时，请检查网络"};
      } else if (e.type == DioErrorType.DEFAULT) {
        return {"data": "网络错误"};
      } else {
        return {"data": "${e.toString()}"};
      }
    } catch (e) {
      throw Exception('UNPROM${{"data": "${e.toString()}"}}');
    }
  }

  static Future delete(String path,
      {Map<String, dynamic> headers,
      Map<String, dynamic> data,
      Map<String, dynamic> param}) async {
    print(path);
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
        return {"data": 403};
      } else if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        return {"data": "连接超时，请检查网络"};
      } else if (e.type == DioErrorType.DEFAULT) {
        return {"data": "网络错误"};
      } else {
        return {"data": "${e.toString()}"};
      }
    } catch (e) {
      throw Exception('UNPROM${e.toString()}');
    }
  }
}
