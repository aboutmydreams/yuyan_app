import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/controller/document/doc_controller.dart';
import 'package:yuyan_app/views/widget/drop_menu_item_widget.dart';
import 'package:yuyan_app/views/widget/lake_render_widget.dart';

class DocDetailPage extends StatefulWidget {
  final int bookId;
  final String slug;

  const DocDetailPage({
    Key key,
    this.bookId,
    this.slug,
  }) : super(key: key);

  @override
  _DocDetailPageState createState() => _DocDetailPageState();
}

class _DocDetailPageState extends State<DocDetailPage> {
  var title = '文档详情'.obs;
  var webUrl = 'https://www.yuque.com/';

  @override
  void initState() {
    super.initState();

    Get.put(DocDetailController(bookId: widget.bookId, slug: widget.slug));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(title.value)),
        elevation: 1,
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                value: () {
                  MyRoute.webview(webUrl);
                },
                child: MenuItemWidget(
                  iconData: Icons.open_in_browser,
                  title: '浏览器打开',
                ),
              ),
              // PopupMenuItem(
              //   value: () {
              //     MyRoute.webview(webUrl);
              //   },
              //   child: MenuItemWidget(
              //     iconData: Icons.open_in_browser,
              //     title: '编辑',
              //   ),
              // ),
              PopupMenuItem(
                value: () {
                  var c = Get.find<DocDetailController>();
                  MyRoute.webview('https://www.yuque.com/go/doc/${c.value.id}');
                },
                child: MenuItemWidget(
                  iconData: Icons.share,
                  title: '分享',
                ),
              ),
              PopupMenuItem(
                value: () {
                  launch(webUrl);
                },
                child: MenuItemWidget(
                  iconData: Icons.open_in_new,
                  title: '其它应用打开',
                ),
              ),
            ],
            onSelected: (_) => _?.call(),
          ),
        ],
      ),
      body: GetBuilder<DocDetailController>(
        builder: (c) => c.stateBuilder(
          onIdle: () {
            Future.delayed(Duration(milliseconds: 100), () {
              webUrl = 'https://www.yuque.com/go/doc/${c.value.id}';
              title.value = c.value.title;
            });
            return LakeRenderWidget(
              data: c.value.content,
              docId: c.value.id,
            );
          },
        ),
      ),
    );
  }
}
