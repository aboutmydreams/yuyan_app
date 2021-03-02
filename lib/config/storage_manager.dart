import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_store/json_store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class StorageManager {
  //保存 app config相关信息
  static SharedPreferences sharedPreferences;

  // 临时目录，保存照片
  static Directory temporaryDirectory;

  // 离线可以使用的数据
  // static LocalStorage localStorage;
  static JsonStore jsonStore;

  //初始化，同步操作会阻塞，尽量减少储存量
  static init() async {
    temporaryDirectory = await getTemporaryDirectory();
    sharedPreferences = await SharedPreferences.getInstance();
    // localStorage = LocalStorage('LocalStorage');
    // await localStorage.ready;
    jsonStore = JsonStore();
  }
}

abstract class BaseSavableJson<T> extends GetxController {
  String get key;

  T _data;
  T get data => _data;
  set data(T newData) {
    _data = newData;
    saveJson();
    notifyChildrens();
  }

  loadJson();
  saveJson();
  updateData(T newData) => data = newData;

  T convert(Map json);
}

abstract class BaseSaveJson<T> extends BaseSavableJson<T> {
  Future<bool> ready;

  BaseSaveJson() {
    loadJson();
  }

  @override
  loadJson() {
    var now = DateTime.now();
    var load = StorageManager.jsonStore.getItem(key);
    ready = Future<bool>(() async {
      var value = await load;
      var data2 = convert(value ?? {});
      data = data2;
      var now2 = DateTime.now();
      debugPrint(
          '[${now2.difference(now).inMilliseconds} us] load data(${value.length}) with key $key');
      return true;
    });
    load.catchError((err) {
      debugPrint('load $key error: $err');
    });
  }

  @override
  saveJson() {
    var now = DateTime.now();
    Map json;
    dynamic data = _data;
    try {
      json = data.toJson();
    } on NoSuchMethodError catch (_) {
      json = data;
    }
    var save = StorageManager.jsonStore.setItem(key, json);
    save.catchError((err) {
      debugPrint('try to save ${data.runtimeType} with key $key: $err');
    });
    save.then((_) {
      var now2 = DateTime.now();
      debugPrint(
          '[${now2.difference(now).inMicroseconds} us] save ${data.runtimeType} with key $key');
    });
  }
}
