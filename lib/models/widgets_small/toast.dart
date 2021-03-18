import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:yuyan_app/controller/theme_controller.dart';

class Toast {
  static OverlayEntry _overlayEntry; // toast靠它加到屏幕上
  static bool _showing = false; // toast是否正在showing
  static DateTime _startedTime; // 开启一个新toast的当前时间，用于对比是否已经展示了足够时间
  static Widget _child;
  static int _showTime; // toast显示时间
  static String _toastPosition; // 显示位置

  static void toast(
    BuildContext context, {
    Widget child = const Text("data"),
    int showTime = 2000,
    String position = 'center',
  }) async {
    _child = child;
    _startedTime = DateTime.now();
    _showTime = showTime;
    _toastPosition = position;

    //获取OverlayState
    OverlayState overlayState = Overlay.of(context);

    if (_overlayEntry == null) {
      _showing = true;
      _overlayEntry = OverlayEntry(
        maintainState: true,
        builder: (BuildContext context) => Positioned(
          top: _calToastPosition(context),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: AnimatedOpacity(
                opacity: _showing ? 1.0 : 0.0, //目标透明度
                duration: _showing
                    ? Duration(milliseconds: 1000)
                    : Duration(milliseconds: 1000),
                child: _child,
              ),
            ),
          ),
        ),
      );
      overlayState.insert(_overlayEntry);
    } else {
      // 重新绘制UI，类似setState
      _overlayEntry.markNeedsBuild();
    }
    await Future.delayed(Duration(milliseconds: _showTime)); // 等待时间

    // 时间到后消失
    if (DateTime.now().difference(_startedTime).inMilliseconds >= _showTime) {
      _showing = false;
      _overlayEntry.markNeedsBuild();
      await Future.delayed(Duration(milliseconds: 1400));
      _overlayEntry.remove();
      _overlayEntry = null;
    }
  }

  //  设置toast位置
  static _calToastPosition(context) {
    var backResult;
    if (_toastPosition == 'top') {
      backResult = MediaQuery.of(context).size.height * 1 / 4;
    } else if (_toastPosition == 'center') {
      backResult = MediaQuery.of(context).size.height * 2 / 5;
    } else {
      backResult = MediaQuery.of(context).size.height * 3 / 4;
    }
    return backResult;
  }
}

myToast(BuildContext context, String text) {
  assert(text != null);
  return Toast.toast(
    context,
    child: Container(
      decoration: BoxDecoration(
        color: ThemeController.to.primarySwatchColor,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(55, 0, 0, 0),
            offset: Offset(1, 2),
            blurRadius: 4,
          ),
        ],
        borderRadius: BorderRadius.circular(22.0),
      ),
      child: FlatButton(
        onPressed: () {},
        child: Text(
          "$text",
          style: TextStyle(color: Colors.white, decoration: null),
        ),
      ),
    ),
    showTime: 1200,
    position: 'bottom', // String 提示框显示位置，默认是center，可设置top和bottom
  );
}
