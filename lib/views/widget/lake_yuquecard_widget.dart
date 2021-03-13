import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/model/document/lake/lake_card_seri.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/views/webview_page/webview_page.dart';

class LakeYuqueCardWidget extends StatelessWidget {
  final LakeCardSeri card;

  const LakeYuqueCardWidget({
    Key key,
    this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (card.mode) {
      case 'embed':
        return EmbedWebviewPage(
          url: card.url,
          onUrlChanged: (url) {
            MyRoute.webview(url);
          },
        );
    }
    var detail = card.detail;
    return Container(
      margin: const EdgeInsets.all(8),
      width: Get.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.6),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: ListTileTheme(
        child: ListTile(
          isThreeLine: true,
          leading: AppIcon.iconType(detail.targetType, size: 40),
          title: Text(detail.title),
          subtitle: Text(detail.desc),
          onTap: () {
            //TODO(@dreamer2q): parse url, then open doc
            MyRoute.webview(detail.url);
          },
        ),
      ),
    );
  }
}
