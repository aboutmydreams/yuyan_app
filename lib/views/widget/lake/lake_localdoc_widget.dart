import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/webview_page/webview_page.dart';

class LakeLocalDocWidget extends StatelessWidget {
  final Map json;

  const LakeLocalDocWidget({
    Key key,
    this.json,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var src = json['src'] as String;
    src = src.replaceFirst('attachments', 'office');
    src += "?view=doc_embed";
    var header = SizedBox(
      height: 32,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppIcon.iconType(json['ext'], size: 20),
          Text(
            '${json['name']}'.clip(18, ellipsis: true),
            style: TextStyle(
              color: Colors.blue,
              fontSize: 14,
            ),
          ),
          Spacer(),
          InkWell(
            child: Icon(Icons.visibility),
            onTap: () => MyRoute.webview(src),
          ),
          SizedBox(width: 12),
        ],
      ),
    );
    if (json['collapsed'] ?? false) {
      return Container(
        width: Get.width,
        margin: EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        child: header,
      );
    }
    return EmbedWebviewPage(
      url: src,
      header: header,
    );
  }
}
