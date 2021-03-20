import 'package:bot_toast/bot_toast.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart' hide Node;
import 'package:highlight/highlight.dart' show highlight, Node;

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

  InlineSpan _parseTree(Node node) {
    return TextSpan(
      style: theme[node.className]?.copyWith(
        fontSize: 12,
      ),
      text: node.value,
      children: node.children?.map((e) => _parseTree(e))?.toList(),
    );
  }

  List<InlineSpan> _convert(List<Node> nodes) {
    debugPrint('begin _convert');
    return nodes.map((e) => _parseTree(e)).toList();
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
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$language'),
                GestureDetector(
                  onTap: () {
                    FlutterClipboard.copy(source).then((_) {
                      BotToast.showText(text: 'copied');
                    });
                  },
                  child: Text('复制'),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: List.generate(lines, (index) {
                    return Container(
                      width: 36,
                      padding: const EdgeInsets.only(right: 4),
                      child: Text.rich(
                        TextSpan(text: '${index + 1}'),
                        textAlign: TextAlign.end,
                        style: _textStyle.copyWith(
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
                        children: _convert(
                            highlight.parse(source, language: language).nodes),
                      ),
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
