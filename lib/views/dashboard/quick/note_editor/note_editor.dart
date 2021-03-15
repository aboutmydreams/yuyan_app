import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/controller/global/upload_controller.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/views/dashboard/quick/note_editor/image_delegate.dart';

import 'package:zefyr/zefyr.dart';
import 'package:quill_delta/quill_delta.dart';

class MarkdownEditorPage extends StatefulWidget {
  @override
  _MarkdownEditorPageState createState() => _MarkdownEditorPageState();
}

class _MarkdownEditorPageState extends State<MarkdownEditorPage> {
  ZefyrController _zefyrController;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _zefyrController = ZefyrController(
      NotusDocument.fromDelta(Delta()..insert('\n')),
    );

    _zefyrController.document.changes.listen((event) {
      debugPrint('${event.source} => ${event.change}');
    });

    _focusNode = FocusNode();

    Get.put(NoteStatusController());
  }

  @override
  void dispose() {
    super.dispose();

    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoteStatusController>(
      builder: (c) => c.stateBuilder(
        onIdle: () {
          var id = c.value.mirror.docletId;
          return Scaffold(
            appBar: AppBar(
              title: Text('小记'),
              actions: [
                GetBuilder<PostNoteController>(
                  init: PostNoteController(c.value.mirror.id),
                  builder: (pub) {
                    if (pub.isLoadingState) return ViewLoadingWidget();
                    return FlatButton.icon(
                      onPressed: () async {
                        debugPrint('发布');
                        var res = await pub
                            .postNote(_zefyrController.document.toDelta());
                        BotToast.showText(text: res ? '发布成功' : '发布失败');
                        if (res) Get.back();
                      },
                      icon: Icon(
                        Icons.send_sharp,
                        color: Colors.white,
                      ),
                      label: Text(
                        '发布',
                        style: Get.theme.primaryTextTheme.bodyText1,
                      ),
                    );
                  },
                ),
              ],
            ),
            body: ZefyrScaffold(
              child: ZefyrEditor(
                controller: _zefyrController,
                focusNode: _focusNode,
                imageDelegate: NoteImageDelegate(id),
              ),
            ),
          );
        },
        onLoading: Scaffold(
          appBar: AppBar(
            title: Text('小记'),
          ),
        ),
      ),
    );
  }
}
