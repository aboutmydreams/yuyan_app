import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yuyan_app/models/widgets_small/toast.dart';

fakeReport(BuildContext context) {
  Timer(Duration(milliseconds: 1300), () {
    myToast(context, "举报成功，感谢为社群做贡献");
  });
}
