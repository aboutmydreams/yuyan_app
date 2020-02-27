import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yuyan_app/models/widgets_big/image_page/image_page.dart';

Widget imgHtml(BuildContext context, String imgUrl) {
  return GestureDetector(
    onTap: () {
      print("object");
      showDialog(
        context: context,
        builder: (context) {
          return ImagePage(
            imgUrl,
          );
        },
      );
    },
    child: Center(
      child: CachedNetworkImage(
        imageUrl: imgUrl,
        placeholder: (context, url) => new CircularProgressIndicator(
          valueColor:
              new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        ),
        errorWidget: (context, url, error) => new Icon(
          Icons.error,
          color: Colors.redAccent,
        ),
      ),
    ),
  );
}
