import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/util/util.dart';

class LakeFileCardWidget extends StatelessWidget {
  final Map json;

  const LakeFileCardWidget({
    Key key,
    @required this.json,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: Get.width,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppIcon.iconType('file'),
            ),
            Expanded(
              child: Text(
                '${json['name']}'.clip(12, ellipsis: true),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            Spacer(),
            Expanded(
              flex: 2,
              child: Text(
                '${json['size']} bytes',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.download_outlined),
              ),
              onTap: () {
                launch(json['src']);
              },
            ),
          ],
        ),
      ),
    );
  }
}
