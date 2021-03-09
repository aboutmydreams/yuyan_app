import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/controller/document/doc_controller.dart';
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
      ),
      body: GetBuilder<DocDetailController>(
        builder: (c) => c.stageBuilder(
          onIdle: () {
            Future.delayed(Duration(milliseconds: 100), () {
              title.value = c.value.title;
            });
            return LakeRenderWidget(
              data: c.value.content,
            );
          },
        ),
      ),
    );
  }
}
