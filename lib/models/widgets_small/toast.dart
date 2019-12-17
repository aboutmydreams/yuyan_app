import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

myToast(String text) {
  return Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIos: 1,
    backgroundColor: Colors.yellow,
    fontSize: 16.0,
    textColor: Colors.black87,
  );
}

myToastTime(String text, int time1) {
  return Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIos: time1,
    backgroundColor: Colors.yellow,
    fontSize: 16.0,
    textColor: Colors.black87,
  );
}
