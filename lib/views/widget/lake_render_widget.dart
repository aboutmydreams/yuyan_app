import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/theme_map.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';

// ignore: implementation_imports
import 'package:flutter_html/src/css_parser.dart' as cssutil;
import 'package:csslib/parser.dart' as cssparser;
import 'package:csslib/visitor.dart' as css;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as htmlparser;
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:romanice/romanice.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/controller/action_controller.dart';
import 'package:yuyan_app/model/document/card/card_link_detail.dart';
import 'package:yuyan_app/model/document/card/card_video_seri.dart';
import 'package:yuyan_app/model/document/card/vote_item_seri.dart';
import 'package:yuyan_app/model/document/doc.dart';
import 'package:yuyan_app/model/document/lake/lake_card_seri.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/util/svg_provider.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/image_page/image_view_page.dart';
import 'package:yuyan_app/views/webview_page/webview_page.dart';
import 'package:yuyan_app/views/widget/label_widget.dart';
import 'package:yuyan_app/views/widget/lake_calendar_widget.dart';
import 'package:yuyan_app/views/widget/lake_card_widget.dart';
import 'package:yuyan_app/views/widget/lake_image_widget.dart';
import 'package:yuyan_app/views/widget/lake_localdoc_widget.dart';
import 'package:yuyan_app/views/widget/lake_locktext_widget.dart';
import 'package:yuyan_app/views/widget/lake_mention_widget.dart';
import 'package:yuyan_app/views/widget/lake_svg_widget.dart';
import 'package:yuyan_app/views/widget/notification_absorb.dart';
import 'package:yuyan_app/views/widget/video_widget.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' as inapp;
import 'package:webview_flutter/webview_flutter.dart' as view;
import 'package:yuyan_app/views/widget/vote_card_widget.dart';

import 'lake_task_item_widget.dart';
import 'lake_yuquecard_widget.dart';
import 'code_block_widget.dart';
import 'lake_bookmark_widget.dart';
import 'lake_filecard_widget.dart';
import 'lake_inlinelink_widget.dart';

extension ListEx<T extends num> on List<T> {
  T sum() {
    return this.reduce((a, b) => a + b);
  }
}

extension IterEx<T extends num> on Iterable<T> {
  T sum() {
    if (this.length == 0) return 0.0 as T;
    return this.reduce((a, b) => a + b);
  }
}

class HtmlUtil {
  static Map<String, List<css.Expression>> parseInlineStyle(
      String inlineStyle) {
    final sheet = cssparser.parse("*{$inlineStyle}");
    final declarations = cssutil.DeclarationVisitor().getDeclarations(sheet);
    return declarations;
  }

  static double parseDouble(value) {
    return double.tryParse('$value');
  }

  static double calculateTextHeight({double fontSize}) {
    TextPainter painter = TextPainter(
      ///AUTO：华为手机如果不指定locale的时候，该方法算出来的文字高度是比系统计算偏小的。
      locale: Localizations.localeOf(Get.context, nullOk: true),
      maxLines: 1,
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: '\n\n',
        style: TextStyle(
          fontSize: fontSize,
        ),
      ),
    );
    painter.layout(maxWidth: Get.width);

    ///文字的宽度:painter.width
    return painter.height;
  }

  static double getInlineStyleValue(String inlineStyle, String property,
      [double fallback]) {
    if (inlineStyle == null) return fallback;
    var style = HtmlUtil.parseInlineStyle(inlineStyle);
    var width = style[property].first as css.LengthTerm; // css.LengthTerm;
    return HtmlUtil.parseDouble(width.value) ?? fallback;
  }

  static String orderIndicator(int index, [int style = 0]) {
    switch (style % 3) {
      case 0:
        return '$index';
      case 1:
        index--;
        final n = 'a'.codeUnitAt(0);
        var ans = String.fromCharCode(n + index % 26);
        index ~/= 26;
        for (; index > 0; index ~/= 26) {
          var char = String.fromCharCode(n + index % 26 - 1);
          ans = char + ans;
        }
        return ans;
      case 2:
        final rome = Romanice.standard();
        return rome.toRoman(index).toLowerCase();
    }
    return 'null';
  }

  static applyInlineStyle(String inlineStyle, Style style) {
    assert(style != null, 'passed an null value to style');
    var parsed = parseInlineStyle(inlineStyle);
    parsed.forEach((key, value) {
      switch (key) {
        case 'background-color':
          style.backgroundColor =
              cssutil.ExpressionMapping.expressionToColor(value.first);
          break;
        case 'color':
          style.color =
              cssutil.ExpressionMapping.expressionToColor(value.first);
          break;
        case 'text-align':
          style.textAlign =
              cssutil.ExpressionMapping.expressionToTextAlign(value.first);
          break;
      }
    });
  }
}

class LakeRenderWidget extends StatefulWidget {
  final String data;
  final bool shrinkWrap;
  final int docId; //docId used for vote card

  LakeRenderWidget({
    Key key,
    this.docId,
    this.data = '<h1>Empty Page</h1>',
    this.shrinkWrap = false,
  }) : super(key: key);

  @override
  _LakeRenderWidgetState createState() => _LakeRenderWidgetState();
}

class _LakeRenderWidgetState extends State<LakeRenderWidget> {
  final Widget _fallbackWidget = SizedBox.shrink();
  String data;

  initState() {
    super.initState();
    var tree = htmlparser.parse(widget.data);
    var spans = tree.getElementsByTagName('span');
    spans.forEach((elem) {
      var attr = elem.attributes;
      if (elem.attributes['style'] != null) {
        // HtmlUtil.applyInlineStyle(attr['style'], _.style);
      }
      if (attr['class'] != null) {
        //handle fontsize
        var font = attr['class'].replaceFirst('lake-fontsize-', '');
        var size = int.tryParse(font) ?? 12;
        if (size > 128) size = 128;
        //ps, 由于flutter_html先渲染了child, 导致无法通过修改style来设置字体
        //但是span里面嵌入的内容可能比较复杂，这里仅仅是为了显示特定字体做出的妥协罢了，无奈
        var style = attr['style']?.split(';');
        if (style == null) style = <String>[];
        style.add('font-size: $font');
        attr['style'] = style.join(';');
      }
    });
    data = tree.outerHtml;
    assert(data != null && data != '');
  }

  _fallbackRender(_, child, attr, elem) {
    return _fallbackWidget;
  }

  final _htmlStyle = {
    '*': Style(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.only(right: 2),
      letterSpacing: 1.5,
    ),
    'li': Style(
      listStylePosition: ListStylePosition.INSIDE,
      padding: EdgeInsets.zero,
    ),
    'h1': Style(
      padding: EdgeInsets.only(left: 12, bottom: 6),
      fontSize: FontSize(30),
    ),
    'h2': Style(
      padding: EdgeInsets.only(left: 12, bottom: 6),
      fontSize: FontSize(26),
    ),
    'h3': Style(
      padding: EdgeInsets.only(left: 12, bottom: 4),
      fontSize: FontSize(23),
    ),
    'h4': Style(
      padding: EdgeInsets.only(left: 12, bottom: 3),
      fontSize: FontSize(20),
    ),
    'h5': Style(
      padding: EdgeInsets.only(left: 12, bottom: 2),
      fontSize: FontSize(16),
    ),
    'h6': Style(
      padding: EdgeInsets.only(left: 12, bottom: 1),
      fontSize: FontSize(14),
    ),
    'a': Style(
      textDecoration: TextDecoration.none,
    ),
    'img': Style(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    ),
    'blockquote': Style(
      color: Colors.grey,
    ),
  };

  var imgUrl = <String>[];

  _lakeCardRender(RenderContext _, Widget child, Map attr, dom.Element elem) {
    // var type = attr['type']; //style type
    var name = attr['name']; //type name
    var value = attr['value']; //json value
    if (value == null) {
      switch (name) {
        case 'hr':
          return Divider();
        default:
          debugPrint("unhandled card: $name");
          return ListTile(
            title: Text('暂时不支持的卡片格式'),
            subtitle: Text('type: $name'),
          );
      }
    }
    var raw = Uri.decodeComponent(value);
    var json = jsonDecode(raw.substring(5));
    // debugPrint('elem: $elem');
    attr['value'] = '!value!'; //for less print
    debugPrint('attr: $attr');
    switch (name) {
      case 'vote':
        return VoteCardWidget(
          docId: widget.docId,
          json: json,
        );
      case 'thirdparty':
        return EmbedWebviewPage(
          url: json['url'],
        );
      case 'mention':
        return LakeMentionWidget(
          name: json['name'],
          login: json['login'],
        );
      case 'bookmarklink':
        return LakeBookmarkWidget(json: json);
      case 'localdoc':
        return LakeLocalDocWidget(json: json);
      case 'diagram':
        return LakeCardWrapWidget(
          type: 'diagram',
          child: LakeSvgPicture(url: json['url']),
        );
      case 'flowchart2':
        return LakeCardWrapWidget(
          type: 'flowchart2',
          child: CachedNetworkImage(
            imageUrl: json['src'],
          ),
        );
      case 'math':
        return LakeCardWrapWidget(
          margin: null,
          type: 'math',
          params: json,
          child: LakeSvgPicture(url: json['src']),
        );
      case 'mindmap':
        return LakeCardWrapWidget(
          type: '思维导图',
          child: CachedNetworkImage(
            imageUrl: json['src'],
          ),
        );
      case 'lockedtext':
        return LakeLockTextWidget(json: json);
      case 'calendar':
        return LakeCalenderWidget(json: json);
      case 'codeblock':
        return CodeBlockWidget(
          json['code'],
          language: json['mode'] ?? 'plain',
          padding: EdgeInsets.all(8),
          theme: themeMap['github'],
        );
      case 'file':
        return LakeFileCardWidget(json: json);
      case 'yuqueinline': //语雀链接
        var link = CardLinkDetailSeri.fromJson(json['detail']);
        return LakeInlineLinkWidget(link: link);
      case 'table':
        //TODO(@dreamer2q): 表格的高度可能没有给出，如何自动适应高度?
        return Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(vertical: 8),
          child: LakeRenderWidget(
            data: json['html'],
            shrinkWrap: true,
          ),
        );
      case 'video':
        return LakeVideoPlayWidget(
          item: CardVideoSeri.fromJson(json),
        );
      case 'label':
        return LabelWidget(
          label: json['label'],
          colorIndex: json['colorIndex'],
        );
      case 'yuque':
        var card = LakeCardSeri.fromJson(json);
        return LakeYuqueCardWidget(card: card);
      case 'image':
        return LakeImageWidget(json: json, others: imgUrl);
      case 'checkbox':
        return LakeTaskItemWidget(value: json);
      default:
        debugPrint('unhandled type: $name');
        return Container(
          width: Get.width,
          margin: const EdgeInsets.all(8),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.red,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Text(
                '暂不支持的卡片: $name',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SelectableText('$json'),
            ],
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    // int _colIndex = 0;
    int _rowIndex = 0;
    double _tableWidth = 0;
    double _tableHeight = 0;
    List<double> _tableColWidth = [];
    List<double> _tableRowHeight = [];
    List<List<bool>> _tableFilled = [];
    List<Widget> _stackChildren = [];

    final Map<String, CustomRender> _customRender = {
      'cursor': (_, child, attr, elem) {
        //skip cursor,如果不跳过cursor附近的内容就无法渲染出来
        return child;
      },
      'a': (_, child, attr, elem) {
        debugPrint('$attr');
        return GestureDetector(
          onTap: () {
            MyRoute.webview(attr['href']);
          },
          child: child,
        );
      },
      'ul': (_, child, attr, elem) {
        var indent = attr['data-lake-indent'];
        int index = int.tryParse(indent ?? "0") ?? 0;
        return Padding(
          padding:
              EdgeInsets.only(left: 14.0 + 20.0 * index, top: 2, bottom: 2),
          child: child,
        );
      },
      'ol': (_, child, attr, elem) {
        var indent = attr['data-lake-indent'];
        int index = int.tryParse(indent ?? "0") ?? 0;
        return Padding(
          padding:
              EdgeInsets.only(left: 14.0 + 20.0 * index, top: 2, bottom: 2),
          child: child,
        );
      },
      'li': (_, child, attr, elem) {
        var isTask = attr['class']?.contains('lake-list-task');
        if (isTask ?? false) {
          return Padding(
            padding: const EdgeInsets.only(left: 14),
            child: child,
          );
        }
        var isOrderItem = elem.parent.localName == 'ol';
        var intent = elem.parent.attributes['data-lake-indent'] ?? '0';
        var index = int.tryParse(intent) ?? 0;
        if (isOrderItem ?? false) {
          var start = elem.parent.attributes['start'] ?? '1';
          int orderIndex = int.tryParse(start) ?? 1;
          orderIndex += elem.parent.nodes.indexOf(elem);
          var olMark = '${HtmlUtil.orderIndicator(orderIndex, index)}. ';
          return Stack(
            children: [
              PositionedDirectional(
                start: 0,
                width: 24,
                bottom: 0,
                child: Text(
                  olMark,
                  textAlign: TextAlign.center,
                  style: _.style.generateTextStyle().copyWith(letterSpacing: 0),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 26),
                child: child,
              ),
            ],
          );
        }
        return Stack(
          children: [
            PositionedDirectional(
              start: 0,
              width: 18,
              child: Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: index % 2 == 0 ? BoxShape.circle : BoxShape.rectangle,
                  color: index % 4 >= 2 ? Colors.transparent : _.style.color,
                  border:
                      index % 4 >= 2 ? Border.all(color: Colors.black) : null,
                ),
                width: 8,
                height: 8,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 18),
              child: child,
            ),
          ],
        );
      },
      'code': (_, child, attr, elem) {
        return Container(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.16),
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
              width: 0.5,
            ),
          ),
          child: child,
        );
      },
      'span': (_, child, attr, elem) {
        debugPrint('render span !!!');
        if (elem.nodes.length > 0 && elem.nodes.first is dom.Element) {
          var firstElem = elem.nodes.first as dom.Element;
          if (firstElem.localName == 'br') {
            debugPrint('span => br');
            final height = HtmlUtil.calculateTextHeight();
            return Container(
              height: height,
              child: child,
            );
          }
        }
        // FontSize fontSize;
        if (attr['style'] != null) {
          HtmlUtil.applyInlineStyle(attr['style'], _.style);
        }
        // if (attr['class'] != null) {
        //   //handle fontsize
        //   var font = attr['class'].replaceFirst('lake-fontsize-', '');
        //   var size = int.tryParse(font) ?? 12;
        //   if (size > 128) size = 128;
        //   fontSize = FontSize(size.toDouble());
        //   //ps, 由于flutter_html先渲染了child, 导致无法通过修改style来设置字体
        //   //但是span里面嵌入的内容可能比较复杂，这里仅仅是为了显示特定字体做出的妥协罢了，无奈
        //   return TextSpan(
        //     text: elem.text,
        //     style: _.style.generateTextStyle().copyWith(
        //           fontSize: fontSize.size,
        //         ),
        //   );
        // }
        return null;
      },
      'p': (_, child, attr, elem) {
        if (elem.nodes.length > 0) {
          var firstElem = elem.nodes.first;
          if (firstElem is dom.Element) {
            if (firstElem.localName == 'br') {
              debugPrint('p => br');
              final height = HtmlUtil.calculateTextHeight();
              return Container(
                height: height,
                child: child,
              );
            }
          }
        }
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: child,
        );
      },
      'blockquote': (_, child, attr, elem) {
        return Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Colors.grey.withOpacity(0.5),
                  width: 3,
                ),
              ),
            ),
            padding: EdgeInsets.only(left: 4),
            child: child,
          ),
        );
      },
      'table': (_, child, attr, elem) {
        // 这里的child被抛弃了，它不做渲染结果
        _tableWidth = HtmlUtil.getInlineStyleValue(attr['style'], 'width');
        return NotificationAbsorbWidget(
          child: Scrollbar(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: _tableWidth,
                height: _tableHeight,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.5),
                ),
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Stack(children: _stackChildren),
              ),
            ),
          ),
        );
      },
      'colgroup': (_, child, attr, elem) {
        debugPrint('colgroup');
        elem.nodes.forEach((node) {
          var width = HtmlUtil.parseDouble(node.attributes['width']) ?? 250;
          _tableWidth += width;
          _tableColWidth.add(width);
          debugPrint('col => width: $width');
        });
        elem.parent.nodes[1].nodes.forEach((node) {
          var height = HtmlUtil.getInlineStyleValue(
              node.attributes['style'], 'height', 100);
          height *= 1.25;
          _tableHeight += height;
          _tableRowHeight.add(height);
          debugPrint('tr => height: $height');
        });
        _tableFilled = List.generate(_tableRowHeight.length,
            (_) => List.generate(_tableColWidth.length, (_) => false));
        return _fallbackWidget;
      },
      'col': _fallbackRender,
      'tbody': _fallbackRender,
      'tr': (_, child, attr, elem) {
        // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        //   debugPrint('tr !!!!!!!!!!!!!!!!!');
        //   _.buildContext.visitChildElements((element) {
        //     debugPrint('tr => element => depth ${element.depth} ${element.size}, ${element.widget}');
        //   });
        //   debugPrint('tr ||||||||||||||||||');
        // });
        _rowIndex++;
        return _fallbackWidget;
      },
      'td': (_, child, attr, elem) {
        //! 构建核心！
        var colspan = int.tryParse(attr['colspan'] ?? '1') ?? 1;
        var rowspan = int.tryParse(attr['rowspan'] ?? '1') ?? 1;
        var colIndex = _tableFilled[_rowIndex].indexOf(false);
        var left = _tableColWidth.take(colIndex).sum();
        var top = _tableRowHeight.take(_rowIndex).sum();
        var width = _tableColWidth.getRange(colIndex, colIndex + colspan).sum();
        var height =
            _tableRowHeight.getRange(_rowIndex, _rowIndex + rowspan).sum();
        for (int i = 0; i < rowspan; i++) {
          _tableFilled[_rowIndex + i]
              .fillRange(colIndex, colIndex + colspan, true);
        }
        var stackChild = Positioned(
          left: left,
          top: top,
          child: Container(
            width: width,
            height: height,
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
            child: child,
          ),
        );
        _stackChildren.add(stackChild);
        debugPrint('td[add] => size => $widget, $height');
        // debugPrint('td => size => ${_.buildContext.size}');
        return _fallbackWidget;
      },
      'card': _lakeCardRender,
    };

    return Scrollbar(
      child: SingleChildScrollView(
        child: Html(
          shrinkWrap: widget.shrinkWrap,
          data: data,
          style: _htmlStyle,
          customRender: _customRender,
        ),
      ),
    );
  }
}
