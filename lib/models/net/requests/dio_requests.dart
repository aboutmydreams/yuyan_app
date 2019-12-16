import 'package:dio/dio.dart';
import 'dart:async';
import 'package:yuyan_app/models/get_token.dart';

class Requests {
  static Dio dio = Dio();

  static String baseUrl = "https://www.yuque.com/api";
  static get(String path,
      {Map<String, dynamic> headers, Map<String, dynamic> param}) async {
    var token = await getToken();
    print(token);
    // headers = headers == null ? {"Content-Type": "application/json"} : headers;
    print("=-=-==");
    print(baseUrl + path);
    print(param);
    print("=-=-==");
    try {
      Options options = Options(
        headers: headers,
        sendTimeout: 10000,
        receiveTimeout: 10000,
      );
      if (param == null) {
        param = {"token": token};
      } else {
        param["token"] = token;
      }
      // print(param);
      Response response = await dio.get(
        baseUrl + path,
        queryParameters: param,
        options: options,
      );

      // var res = response.data["code"];
      // print(response.data);
      // if (res == 1) {
      // } else if (res == 0) {}
      // return res;
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
      {Map<String, dynamic> headers, Map<String, dynamic> data}) async {
    var token = await getToken();
    try {
      Options options = Options(
        headers: headers,
        sendTimeout: 10000,
        receiveTimeout: 10000,
      );

      Response response = await dio.post(
        baseUrl + path,
        queryParameters: {"token": token},
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
      {Map<String, dynamic> headers, Map<String, dynamic> data}) async {
    var token = await getToken();
    try {
      Options options = Options(headers: headers);
      Response response = await dio.put(
        baseUrl + path,
        queryParameters: {"token": token},
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
