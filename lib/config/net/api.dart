
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yuyan_app/config/net/base.dart';
import 'package:yuyan_app/config/net/token.dart';

class ApiResponse {
  dynamic data;
  int status;
  String message;
  Map meta;

  ApiResponse.fromJson(Map json) {
    data = json['data'];
    status = json['status'];
    message = json['message'];
    meta = json['meta'];
  }

  bool isError() {
    return data == null && status != null;
  }

  String errorDescription() {
    return 'ApiResponseError: $status $message';
  }
}

class ApiInterceptor extends InterceptorsWrapper {
  @override
  Future<Response<ApiResponse>> onResponse(Response response) async {
    var resp = ApiResponse.fromJson(response.data);
    if (resp.isError()) {
      throw ApiError(
        response: resp,
        dio: DioError(
          request: response.request,
          response: response,
        ),
      );
    }
    response.data = resp;
    return response;
  }
}

class ApiError implements Exception {
  ApiResponse response;
  DioError dio;

  ApiError({
    @required this.response,
    this.dio,
  });

  @override
  String toString() {
    var desc = response.errorDescription();
    if (dio != null) {
      return '${dio.request.method} ${dio.request.path} => $desc';
    }
    return desc;
  }
}

class BaseApi extends BaseHttp with TokenMixin {
  final baseUrl = "https://www.yuque.com/api";
  final userAgent =
      "Mozilla/5.0 AppleWebKit/537.36 Chrome/88.0.4324.181 Mobile Safari/537.36 Yuyan";

  @override
  void init() {
    super.init();

    interceptors.add(ApiInterceptor());

    options.headers['User-Agent'] = userAgent;
    options.headers['Content-Type'] = "application/json";

    options.baseUrl = baseUrl;
  }
}
