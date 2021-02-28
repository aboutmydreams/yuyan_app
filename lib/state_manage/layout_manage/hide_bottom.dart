import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';

class BottomManagerController extends GetxController {
  int _hideBottomBar = 0;
  int get hideBottomBar => _hideBottomBar;

  bool firstCome = false;

  double _y = 56;
  double get y => _y;

  double _firstY;
  double _nowY = 0;

  double d1 = 0;
  double d2 = 0;
  double d3 = 0;

  DateTime firstTime;

  void changeHide() {
    // _hideBottomBar = !_hideBottomBar;
    // notifyListeners();
    notifyChildrens();
  }

  void initd() {
    d1 = _nowY;
    d2 = _nowY;
    d3 = _nowY;
    firstCome = true;
    firstTime = DateTime.now();
    print("firstcome");
  }

  bool isFirst() {
    bool m = _hideBottomBar == 0;
    return firstCome & m;
  }

  void addPixels(double d) {
    if (d <= 0) {
      _y = 56;
    } else {
      if (isFirst()) {
        // 记录第一次 y
        _firstY = d;
        firstCome = false;
        _nowY = d;
        d1 = d2;
        d2 = d3;
        d3 = d;
      } else if (((d3 > d2 && d3 > d) || (d3 < d2 && d3 < d)) &&
          (_hideBottomBar != 1)) {
        // 拐点
        // print("拐点来了！$_hideBottomBar");
        _firstY = d;

        _nowY = d;
        d1 = d2;
        d2 = d3;
        d3 = d;
      } else {
        _nowY = d;
        d1 = d2;
        d2 = d3;
        d3 = d;
        // 与第一次计算差值
        var changeY = d - _firstY;
        if (_hideBottomBar == 0) {
          // 完全没有隐藏
          // print("👍完全显示 ${changeY.toInt()}");
          if (changeY <= -56) {
            _y = 56;
            _firstY = d;
            _hideBottomBar = 0;
          } else if ((-56 <= changeY) && (changeY <= 0)) {
            _y = 56;
            _hideBottomBar = 0;
          } else if ((56 >= changeY) && (changeY > 0)) {
            _y = 56 - changeY;
            _hideBottomBar = 1;
          } else {
            _y = 0;
            _hideBottomBar = 2;
          }
        } else if (_hideBottomBar == 2) {
          // print("👎完全隐藏 ${changeY.toInt()}");
          if ((-56 <= changeY) && (changeY <= 0)) {
            _y = -changeY;
            _hideBottomBar = 1;
          } else if ((56 >= changeY) && (changeY > 0)) {
            // _y = 56 - changeY;
            _y = 0;
            _hideBottomBar = 2;
          } else if (changeY >= 56) {
            _y = 0;
            _firstY = d;
          } else {
            _y = 56;
            _hideBottomBar = 0;
          }
        } else if (_hideBottomBar == 1) {
          if (changeY >= 56) {
            _y = 0;
            // print("过渡 changeY= ${changeY.toInt()}，changeY[56,++)，转成隐藏");
            _firstY = d;
            _hideBottomBar = 2;
          } else if ((-56 <= changeY) && (changeY < 0)) {
            _y = -changeY;
            if (_y <= 3) {
              _firstY -= 59;
              _hideBottomBar = 2;
            }
            if (_y >= 53) {
              _firstY += 59;
              _hideBottomBar = 0;
            }
            // print("过渡changeY= ${changeY.toInt()},[-56，0），_y=${_y.toInt()}");

          } else if ((56 >= changeY) && (changeY >= 0)) {
            _y = 56 - changeY;
            if (_y <= 3) {
              _firstY -= 59;
              _hideBottomBar = 2;
            }
            if (_y >= 53) {
              _firstY += 59;
              _hideBottomBar = 0;
            }

            // print("过渡changeY= ${changeY.toInt()},[0，56]，_y=${_y.toInt()}");
            // _y = 0;
          } else {
            _y = 56;

            // print("过渡changeY= ${changeY.toInt()},(--，-56)，_y=${_y.toInt()}");
            _hideBottomBar = 0;
          }
        }
      }
    }

    // notifyListeners();
    update();
  }
}
