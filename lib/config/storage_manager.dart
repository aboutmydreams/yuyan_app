import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class StorageManager {
  //保存 app config相关信息
  static SharedPreferences sharedPreferences;

  // 临时目录，保存照片
  static Directory temporaryDirectory;

  // 离线可以使用的数据
  // static LocalStorage localStorage;
  static GetStorage getStorage;

  //初始化，同步操作会阻塞，尽量减少储存量
  static init() async {
    temporaryDirectory = await getTemporaryDirectory();
    sharedPreferences = await SharedPreferences.getInstance();
    // localStorage = LocalStorage('LocalStorage');
    // await localStorage.ready;
    await GetStorage.init();
    getStorage = GetStorage();
  }
}

abstract class BaseSavableJson<T> extends GetxController {
  String get key;

  T _data;

  T get data => _data;

  bool get isNullOrEmpty => GetUtils.isNullOrBlank(data);

  set data(T newData) {
    _data = newData;
    update();
    saveJson();
  }

  loadJson();

  saveJson();

  updateData([T newData]) => data = newData ?? data;

  T convert(json);
}

abstract class BaseSaveJson<T> extends BaseSavableJson<T> {
  BaseSaveJson() {
    loadJson();
  }

  @override
  loadJson() {
    var now = DateTime.now();
    var value = StorageManager.getStorage.read(key);
    if (value == null) {
      //not loaded
      debugPrint('warn: load null data from key: $key');
    } else if (value is T) {
      _data = value;
    } else {
      _data = convert(value);
    }
    var now2 = DateTime.now();
    debugPrint(
        '[${now2.difference(now).inMilliseconds} us] load ${value.runtimeType}, key: $key');
  }

  @override
  saveJson() {
    var now = DateTime.now();
    var save = StorageManager.getStorage.write(key, data);
    save.catchError((err) {
      debugPrint('error: try to save $key: ${data.runtimeType} : $err');
    });
    save.then((_) {
      var now2 = DateTime.now();
      debugPrint(
          '[${now2.difference(now).inMicroseconds} us] success save ${data.runtimeType}, key: $key');
    });
  }
}

abstract class BaseSaveListJson<T> extends BaseSaveJson<List<T>> {
  void removeFirst() {
    data.removeAt(0);
    updateData();
  }

  void removeLast() {
    data.removeLast();
    updateData();
  }

  void add(T item) {
    data.add(item);
    updateData();
  }

  bool remove(T item) {
    var res = data.remove(item);
    updateData();
    return res;
  }
}
