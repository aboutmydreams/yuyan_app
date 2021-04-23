import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/app.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/controller/document/doc_controller.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/widget/menu_item.dart';
import 'package:yuyan_app/views/widget/lake/lake_render.dart';

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

  String get tag => '${widget.bookId}';

  @override
  void initState() {
    super.initState();

    Get.put(
      DocDetailController(bookId: widget.bookId, slug: widget.slug),
      tag: tag,
    );
  }

  @override
  Widget build(BuildContext context) {
    var c = Get.find<DocDetailController>(tag: tag);
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
                  title: '打开网页版',
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
                  MyRoute.webview('https://www.yuque.com/go/doc/${c.value.id}');
                },
                child: MenuItemWidget(
                  iconData: Icons.share,
                  title: '分享',
                ),
              ),
              PopupMenuItem(
                value: () {
                  Util.launchURL(webUrl);
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
        tag: tag,
        builder: (c) => c.stateBuilder(
          onIdle: () {
            Future.delayed(Duration(milliseconds: 100), () {
              webUrl = 'https://www.yuque.com/go/doc/${c.value.id}';
              title.value = c.value.title;

              App.analytics.logEvent(
                name: 'view_doc_detail',
                parameters: {
                  'title': title.value,
                  'url': webUrl,
                },
              );
            });
            return Scrollbar(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    LakeRenderWidget(
                      data: c.value.content,
                      docId: c.value.id,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
