import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/route_manager.dart';

class LakeBookmarkWidget extends StatelessWidget {
  final Map json;

  LakeBookmarkWidget({
    Key key,
    this.json,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var detail = json['detail'];
    var child = Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        width: Get.width,
        child: ListTile(
          title: Text('${detail['title']}'),
          subtitle: Column(
            children: [
              Text('${detail['desc']}'),
              Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: detail['icon'] ?? '',
                    width: 16,
                    height: 16,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      child: Text(
                        '${json['src']}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    return GestureDetector(
      onTap: () {
        MyRoute.webview(json['src']);
      },
      child: child,
    );
  }
}
