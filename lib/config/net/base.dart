import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/material.dart';
import 'package:pretty_json/pretty_json.dart';

abstract class BaseHttp extends DioForNative {
  BaseHttp() {
    //log
    interceptors.add(PrintInterceptor());

    options.sendTimeout = 1000 * 5;
    options.connectTimeout = 1000 * 5;
    options.receiveTimeout = 1000 * 5;
    init();
  }

  void init() {}
}

class PrintInterceptor extends InterceptorsWrapper {
  String getRequestDebug(RequestOptions req) {
    String debug = 'http-->${req.baseUrl}';
    //debug
    debug += '\n\t${req.method.toUpperCase()}-->${req.path}';
    // debugPrint('  ${options.method.toUpperCase()}-->${options.path}');
    if (req.queryParameters != null && req.queryParameters.isNotEmpty) {
      debug += '\n\tquery--> ${req.queryParameters}';
    }
    if (req.data != null) {
      debug += '\n\tdata--> ${req.data}';
    }
    return debug;
  }

  String getResponseDebug(Response resp) {
    if (resp == null) return 'getResponseDebug()->null';
    //debug
    var debug = getRequestDebug(resp.request);
    debug += '\nresponse--> ${resp.statusCode} ${resp.statusMessage}';
    // if (resp.data is Map) {
    //   var data = resp.data['data'];
    //   if (data != null && data is List) {
    //     var item = data.length > 1 ? [data.first] : data;
    //     debug += '\n\tdata-->\n${prettyJson(item)}\n';
    //   } else {
    //     debug += '\n\tdata-->\n${prettyJson(resp.data)}\n';
    //   }
    // } else if (resp.data is List) {
    //   var data = (resp.data as List);
    //   var json = data.length >= 1 ? [data.first] : data;
    //   debug += '\n\tdata-->\n${prettyJson(json)}\n';
    // } else {
    //   debug += '\n\tdata-->\n${resp.data}\n';
    // }
    debug += '\n\tdata-->\n${'${resp.data}'.length}\n';
    if (resp.isRedirect != null && resp.isRedirect) {
      debug += '\n\tredirects-->\n${prettyJson(resp.redirects)}\n';
    }
    return debug;
  }

  String getErrorDebug(DioError err) {
    String debug = getResponseDebug(err.response);
    debug += '\nerrorType--> ${err.type}';
    debug += '\n\terror--> ${err.error}';
    return debug;
  }

  @override
  Future onRequest(RequestOptions options) async {
    debugPrint(getRequestDebug(options));
    //设置超时 10s
    options.connectTimeout = 1000 * 10;
    options.receiveTimeout = 1000 * 10;
    //这里可以添加额外的header信息
    return options;
  }

  @override
  Future onError(DioError err) async {
    debugPrint(getErrorDebug(err));
    return err;
  }

  @override
  Future onResponse(Response response) async {
    //debug
    debugPrint(getResponseDebug(response));
    return response;
  }
}
