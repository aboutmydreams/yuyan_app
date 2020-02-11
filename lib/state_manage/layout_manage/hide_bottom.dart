import 'package:scoped_model/scoped_model.dart';

class BottomManage extends Model {
  bool _hideBottomBar = false;
  bool get hideBottomBar => _hideBottomBar;

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
    _hideBottomBar = !_hideBottomBar;
    notifyListeners();
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
    return firstCome && !_hideBottomBar;
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
      } else if ((d3 > d2 && d3 > d) || (d3 < d2 && d3 < d)) {
        // 拐点
        print("拐点来了！$_hideBottomBar");
        _firstY = d;
        // firstCome = true;

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
        if (!_hideBottomBar) {
          // 完全没有隐藏
          print("完全没有隐藏changeY");
          if (changeY <= -56) {
            _y = 56;
            _firstY = d;
          } else if ((-56 <= changeY) && (changeY <= 0)) {
            // _y = -changeY;
            _y = 56;
          } else if ((56 >= changeY) && (changeY > 0)) {
            _y = 56 - changeY;
          } else {
            _y = 0;
            _hideBottomBar = true;
          }
        } else {
          print("完全隐藏$changeY");
          if (changeY >= 56) {
            _y = 0;
            _firstY = d;
          } else if ((-56 <= changeY) && (changeY <= 0)) {
            _y = -changeY;
          } else if ((56 >= changeY) && (changeY > 0)) {
            // _y = 56 - changeY;
            _y = 0;
          } else {
            _y = 56;
            _hideBottomBar = false;
          }
        }

        // if (changeY > 56) {
        //   _y = 0;
        //   // 第一次完全隐藏
        //   _hideBottomBar = true;
        //   // _firstY = _nowY;
        // } else if ((56 >= changeY) && (changeY > 0)) {
        //   _y = 56 - changeY;
        // } else if ((-56 <= changeY) && (changeY <= 0)) {
        //   _y = -changeY;
        // } else if (changeY < -56) {
        //   _y = 56;
        //   // print("来了56");
        //   _hideBottomBar = false;
        // } else {
        //   print("什么情况$changeY");
        // }
      }
    }

    // if (d2 > d1) {
    //   _hideBottomBar = true;
    // } else {
    //   _hideBottomBar = false;
    // }
    // _y = d2 - d1 > 0 ? 0 : 56;

    notifyListeners();
  }
}
