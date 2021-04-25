import 'dart:convert';

import 'package:delta_markdown/delta_markdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/models/documents/document.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:flutter_quill/widgets/editor.dart';
import 'package:flutter_quill/widgets/toolbar.dart';
import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/util/util.dart';

enum QuillEditorToolbarType {
  none,
  top,
  bottom,
}

class QuillEditorController extends QuillController {
  QuillEditorController()
      : super(
          document: Document(),
          selection: const TextSelection.collapsed(offset: 0),
        );

  String toMarkdown() {
    var delta = document.toDelta();
    var jsonStr = jsonEncode(delta).toString();
    var mark = deltaToMarkdown(jsonStr);
    debugPrint('markdown:\n$mark\n');
    // var html = await ApiRepository.convertLake(markdown: mark);
    return mark;
  }

  Future<String> toLakeHtml() async {
    var mark = toMarkdown();
    var lake = await ApiRepository.convertLake(markdown: mark);
    return lake;
  }
}

class QuillEditorWidget extends StatelessWidget {
  final QuillEditorController controller;
  final EdgeInsets padding;
  final bool autoFocus;
  final bool readOnly;
  final QuillEditorToolbarType toolbarType;

  const QuillEditorWidget({
    Key key,
    @required this.controller,
    this.padding = EdgeInsets.zero,
    this.autoFocus = false,
    this.readOnly = false,
    this.toolbarType = QuillEditorToolbarType.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var editor = QuillEditor(
      controller: controller,
      focusNode: FocusNode(),
      scrollController: ScrollController(),
      scrollable: true,
      padding: padding,
      autoFocus: autoFocus,
      readOnly: readOnly,
      expands: false,
    );
    var toolbar = QuillToolbar.basic(
      controller: controller,
      onImagePickCallback: Util.editorImageUploadCallback,
    );
    var children = <Widget>[
      Expanded(child: editor),
    ];
    switch (toolbarType) {
      case QuillEditorToolbarType.none:
        return editor;
      case QuillEditorToolbarType.bottom:
        children.add(toolbar);
        break;
      case QuillEditorToolbarType.top:
        children.insert(0, toolbar);
        break;
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}
