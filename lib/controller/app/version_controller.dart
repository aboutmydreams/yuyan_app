import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xupdate/flutter_xupdate.dart';
import 'package:get/get.dart' hide Response;
import 'package:yuyan_app/config/app.dart';
import 'package:yuyan_app/model/app/version/app_info.dart';
import 'package:yuyan_app/model/app/version/update_data.dart';
import 'package:yuyan_app/util/util.dart';

class VersionController extends GetxController {
  final String checkUrl =
      "https://service-iw6blmei-1256880247.gz.apigw.tencentcs.com/release/yuyan_v?v=";
  final String checkUrl2 =
      "https://service-kuz2fghy-1256880247.gz.apigw.tencentcs.com/release/yuyan_v2?v=";
  var _isLatest = true.obs;

  bool get isLatest => _isLatest?.value ?? true;
  String _message;
  String _version = App.version.version;

  String get appVersion => _version;

  String get getMessage => _message;
  UpdateJson _updateJson;

  UpdateJson get updateJson => _updateJson;

  onInit() {
    super.onInit();

    initXUpdate();
    fetchLatest();
  }

  fetchLatest() async {
    try {
      Response response = await Dio().get(checkUrl2 + _version);
      var info = UpdateJson.fromJson(response.data);
      _isLatest.value = info.updateStatus == 0;
    } catch (e) {
      _message = e.toString();
    }
  }

  void initXUpdate() {
    if (Platform.isAndroid) {
      FlutterXUpdate.init(
        ///是否输出日志
        debug: true,

        ///是否使用post请求
        isPost: false,

        ///post请求是否是上传json
        isPostJson: false,

        ///是否开启自动模式
        isWifiOnly: false,

        ///是否开启自动模式
        isAutoMode: false,

        ///需要设置的公共参数
        supportSilentInstall: false,

        ///在下载过程中，如果点击了取消的话，是否弹出切换下载方式的重试提示弹窗
        enableRetry: false,
      ).then((value) {
        updateMessage("初始化成功: $value");
      }).catchError((error) {
        print(error);
      });

      FlutterXUpdate.setUpdateHandler(
          onUpdateError: (Map<String, dynamic> message) async {
        print(message);
        //下载失败
        if (message["code"] == 4000) {
          FlutterXUpdate.showRetryUpdateTipDialog(
            retryContent: "下载失败，重试一下？",
            retryUrl: checkUrl + "$_version",
          );
        }
        _message = "$message";
        update();
      }, onUpdateParse: (String json) async {
        //这里是自定义json解析
        return customParseJson(json);
      });
    } else if ((Platform.isIOS)) {}
  }

  void updateMessage(String message) {
    _message = "$message";
    update();
  }

  ///将自定义的json内容解析为UpdateEntity实体类
  UpdateEntity customParseJson(String json) {
    AppInfo appInfo = AppInfo.fromJson(json);
    print(appInfo);
    return UpdateEntity(
      hasUpdate: appInfo.hasUpdate,
      isIgnorable: appInfo.isIgnorable,
      versionCode: appInfo.versionCode,
      versionName: appInfo.versionName,
      updateContent: appInfo.updateLog,
      downloadUrl: appInfo.apkUrl,
      apkSize: appInfo.apkSize,
    );
  }

  checkVersion(BuildContext context) {
    if (isLatest) {
      Util.toast("已是最新版本啦~");
    } else {
      if ((Platform.isIOS)) {
        Util.launchURL(Config.iOStore);
      } else {
        checkUpdateDefault();
      }
    }
  }

  void checkUpdateDefault() {
    FlutterXUpdate.checkUpdate(url: checkUrl2 + _version);
  }
}
