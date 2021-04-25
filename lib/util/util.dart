import 'dart:io';
import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yuyan_app/config/app.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/config/viewstate/view_state.dart';
import 'package:yuyan_app/controller/app/theme_controller.dart';
import 'package:yuyan_app/model/dashboard/quick_link_seri.dart';
import 'package:yuyan_app/model/document/toc/toc_seri.dart';

import 'styles/app_ui.dart';

/// [futureResolver] is a convenient handler for
/// process future result, especially when error
/// might occur. It can also convert type
/// from [R] to [T]
Future<T> futureResolver<T, R>(
  Future<R> future, {
  T Function(R data) onData,
  T Function(dynamic err) onError,
}) async {
  try {
    var data = await future;
    var value = onData?.call(data);
    return Future.value(value);
  } catch (err) {
    debugPrint('futureWrap catch error: $err');
    var errValue = onError?.call(err);
    return Future.value(errValue);
  }
}

/// [futureBuilder] wraps [FutureBuilder] and expose
/// a more clean interface and convert error to [ViewError]
/// when error occurs. Useful for small gossip widget
/// without a [GetxController]
Widget futureBuilder<T>(
  Future<T> future, {
  Widget Function(T data) onData,
  Widget Function(ViewError err) onError,
  Widget onLoading = const CupertinoActivityIndicator(),
}) {
  return FutureBuilder(
    future: future,
    builder: (_, snapshot) {
      if (snapshot.hasError) {
        var viewErr = ViewStateUtil.handlerError(snapshot.error);
        if (onError == null) {
          return IconButton(
            icon: Icon(Icons.error),
            onPressed: () {
              Util.toast('错误：${viewErr.title}');
            },
          );
        }
        return onError(viewErr);
      }
      if (snapshot.hasData) {
        return onData(snapshot.data);
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: onLoading,
      );
    },
  );
}

class Util {
  static showConfirmDialog(
    BuildContext context, {
    String content,
    Function confirmCallback,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                confirmCallback();
                Navigator.of(context).pop();
              },
              child: Text("确认"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("取消"),
            ),
          ],
        );
      },
    );
  }

  static String get baseUrl {
    var login = App.currentSpaceProvider.data.login;
    return 'https://$login.yuque.com';
  }

  static List<Widget> listBuilder<T>({
    List<T> data,
    Widget Function(T) map,
  }) {
    return List.generate(
      data.length,
      (index) => map(data[index]),
    ).toList();
  }

  static Future refreshController<T>({String tag}) async {
    try {
      var controller = Get.find<T>(tag: tag) as dynamic;
      try {
        await controller.onRefresh();
        debugPrint('do refresh on ${T.runtimeType}');
      } on NoSuchMethodError catch (e) {
        debugPrint('do refresh: $e');
      }
    } on String catch (e) {
      debugPrint('get controller: $e');
    }
  }

  static double get pinnedHeight {
    var h = Get.mediaQuery.padding.top + 56 + 56 - 10;
    return h;
  }

  static Future<String> editorImageUploadCallback(File file) async {
    var res = await ApiRepository.postAttachFile(path: file.path);
    return res.url;
  }

  static Future futureWrap<T>(
    Future<T> future, {
    Function(T data) onData,
    Function(dynamic err) onError,
  }) async {
    try {
      var data = await future;
      var value = onData?.call(data);
      return Future.value(value);
    } catch (err) {
      debugPrint('futureWrap catch error: $err');
      return Future.value(onError?.call(err));
    }
  }



  static toast(String text) {
    BotToast.showCustomText(
      onlyOne: true,
      duration: Duration(seconds: 2),
      toastBuilder: (cancel) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: ThemeController.to.primarySwatchColor,
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(55, 0, 0, 0),
                offset: Offset(1, 2),
                blurRadius: 4,
              ),
            ],
            borderRadius: BorderRadius.circular(32.0),
          ),
          child: Text(
            "$text",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  static goUrl(String url) {
    MyRoute.webview('https://www.yuque.com' + url);
  }

  static launchURL(String url) {
    futureWrap(
      canLaunch(url),
      onData: (value) {
        if (value) {
          launch(url);
        } else {
          Util.toast('cannot open: $url');
        }
      },
    );
  }

  static handleQuickLinkNav(QuickLinkSeri link) {
    switch (link.type) {
      case 'Doc':
        // MyRoute.docDetail(bookId: link.targetId, slug: link);
        break;
      case 'Book':
        // MyRoute.bookDocs(link);
        break;
      case 'Group':
        // MyRoute.group(group: null);
        break;
      case 'User':
        // MyRoute.user(user: null);
        break;
      default:
        MyRoute.webview(link.url);
    }
  }

  static String genHeroTag() {
    String tag = DateTime.now().microsecondsSinceEpoch.toString();
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

  // 使用参考：https://juejin.cn/post/6844903822028963847
  static showWindow({String title, @required Widget child}) {
    Get.dialog(
      SimpleDialog(
        contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 12),
        title: Row(
          children: [
            Text(
              title ?? 'Dialog',
              style: AppStyles.textStyleB,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.close),
                ),
              ),
            )
          ],
        ),
        titlePadding: EdgeInsets.fromLTRB(26, 8, 10, 0),
        backgroundColor: AppColors.background,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        children: [
          child,
        ],
      ),
    );
  }

  static String getUrlBaseNameWithSplash(String url) {
    return url.substring(url.lastIndexOf('/'));
  }
}

extension StringEx on String {
  static Map<String, String> eventType = {
    //前后端都不统一规范下，吐了>
    "updateDoc": "更新了文档",
    "publishDoc": "发布了文章",
    "update_doc": "更新了文档",
    "like_doc": "打赏了稻谷",
    "publish_doc": "发布了文章",
    "watch_book": "关注了知识库",
    "follow_user": "关注了雀友",
    "like_artboard": "给画板赞赏了稻谷",
    "upload_artboards": "更新了画板"
  };

  String transEvent() {
    return eventType[this] ?? '未知事件';
  }

  String clip(int max, {bool ellipsis = false}) {
    return Util.stringClip(this, max, ellipsis: ellipsis);
  }

  DateTime toDateTime() {
    return DateTime.tryParse(this);
  }

  String parseAndCutTime() {
    return Util.timeCut(this);
  }
}

extension ListEx<T> on List<T> {
  T rand() {
    final _random = new Random();
    var item = this[_random.nextInt(this.length)];
    return item;
  }

  List<Widget> mapWidget(
    Widget Function(T item) map, {
    bool divide = false,
    Widget divider = const Divider(height: 0.5),
    Widget onEmpty = const SizedBox.shrink(),
  }) {
    if (GetUtils.isNullOrBlank(this)) {
      return [onEmpty];
    }
    if (!divide) {
      var list = this.map(map).toList();
      return list;
    }
    var list = <Widget>[];
    this.forEach((item) {
      list.add(map(item));
      list.add(divider);
    });
    return list..removeLast();
  }
}

extension ObjectEx on Object {
  /// [when] is a convenient method for conditional build
  /// [other] is a [VoidCallback], in order to void unnecessary build
  when(
    dynamic value, {
    Function other,
  }) {
    switch (value.runtimeType) {
      case bool:
        return onlyIf(value, elseif: other);
      case num:
        return onlyIf(value != 0, elseif: other);
      case List:
      case Map:
        return onlyIf(
          GetUtils.isNullOrBlank(value),
          elseif: other,
        );
    }
    return other();
  }

  onlyIf(bool condition, {Function elseif}) {
    return condition ? this : elseif();
  }
}

Widget _defaultWidget() => const SizedBox.shrink();

extension WidgetEx on Widget {
  onlyIf(
    bool only, {
    bool animation = true,
    Widget Function() elseif = _defaultWidget,
    Duration duration = const Duration(milliseconds: 225),
  }) {
    Widget child = (only ? this : elseif());
    if (animation) {
      return AnimatedSwitcher(
        duration: duration,
        child: child,
        // transitionBuilder: (child, anim) {
        //   return SlideTransition(
        //     position: Tween<Offset>(
        //       begin: Offset(0, -100),
        //       end: Offset(0, 0),
        //     ).animate(anim),
        //     child: child,
        //   );
        // },
      );
    }
    return child;
  }
}

extension NumEx<T extends num> on List<T> {
  T sum() {
    return this.reduce((a, b) => a + b);
  }
}

extension IterEx<T extends num> on Iterable<T> {
  T sum() {
    return this.reduce((a, b) => a + b);
  }
}
