import 'package:dio/dio.dart';
import 'dart:async';
import 'package:yuyan_app/state_manage/get_pref.dart';

class Requests {
  static Dio dio = Dio();

  static String baseUrl = "https://www.yuque.com/api";
  static get(String path,
      {Map<String, dynamic> headers, Map<String, dynamic> param}) async {
    var token = await getToken();
    print(token);
    headers ??= {};
    headers["Content-Type"] = "application/json";
    headers["X-Auth-Token"] = token;

    try {
      Options options = Options(
        headers: headers,
        sendTimeout: 10000,
        receiveTimeout: 10000,
      );

      Response response = await dio.get(
        baseUrl + path,
        queryParameters: param,
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

  static Future post(String path,
      {Map<String, dynamic> headers,
      Map<String, dynamic> data,
      Map<String, dynamic> param}) async {
    var token = await getToken();
    headers ??= {};
    headers["Content-Type"] = "application/json";
    headers["X-Auth-Token"] = token;
    try {
      Options options = Options(
        headers: headers,
        sendTimeout: 10000,
        receiveTimeout: 10000,
      );

      Response response = await dio.post(
        baseUrl + path,
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
    var token = await getToken();
    headers ??= {};
    headers["Content-Type"] = "application/json";
    headers["X-Auth-Token"] = token;
    try {
      Options options = Options(
        headers: headers,
        sendTimeout: 10000,
        receiveTimeout: 10000,
      );
      Response response = await dio.put(
        baseUrl + path,
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
