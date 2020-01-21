import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget userAvatar(String imgUrl, {double height}) {
  height ??= 38;
  if (!imgUrl.contains("assets/")) {
    // 如果不包含dingtalk则使用压缩模式
    imgUrl = imgUrl.contains("dingtalk")
        ? imgUrl
        : imgUrl +
            "?x-oss-process=image%2Fresize%2Cm_fill%2Cw_120%2Ch_120%2Fformat%2Cpng";
  }

  return ClipRRect(
    borderRadius: BorderRadius.circular(height / 2 + 3),
    child: Container(
      width: height,
      height: height,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(128, 116, 116, 116),
            offset: Offset(0, 0),
            blurRadius: 1,
          ),
        ],
      ),
      child: ClipOval(
        child: imgUrl.contains("assets/")
            ? Image.asset(imgUrl)
            : CachedNetworkImage(
                imageUrl: imgUrl,
                placeholder: (context, url) =>
                    CircularProgressIndicator(), //Colors.white10,
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
      ),
    ),
  );
}
