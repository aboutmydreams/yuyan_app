import 'package:yuyan_app/models/oauth2/random_string/random_string.dart';

class Util {
  static String genHeroTag() {
    String tag =
        randomString(5) + DateTime.now().microsecondsSinceEpoch.toString();
    return tag;
  }

  static String timeCut(String time) {
    DateTime thatTime = DateTime.parse(time);
    DateTime nowTime = DateTime.now();
    var difference = nowTime.difference(thatTime);
    String passTime = (difference.inDays > 1)
        ? difference.inDays.toString() + " 天前"
        : (difference.inMinutes > 60)
            ? difference.inHours.toString() + " 小时前"
            : (difference.inMinutes > 1)
                ? difference.inMinutes.toString() + " 分钟前"
                : (difference.inSeconds > 1)
                    ? difference.inSeconds.toString() + " 秒前"
                    : "一瞬间前";
    return passTime;
  }
}
