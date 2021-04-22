import 'dart:convert';

import 'package:delta_markdown/delta_markdown.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/models/documents/document.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:flutter_quill/widgets/editor.dart';
import 'package:flutter_quill/widgets/toolbar.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/app_ui.dart';
import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/util/util.dart';

class CommentModalSheet extends StatefulWidget {
  final Future<bool> Function(String mark) onPublish;
  final String hintText;

  CommentModalSheet({
    Key key,
    this.onPublish,
    this.hintText,
  }) : super(key: key);

  @override
  _CommentModalSheetState createState() => _CommentModalSheetState();
}

class _CommentModalSheetState extends State<CommentModalSheet> {
  final _controller = QuillController.basic();
  final _scrollController = ScrollController();
  final expanded = false.obs;
  final publishing = false.obs;

  Future<String> _imageUpload(File file) async {
    var res = await ApiRepository.postAttachFile(
      path: file.path,
    );
    return res.url;
  }

  @override
  Widget build(BuildContext context) {
    var editHeight = Get.height - Get.mediaQuery.viewInsets.bottom - 100;
    final toolBar = Row(
      children: [
        Expanded(
          child: QuillToolbar.basic(
            controller: _controller,
            onImagePickCallback: _imageUpload,
            showBackgroundColorButton: false,
            showHeaderStyle: false,
            showHorizontalRule: false,
            showColorButton: false,
            showClearFormat: false,
            showIndent: false,
            showHistory: false,
            showListNumbers: false,
            showStrikeThrough: false,
          ),
        ),
        Obx(
          () => TextButton(
            child: Text('发布'),
            onPressed: () async {
              try {
                publishing.value = true;
                var delta = _controller.document.toDelta();
                var deltaStr = jsonEncode(delta.toJson());
                var markdown = deltaToMarkdown(deltaStr);
                var result = await widget.onPublish.call(markdown);
                publishing.value = false;
                if (result) Get.back();
              } catch (e) {
                debugPrint('convert to markdown: $e');
              }
            },
          ).onlyIf(
            !publishing.value,
            elseif: () => const CupertinoActivityIndicator().paddingSymmetric(
              vertical: 14,
              horizontal: 22,
            ),
          ),
        ).onlyIf(widget.onPublish != null),
      ],
    );

    final editor = Obx(
      () => Container(
        constraints: BoxConstraints(
          maxHeight: editHeight,
        ),
        height: expanded.value ? double.infinity : null,
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        child: QuillEditor(
          placeholder: widget.hintText,
          controller: _controller,
          padding: const EdgeInsets.only(top: 4),
          scrollController: _scrollController,
          focusNode: FocusNode(),
          showCursor: true,
          scrollable: true,
          autoFocus: true,
          readOnly: false,
          expands: false,
        ),
      ),
    );

    final child = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: editor,
            ),
            IconButton(
              icon: Obx(
                () => Icon(
                  expanded.value ? Icons.expand_more : Icons.expand_less,
                ),
              ),
              onPressed: () {
                expanded.value = !expanded.value;
              },
            ),
          ],
        ),
        toolBar,
      ],
    );

    return SafeArea(
      maintainBottomViewPadding: true,
      minimum: Get.mediaQuery.viewInsets,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12),
          ),
        ),
        child: child,
      ),
    );
  }
}
