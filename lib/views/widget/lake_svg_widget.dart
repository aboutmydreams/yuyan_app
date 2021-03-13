import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LakeSvgPicture extends StatelessWidget {
  final String url;
  final int width;
  final int height;

  const LakeSvgPicture({
    Key key,
    @required this.url,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var future = Dio().get(url);
    return FutureBuilder(
      future: future,
      builder: (_, snap) {
        if (snap.hasError) {
          return IconButton(
            icon: Icon(Icons.error),
            color: Colors.red,
            onPressed: () {
              BotToast.showText(text: 'error: ${snap.error}');
            },
          );
        }
        if (snap.hasData) {
          var data = snap.data.data as String;
          data = data.replaceAll('currentColor', 'black');
          return SvgPicture.string(
            data,
            width: width?.toDouble(),
            height: height?.toDouble(),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
