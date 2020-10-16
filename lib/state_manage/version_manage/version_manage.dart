import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xupdate/flutter_xupdate.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/models/tools/get_version.dart';
import 'package:yuyan_app/models/tools/write_json.dart';
import 'package:yuyan_app/models/widgets_small/toast.dart';
import 'package:yuyan_app/state_manage/version_manage/data/app_info.dart';
import 'package:yuyan_app/state_manage/version_manage/data/update_data.dart';

class VersionManage extends Model {
  String checkUrl =
      "https://service-iw6blmei-1256880247.gz.apigw.tencentcs.com/release/yuyan_v?v=";
  String checkUrl2 =
      "https://service-kuz2fghy-1256880247.gz.apigw.tencentcs.com/release/yuyan_v2?v=";
  bool _isLastest = true;
  bool get isLastest => _isLastest;
  String _message;
  String _version;
  String get appversion => _version;
  String get getMessage => _message;
  UpdateJson _updateJson;
  UpdateJson get updateJson => _updateJson;

  getSaveData() async {
    var versionData = await readJson('version');
    UpdateJson updateData = UpdateJson.fromJson(versionData);
    _updateJson = updateData;
    notifyListeners();
    // return quickData;
  }

  saveVersionData() async {
    var version = await getVersion();
    _version = version;
    try {
      Response response = await Dio().get(checkUrl2 + _version);
      await writeJson('version', response.data);
      print(response.data);
      if (response.data["UpdateStatus"] == 1) {
        _isLastest = false;
      }
      notifyListeners();
      return 1;
    } catch (e) {
      _message = e.toString();
      notifyListeners();
      return 0;
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

      //  FlutterXUpdate.setErrorHandler(
      //      onUpdateError: (Map<String, dynamic> message) async {
      //    print(message);
      //    //下载失败
      //    if (message["code"] == 4000) {
      //      FlutterXUpdate.showRetryUpdateTipDialog(
      //          retryContent: "Github被墙无法继续下载，是否考虑切换蒲公英下载？",
      //          retryUrl: "https://www.pgyer.com/flutter_learn");
      //    }
      //    _message = "$message";
      //    notifyListeners();
      //  });

      //  FlutterXUpdate.setCustomParseHandler(onUpdateParse: (String json) async {
      //    //这里是自定义json解析
      //    return customParseJson(json);
      //  });

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
        notifyListeners();
      }, onUpdateParse: (String json) async {
        //这里是自定义json解析
        return customParseJson(json);
      });
    } else {
      updateMessage("ios暂不支持XUpdate更新");
    }
  }

  void updateMessage(String message) {
    _message = "$message";
    notifyListeners();
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
    if (isLastest) {
      myToast(context, "已是最新版本啦~");
    } else {
      checkUpdateDefault();
    }
  }

  void checkUpdateDefault() {
    FlutterXUpdate.checkUpdate(url: checkUrl2 + _version);
  }

  void initAll() {
    saveVersionData().then((res) {
      getSaveData();
      initXUpdate();
    });
  }
}
