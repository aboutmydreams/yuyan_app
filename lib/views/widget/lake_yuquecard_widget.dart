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

class YuquePremiumPurchase extends StatelessWidget {
  YuquePremiumPurchase({
    Key key,
    @required this.json,
  }) : super(key: key);

  final Map json;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                color: Colors.yellow,
                height: 1,
                width: 50,
              ),
              Text(
                '  💲 以下内容需要付费阅读  ',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 12,
                ),
              ),
              Container(
                color: Colors.yellow,
                height: 1,
                width: 50,
              ),
            ],
          ),
        ),
        Container(
          width: Get.width,
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
          margin: const EdgeInsets.only(bottom: 12),
          child: ElevatedButton(
            onPressed: () {
              Get.defaultDialog(
                title: '暂不支持',
                content: Text('暂不支持这种购买，请打开网页版进行操作'),
                onConfirm: () {
                  Get.back();
                },
              );
            },
            child: Text('${json['price']} 元付费阅读全文'),
          ),
        ),
      ],
    );
  }
}
