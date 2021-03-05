import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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

  static ossImg(String imgUrl) {
    final String suffix =
        "?x-oss-process=image%2Fresize%2Cm_fill%2Cw_120%2Ch_120%2Fformat%2Cpng";
    // 如果不包含某些关键词 则使用压缩模式
    if (imgUrl == null) {
      return null;
    }
    if (imgUrl.contains("dingtalk") ||
        imgUrl.contains("aliyuncs") ||
        imgUrl.contains("alipay") ||
        imgUrl.contains("assets/") ||
        imgUrl.contains("x-oss-process")) {
      return imgUrl;
    } else {
      return imgUrl + suffix;
    }
  }

  // static String clearText(String text) {
  //   // RegExp exp = new RegExp(r'<[^>]+>'); // html
  //   RegExp emojiReg = RegExp(
  //       r"\ud83c[\udf00-\udfff] | \ud83d[\udc00-\ude4f] | \ud83d[\ude80-\udeff]"); // emoji
  //   String ret = text.replaceAll(emojiReg, '').replaceAll('\n', '');
  //   return ret;
  // }

  static String stringClip(String str, int max, {bool ellipsis = false}) {
    var length = str.runes.length;
    if (length > max) {
      var result = runeSubstring(str, 0, max); //.substring(0, max);
      if (ellipsis) {
        result += '...';
      }
      return result;
    }
    return str;
  }

  //#35798 see https://github.com/dart-lang/sdk/issues/35798
  static String runeSubstring(String input, int start, int end) {
    return String.fromCharCodes(input.runes.toList().sublist(start, end));
  }

  static Widget animationTypeBuild({int type = 1, Widget child}) {
    switch (type) {
      case 1:
        return FadeInAnimation(child: child);
      case 2:
        return SlideAnimation(child: child);
      case 3:
        return ScaleAnimation(child: child);
      default:
        return FlipAnimation(child: child);
    }
  }
}

extension StringEx on String {
  String clip(int max, {bool ellipsis = false}) {
    return Util.stringClip(this, max, ellipsis: ellipsis);
  }
}
