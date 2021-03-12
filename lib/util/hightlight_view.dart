import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart' hide Node;
import 'package:highlight/highlight.dart' show highlight, Node;
import 'package:yuyan_app/views/begin_init/guide_page/test.dart';
import 'package:yuyan_app/views/widget/notification_absorb.dart';

/// Highlight Flutter Widget
class CodeBlockWidget extends StatelessWidget {
  /// The original code to be highlighted
  final String source;

  /// Highlight language
  ///
  /// It is recommended to give it a value for performance
  ///
  /// [All available languages](https://github.com/pd4d10/highlight/tree/master/highlight/lib/languages)
  final String language;

  /// Highlight theme
  ///
  /// [All available themes](https://github.com/pd4d10/highlight/blob/master/flutter_highlight/lib/themes)
  final Map<String, TextStyle> theme;

  /// Padding
  final EdgeInsetsGeometry padding;

  /// Text styles
  ///
  /// Specify text styles such as font family and font size
  final TextStyle textStyle;

  CodeBlockWidget(
    String input, {
    this.language,
    this.theme = const {},
    this.padding,
    this.textStyle,
    int tabSize = 8, // TODO: https://github.com/flutter/flutter/issues/50087
  }) : source = input.replaceAll('\t', ' ' * tabSize);

  List<InlineSpan> _convert(List<Node> nodes) {
    List<InlineSpan> spans = [];
    var currentSpans = spans;
    List<List<InlineSpan>> stack = [];

    _traverse(Node node) {
      if (node.value != null) {
        currentSpans.add(node.className == null
            ? TextSpan(text: node.value)
            : TextSpan(text: node.value, style: theme[node.className]));
      } else if (node.children != null) {
        List<InlineSpan> tmp = [];
        currentSpans.add(TextSpan(children: tmp, style: theme[node.className]));
        stack.add(currentSpans);
        currentSpans = tmp;

        node.children.forEach((n) {
          _traverse(n);
          if (n == node.children.last) {
            currentSpans = stack.isEmpty ? spans : stack.removeLast();
          }
        });
      }
    }

    for (var node in nodes) {
      _traverse(node);
    }

    return spans;
  }

  static const _rootKey = 'root';
  static const _defaultFontColor = Color(0xff000000);
  static const _defaultBackgroundColor = Color(0xffffffff);

  // TODO: dart:io is not available at web platform currently
  // See: https://github.com/flutter/flutter/issues/39998
  // So we just use monospace here for now
  static const _defaultFontFamily = 'monospace';

  @override
  Widget build(BuildContext context) {
    var _textStyle = TextStyle(
      fontFamily: _defaultFontFamily,
      color: theme[_rootKey]?.color ?? _defaultFontColor,
    );
    if (textStyle != null) {
      _textStyle = _textStyle.merge(textStyle);
    }

    var lines = source.split('\n').length;

    return Container(
      width: Get.width,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
        ),
        color: Colors.grey.withOpacity(0.1),
      ),
      child: Column(
        children: [
          Container(
            height: 24,
            child: Row(
              children: [
                Text('语言: $language'),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Column(
                  children: List.generate(lines, (index) {
                    return Container(
                      width: 36,
                      padding: EdgeInsets.only(right: 8),
                      child: Text(
                        '${index + 1}',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.grey.withOpacity(0.8),
                        ),
                      ),
                    );
                  }),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SelectableText.rich(
                      TextSpan(
                        style: _textStyle,
                        children: _convert(highlight
                            .parse(source, language: language)
                            .nodes),
                      ),
                      scrollPhysics: NeverScrollableScrollPhysics(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
