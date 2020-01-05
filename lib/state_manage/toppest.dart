import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'dart:ui';
import 'dart:convert';

import 'package:yuyan_app/state_manage/account/color_manage.dart';
import 'package:yuyan_app/state_manage/dataManage/select_manage.dart';

class TopStateModel extends Model {
  ColorManage colorManage = ColorManage();
  SelectManage selectManage = SelectManage();
}

TopStateModel topModel = TopStateModel();
// class Name1 extends TopStateModel {}
