import 'package:scoped_model/scoped_model.dart';

class BottomManage extends Model {
  bool _hideBottomBar = false;
  bool get hideBottomBar => _hideBottomBar;

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
    firstTime = DateTime.now();
  }

  bool isFirst() {
    // var difference = firstTime.difference(thatTime);
    return (d1 - _nowY).abs() < 1;
  }

  void addPixels(double d) {
    if (isFirst()) {
      // 记录第一次 y
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
      if (changeY > 56) {
        _y = 0;
        // _firstY = _nowY;
      } else if ((56 > changeY) && (changeY > 0)) {
        _y = changeY;
      } else if ((-56 < changeY) && (changeY < 0)) {
        _y = -changeY;
      } else {
        _y = 56;
      }
    }

    if (d2 > d1) {
      _hideBottomBar = true;
    } else {
      _hideBottomBar = false;
    }
    // _y = d2 - d1 > 0 ? 0 : 56;

    notifyListeners();
  }
}
