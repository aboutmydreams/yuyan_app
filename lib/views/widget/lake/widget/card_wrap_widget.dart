import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:yuyan_app/util/styles/app_ui.dart';

// ignore: must_be_immutable
class LakeCardWrapWidget extends StatelessWidget {
  final String type;
  final Widget child;
  final Map params;
  final Color backgroundColor;
  final EdgeInsets margin;

  LakeCardWrapWidget({
    Key key,
    this.type,
    this.child,
    this.params,
    this.margin = const EdgeInsets.all(8),
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  int width;
  int height;
  Widget body;

  @override
  Widget build(BuildContext context) {
    if (params != null) {
      width = params['width'];
      height = params['height'];
      if (width != null && height != null && width < 100 && height < 100) {
        return SizedBox(
          width: width.toDouble(),
          height: height.toDouble(),
          child: child,
        );
      }
    }
    body = PhotoView.customChild(
      backgroundDecoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: child,
    );
    return Container(
      margin: margin,
      width: Get.width,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.withOpacity(0.8),
                ),
              ),
            ),
            child: Row(
              children: [
                Text(type ?? '未知卡片'),
                Spacer(),
                AppIcon.iconType(
                  'fullscreen',
                  onTap: _enterFull,
                ),
              ],
            ),
          ),
          Container(
            height: Get.width,
            child: body,
          ),
        ],
      ),
    );
  }

  _enterFull() {
    Get.dialog(
      GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(45),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Text('返回雨燕'),
                  Spacer(),
                  AppIcon.iconType('exit_fullscreen'),
                ],
              ),
            ),
          ),
          body: Container(
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: backgroundColor,
            ),
            child: body,
          ),
        ),
      ),
    );
  }
}
