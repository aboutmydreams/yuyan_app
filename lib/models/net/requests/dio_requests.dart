import 'package:dio/dio.dart';
import 'dart:async';
import 'package:yuyan_app/util/get_pref.dart';

class DioReq {
  static Dio dio = Dio();
  static String baseUrl = "https://www.yuque.com/api";

  /// 适配空间 api
  static orgSpace({bool onlyUser: false}) async {
    // String nowOrg = await topModel.myInfoManage.getMyNowOrg();
    String nowOrg = "www";
    onlyUser ??= false;
    String nowBaseUrl = (nowOrg != null && nowOrg != "")
        ? baseUrl.replaceAll("www.yuque", nowOrg + ".yuque")
        : baseUrl;
    return onlyUser ? baseUrl : nowBaseUrl;
  }

  /// 自动生成 header
  static autoHeader({Map<String, dynamic> headers}) async {
    var token = await getToken();
    var ctoken = await getCtoken();
    var _allCookie = await getPrefStringData("all_cookies");
    if (headers == null) {
      headers ??= {};
      headers["Content-Type"] = "application/json";
      headers["Cookie"] = _allCookie;
      headers["x-csrf-token"] = ctoken.toString();
      headers["X-Auth-Token"] = token.toString();
      return headers;
    } else if (headers.containsKey('add')) {
      headers = headers['add'];
      headers["Content-Type"] = "application/json";
      headers["Cookie"] = _allCookie;
      headers["x-csrf-token"] = ctoken.toString();
      headers["X-Auth-Token"] = token.toString();
      return headers;
    } else {
      return headers;
    }
  }

  /// 默认配置请求参数
  static Options autoOptions({Map<String, dynamic> headers}) {
    return Options(
      headers: headers,
      sendTimeout: 15000,
      receiveTimeout: 15000,
    );
  }

  /// 处理 DioError 错误
  static onDioError(DioError e) {
    print(e.toString());
    print(e.request.path);
    if (e.type == DioErrorType.response) {
      // print(e.response.statusCode); //403 权限不足（token过期）
      return {"data": 403};
    } else if (e.type == DioErrorType.connectTimeout) {
      return {"data": "连接超时，请检查网络"};
    } else if (e.type == DioErrorType.other) {
      return {"data": "网络错误"};
    } else {
      return {"data": "${e.toString()}"};
    }
  }

  static get(String path,
      {Map<String, dynamic> headers,
      Map<String, dynamic> param,
      bool onlyUser: false}) async {
    var nowBaseUrl = await orgSpace(onlyUser: onlyUser);
    var diopath = path[0] == "/" ? nowBaseUrl + path : path;
    headers = await autoHeader(headers: headers);

    try {
      Response response = await dio.get(
        diopath,
        queryParameters: param,
        options: autoOptions(headers: headers),
      );

      print("get: $path ${response.statusCode}");
      return response.data;
    } on DioError catch (e) {
      onDioError(e);
    } catch (e) {
      throw Exception('UNPROM${e.toString()}');
    }
  }

  static Future post(String path,
      {Map<String, dynamic> headers,
      Map<String, dynamic> data,
      Map<String, dynamic> param,
      bool onlyUser: false}) async {
    var nowBaseUrl = await orgSpace(onlyUser: onlyUser);
    var diopath = path[0] == "/" ? nowBaseUrl + path : path;
    print('bef======$headers');
    headers = await autoHeader(headers: headers);
    print('af======$headers');

    try {
      Response response = await dio.post(
        diopath,
        queryParameters: param,
        data: data,
        options: autoOptions(headers: headers),
      );

      print("post: $path ${response.statusCode}");
      return response.data;
    } on DioError catch (e) {
      print(path + e.toString());
      onDioError(e);
    } catch (e) {
      throw Exception('UNPROM${e.toString()}');
    }
  }

  static Future put(String path,
      {Map<String, dynamic> headers,
      Map<String, dynamic> data,
      Map<String, dynamic> param,
      bool onlyUser: false}) async {
    var nowBaseUrl = await orgSpace(onlyUser: onlyUser);
    var diopath = path[0] == "/" ? nowBaseUrl + path : path;
    headers = await autoHeader(headers: headers);
    try {
      Response response = await dio.put(
        diopath,
        queryParameters: param,
        data: data,
        options: autoOptions(headers: headers),
      );
      print("put: $path ${response.statusCode}");
      return response.data;
    } on DioError catch (e) {
      onDioError(e);
    } catch (e) {
      throw Exception('UNPROM${{"data": "${e.toString()}"}}');
    }
  }

  static Future delete(String path,
      {Map<String, dynamic> headers,
      Map<String, dynamic> data,
      Map<String, dynamic> param,
      bool onlyUser: false}) async {
    var nowBaseUrl = await orgSpace(onlyUser: onlyUser);
    var diopath = path[0] == "/" ? nowBaseUrl + path : path;
    headers = await autoHeader(headers: headers);
    try {
      Response response = await dio.delete(
        diopath,
        queryParameters: param,
        data: data,
        options: autoOptions(headers: headers),
      );
      print("del: $path ${response.statusCode}");
      return response.data;
    } on DioError catch (e) {
      onDioError(e);
    } catch (e) {
      throw Exception('UNPROM${e.toString()}');
    }
  }

  /// 上传图片
  static uploadImage(String imagePath, String attachableType, int attachableId,
      {String type: 'image'}) async {
    /// attachableType: Doclet: 小记 doc: 文档
    // var file = File.fromUri(Uri.parse(imagePath));
    String uploadUrl = baseUrl + "/upload/attach";
    var name =
        imagePath.substring(imagePath.lastIndexOf("/") + 1, imagePath.length);
    var ctoken = await getCtoken();

    Map<String,dynamic> param = {
      "attachable_type": attachableType,
      "attachable_id": attachableId,
      "type": type,
      "ctoken": ctoken
    };
    var image = await MultipartFile.fromFile(
      imagePath,
      filename: name,
    );
    FormData formData =
        FormData.fromMap({"file": image});

    Map headers = await autoHeader();
    try {
      Response response = await dio.post(
        uploadUrl,
        queryParameters: param,
        data: formData,
        options: autoOptions(headers: headers),
      );
      return response.data['data']['url'];
    } on DioError catch (e) {
      onDioError(e);
    } catch (e) {
      throw Exception('UNPROM${e.toString()}');
    }
  }

  /// 获取重定向最终路径
  static getRedirect(
    String path, {
    Map<String, dynamic> headers,
    Map<String, dynamic> param,
  }) async {
    headers = await autoHeader(headers: headers);

    var nowBaseUrl = await orgSpace();
    var diopath = path[0] == "/" ? nowBaseUrl + path : path;
    Response res = await dio.get(
      diopath,
      queryParameters: param,
      options: autoOptions(headers: headers),
    );
    print("$diopath -> ${res.redirects.last.location}");
    return res.redirects.last.location;
  }
}
