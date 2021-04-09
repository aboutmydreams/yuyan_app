import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/theme_map.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';
import 'package:csslib/parser.dart' as cssparser;
import 'package:csslib/visitor.dart' as css;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as htmlparser;
import 'package:get/get.dart';
import 'package:romanice/romanice.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/model/document/card/card_link_detail.dart';
import 'package:yuyan_app/model/document/card/card_video_seri.dart';
import 'package:yuyan_app/model/document/lake/lake_card_seri.dart';
import 'package:yuyan_app/config/app_ui.dart';
import 'package:yuyan_app/views/webview_page/webview_page.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' as inapp;
import 'package:webview_flutter/webview_flutter.dart' as view;

// ignore: implementation_imports
import 'package:flutter_html/src/layout_element.dart';

// ignore: implementation_imports
import 'package:flutter_html/src/css_parser.dart' as cssutil;

import 'code_block_widget.dart';
import 'video_widget.dart';
import 'label_widget.dart';
import 'lake_bookmark_widget.dart';
import 'lake_calendar_widget.dart';
import 'lake_card_widget.dart';
import 'lake_image_widget.dart';
import 'lake_inlinelink_widget.dart';
import 'lake_localdoc_widget.dart';
import 'lake_locktext_widget.dart';
import 'lake_mention_widget.dart';
import 'lake_svg_widget.dart';
import 'lake_task_item_widget.dart';
import 'lake_yuquecard_widget.dart';
import 'lake_filecard_widget.dart';
import 'vote_card_widget.dart';

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
      locale: Localizations.localeOf(Get.context),
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
  AutoScrollController _autoController = AutoScrollController();
  String data;

  initState() {
    super.initState();

    //预处理Lake的一些class，方便HTML渲染
    var tree = htmlparser.parse(widget.data);
    var spans = tree.getElementsByTagName('span');
    spans.forEach((elem) {
      var attr = elem.attributes;
      // if (elem.attributes['style'] != null) {
      //   // HtmlUtil.applyInlineStyle(attr['style'], _.style);
      // }
      if (attr['class'] != null) {
        //handle fontsize
        var font = attr['class'].replaceFirst('lake-fontsize-', '');
        var size = int.tryParse(font) ?? 12;
        if (size == 1515) size = 15; //shit, 语雀JB玩意
        if (size > 128) size = 128;
        //ps, 由于flutter_html先渲染了child, 导致无法通过修改style来设置字体
        //但是span里面嵌入的内容可能比较复杂，这里仅仅是为了显示特定字体做出的妥协罢了，无奈
        var style = attr['style']?.split(';');
        if (style == null) style = <String>[];
        style.add('font-size: $size');
        attr['style'] = style.join(';');
      }
    });
    data = tree.outerHtml;
    assert(data != null && data != '');
  }

  final _htmlStyle = {
    '*': Style(
      padding: EdgeInsets.zero,
      // fontFamily: 'source_han',
      // fontSize: FontSize(16),
      margin: EdgeInsets.only(right: 2),
      letterSpacing: 1.5,
    ),
    'li': Style(
      listStylePosition: ListStylePosition.INSIDE,
      padding: EdgeInsets.zero,
    ),
    'h1': Style(
      padding: EdgeInsets.only(left: 6, bottom: 6),
      fontSize: FontSize(30),
    ),
    'h2': Style(
      padding: EdgeInsets.only(left: 6, bottom: 6),
      fontSize: FontSize(26),
    ),
    'h3': Style(
      padding: EdgeInsets.only(left: 6, bottom: 4),
      fontSize: FontSize(23),
    ),
    'h4': Style(
      padding: EdgeInsets.only(left: 6, bottom: 3),
      fontSize: FontSize(20),
    ),
    'h5': Style(
      padding: EdgeInsets.only(left: 6, bottom: 2),
      fontSize: FontSize(16),
    ),
    'h6': Style(
      padding: EdgeInsets.only(left: 6, bottom: 1),
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
    'tbody': Style(
      border: Border.all(
        color: Colors.grey,
        width: 0.5,
      ),
    ),
    'tr': Style(
      border: Border.all(
        color: Colors.grey,
        width: 0.5,
      ),
    ),
  };

  //保存所有图片的链接
  var imgUrl = <String>[];

  _lakeCardRender(RenderContext _, Widget child) {
    var attr = _.tree.attributes;
    // var elem = _.tree.element;
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
    var decodeValue = Uri.decodeComponent(value);
    var jsonString = decodeValue.substring(5);
    // 可能会遇到 [jsonDecode] 解析失败的问题，这里先做一波预处理
    // 不知道后面会不会有其它情况没有考虑到的
    if (jsonString.endsWith('undefined')) {
      jsonString = '{}';
    }
    var json = jsonDecode(jsonString);
    // debugPrint('elem: $elem');
    attr['value'] = '!value!'; //for less print
    debugPrint('attr: $attr');
    switch (name) {
      case 'hr':
        return Divider();
      case 'premium':
        return YuquePremiumPurchase(json: json);
      case 'emoji':
        if (json is String) {
          //TODO(@dreamer2q): 添加 emoji widget 用于语雀的表情包
          return LakeImageWidget(
            json: {'src': json},
            others: [json],
          );
        }
        return LakeImageWidget(json: json, others: imgUrl);
      case 'youku':
        return EmbedWebviewPage(url: json['url']);
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
        //ATTENTION: 表格的排版使用了 flutter_layout_grid 库，它不支持嵌套
        return LakeRenderWidget(
          data: json['html'],
          shrinkWrap: true,
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

  _addPositionId(RenderContext _, Widget child) {
    var attr = _.tree.attributes;
    if (attr['id'] != null) {
      var index = attr['id'].hashCode;
      return AutoScrollTag(
        key: ValueKey(index),
        controller: _autoController,
        index: index,
        child: child,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, CustomRender> _customRender = {
      'h1': _addPositionId,
      'h2': _addPositionId,
      'h3': _addPositionId,
      'h4': _addPositionId,
      'h5': _addPositionId,
      'h6': _addPositionId,
      'cursor': (_, child) {
        //skip cursor,如果不跳过cursor附近的内容就无法渲染出来
        return child;
      },
      'a': (_, child) {
        var attr = _.tree.attributes;
        debugPrint('$attr');
        _.buildContext.widget;
        return GestureDetector(
          onTap: () {
            var href = attr['href'];
            if (href.startsWith('http')) {
              MyRoute.webview(attr['href']);
            } else if (href.startsWith('#')) {
              debugPrint('${href.substring(1)}');
              _autoController.scrollToIndex(href.substring(1).hashCode);
            }
          },
          child: child,
        );
      },
      'ul': (_, child) {
        var attr = _.tree.attributes;
        var indent = attr['data-lake-indent'];
        int index = int.tryParse(indent ?? "0") ?? 0;
        return Padding(
          padding:
              EdgeInsets.only(left: 14.0 + 20.0 * index, top: 2, bottom: 2),
          child: child,
        );
      },
      'ol': (_, child) {
        var attr = _.tree.attributes;
        var indent = attr['data-lake-indent'];
        int index = int.tryParse(indent ?? "0") ?? 0;
        return Padding(
          padding:
              EdgeInsets.only(left: 14.0 + 20.0 * index, top: 2, bottom: 2),
          child: child,
        );
      },
      'li': (_, child) {
        var attr = _.tree.attributes;
        var elem = _.tree.element;
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
                // bottom: 0,
                child: Text(
                  olMark,
                  textAlign: TextAlign.start,
                  // textAlign: TextAlign.end,
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
      'code': (_, child) {
        // var attr = _.tree.element;
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
      'span': (_, child) {
        var attr = _.tree.attributes;
        var elem = _.tree.element;
        if (elem.nodes.length > 0 && elem.nodes.first is dom.Element) {
          var firstElem = elem.nodes.first as dom.Element;
          if (firstElem.localName == 'br') {
            // debugPrint('span => br');
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
        return null;
      },
      'p': (_, child) {
        var elem = _.tree.element;
        if (elem.nodes.length > 0) {
          var firstElem = elem.nodes.first;
          if (firstElem is dom.Element) {
            if (firstElem.localName == 'br') {
              // debugPrint('p => br');
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
      'blockquote': (_, child) {
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
      'table': (_, child) {
        var inlineStyle = _.tree.attributes['style'];
        var width =
            HtmlUtil.getInlineStyleValue(inlineStyle, 'width', Get.width);
        _.style.width = width;
        var query = _.tree.element.querySelector("table");
        if (query != null) {
          return Container(
            padding: const EdgeInsets.all(24),
            child: Text(
              '暂不支持表格的嵌套，\n请打开网页版查看',
              style: AppStyles.textStyleA.copyWith(
                color: Colors.red,
              ),
            ),
          );
        }
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            width: width + 20,
            alignment: Alignment.center,
            constraints: BoxConstraints(
              maxWidth: width + 16,
            ),
            child: (_.tree as TableLayoutElement).toWidget(_),
          ),
        );
      },
      'card': _lakeCardRender,
    };

    return SingleChildScrollView(
      controller: _autoController,
      physics: widget.shrinkWrap ? NeverScrollableScrollPhysics() : null,
      child: Html(
        shrinkWrap: widget.shrinkWrap,
        data: data,
        style: _htmlStyle,
        customRender: _customRender,
      ),
    );
  }
}
