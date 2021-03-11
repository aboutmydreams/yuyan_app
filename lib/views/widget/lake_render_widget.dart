import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/theme_map.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';

// ignore: implementation_imports
import 'package:flutter_html/src/css_parser.dart' as cssutil;
import 'package:csslib/parser.dart' as cssparser;
import 'package:csslib/visitor.dart' as css;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as htmlparser;
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:romanice/romanice.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/model/document/card/card_link_detail.dart';
import 'package:yuyan_app/model/document/card/card_video_seri.dart';
import 'package:yuyan_app/model/document/lake/lake_card_seri.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/open_page.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/util/svg_provider.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/image_page/image_view_page.dart';
import 'package:yuyan_app/views/my_page/my_page.dart';
import 'package:yuyan_app/views/webview_page/webview_page.dart';
import 'package:yuyan_app/views/widget/notification_absorb.dart';
import 'package:yuyan_app/views/widget/video_widget.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' as inapp;
import 'package:webview_flutter/webview_flutter.dart' as view;

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

  LakeRenderWidget({
    Key key,
    this.data = '<h1>Empty Page</h1>',
    this.shrinkWrap = false,
  }) : super(key: key);

  @override
  _LakeRenderWidgetState createState() => _LakeRenderWidgetState();
}

class _LakeRenderWidgetState extends State<LakeRenderWidget> {
  final Widget _fallbackWidget = SizedBox.shrink();

  @override
  Widget build(BuildContext context) {
    var imgUrl = <String>[];
    // int _colIndex = 0;
    int _rowIndex = 0;
    double _tableWidth = 0;
    double _tableHeight = 0;
    List<double> _tableColWidth = [];
    List<double> _tableRowHeight = [];
    List<List<bool>> _tableFilled = [];
    List<Widget> _stackChildren = [];

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

    final Map<String, CustomRender> _customRender = {
      'cursor': (_, child, attr, elem) {
        //skip cursor
        //如果不跳过cursor附近的内容就无法渲染出来
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
        debugPrint('parent element: ${elem.parent}');
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
                child: Text(
                  olMark,
                  textAlign: TextAlign.end,
                  style: _.style.generateTextStyle().copyWith(
                        letterSpacing: 0,
                      ),
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
                  color: index % 4 >= 2 ? Colors.transparent : Colors.black,
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
        FontSize fontSize;
        if (attr['class'] != null) {
          //handle fontsize
          var font = attr['class'].replaceFirst('lake-fontsize-', '');
          var size = int.tryParse(font) ?? 12;
          if (size > 128) size = 128;
          fontSize = FontSize(size.toDouble() * 1.5);
        }
        if (attr['style'] != null) {
          HtmlUtil.applyInlineStyle(attr['style'], _.style);
        }
        // return ContainerSpan(
        //   style: _.style.copyWith(
        //     fontSize: FontSize.xxLarge,
        //     height: fontSize != null ? fontSize.size : null,
        //   ),
        //   child: child,
        // );
        debugPrint('outHtml => ${elem.innerHtml}');
        return Container(
          alignment: fontSize != null ? Alignment.center : null,
          color: _.style.backgroundColor,
          height: fontSize?.size,
          width: fontSize?.size,
          child: child,
        );
      },
      'p': (_, child, attr, elem) {
        if (elem.nodes.length > 0) {
          var firstElem = elem.nodes.first;
          if (firstElem is dom.Element) {
            if (firstElem.localName == 'br') {
              debugPrint('span => br');
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
        // var tableStyle = attr['style'] ?? 'width: 1200px;';
        // var inlineStyle = HtmlUtil.parseInlineStyle(tableStyle);
        // var width = inlineStyle['width'].first as css.LengthTerm;
        // _tableWidth = HtmlUtil.parseDouble(width.value);
        _tableWidth = HtmlUtil.getInlineStyleValue(attr['style'], 'width');
        return NotificationAbsorbWidget(
          child: Scrollbar(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: _tableWidth,
                height: _tableHeight,
                margin: EdgeInsets.symmetric(vertical: 8),
                // decoration: BoxDecoration(
                //   border: Border.all(color: Colors.red),
                // ),
                child: Stack(
                  children: _stackChildren,
                ),
              ),
            ),
          ),
        );
      },
      'colgroup': (_, child, attr, elem) {
        debugPrint('colgroup');
        elem.nodes.forEach((node) {
          var width = HtmlUtil.parseDouble(node.attributes['width']) ?? 200;
          _tableWidth += width;
          _tableColWidth.add(width);
          debugPrint('col => width: $width');
        });
        elem.parent.nodes[1].nodes.forEach((node) {
          var height = HtmlUtil.getInlineStyleValue(
              node.attributes['style'], 'height', 50);
          _tableHeight += height;
          _tableRowHeight.add(height);
          debugPrint('tr => height: $height');
        });
        _tableFilled = List.generate(_tableRowHeight.length,
            (_) => List.generate(_tableColWidth.length, (_) => false));
        return _fallbackWidget;
      },
      'col': (_, child, attr, elem) {
        return _fallbackWidget;
      },
      'tbody': (_, child, attr, elem) {
        return _fallbackWidget;
      },
      'tr': (_, child, attr, elem) {
        // _colIndex = 0;
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
              ),
            ),
            child: child,
          ),
        );
        _stackChildren.add(stackChild);
        return _fallbackWidget;
      },
      'card': (_, child, attr, elem) {
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
          case 'thirdparty':
            return EmbedWebviewPage(
              url: json['url'],
            );
          case 'mention':
            return GestureDetector(
              onTap: () {
                //TODO add open user page by login
                // MyRoute.user(user: null);
              },
              child: Text(
                '@${json['name']}(${json['login']})',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            );
          case 'bookmarklink':
            var detail = json['detail'];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: InkWell(
                onTap: () {
                  MyRoute.webview(json['src']);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  width: Get.width,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('${detail['title']}'),
                        subtitle: Column(
                          children: [
                            Text('${detail['desc']}'),
                            Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: detail['icon'] ?? '',
                                  width: 16,
                                  height: 16,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                      horizontal: 8,
                                    ),
                                    child: Text(
                                      '${json['src']}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          case 'localdoc':
            var src = json['src'] as String;
            src = src.replaceFirst('attachments', 'office');
            src += "?view=doc_embed";
            var header = SizedBox(
              height: 32,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppIcon.iconType(json['ext'], size: 20),
                  Text(
                    '${json['name']}'.clip(18, ellipsis: true),
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    child: Icon(Icons.visibility),
                    onTap: () => MyRoute.webview(src),
                  ),
                  SizedBox(width: 12),
                ],
              ),
            );
            if (json['collapsed'] ?? false) {
              return Container(
                width: Get.width,
                margin: EdgeInsets.all(8),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: header,
              );
            }
            return EmbedWebviewPage(
              url: src,
              header: header,
            );
          case 'diagram':
            return Container(
              padding: EdgeInsets.all(8),
              width: Get.width,
              height: Get.width,
              child: PhotoView(
                imageProvider: SvgNetworkProvider(
                  json['url'],
                  size: Size(Get.width, Get.width),
                  // color: Colors.black,
                ),
                backgroundDecoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
              ),
            );
          case 'flowchart2':
            return Container(
              padding: EdgeInsets.all(8),
              width: Get.width,
              height: Get.width,
              child: PhotoView(
                imageProvider: CachedNetworkImageProvider(json['src']),
                backgroundDecoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
              ),
            );
          case 'math':
            final future = Dio().get(json['src']);
            return FutureBuilder(
              future: future,
              builder: (_, shot) {
                if (shot.hasError) {
                  return Text('Latex: ${shot.error}');
                }
                if (shot.hasData) {
                  var str = shot.data.data as String;
                  var svg = str.replaceAll('currentColor', 'black');
                  return Container(
                    padding: EdgeInsets.all(8),
                    width: Get.width,
                    height: Get.width,
                    child: PhotoView(
                      imageProvider: SvgStringProvider(
                        svg,
                        size: Size(Get.width, Get.width),
                      ),
                      backgroundDecoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                }
                return ViewLoadingWidget();
              },
            );
          case 'lockedtext':
            return Card(
              margin: EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                width: Get.width,
                padding: EdgeInsets.all(12),
                child: Builder(
                  builder: (_) {
                    if (json['locked'] == false) {
                      return Container(
                        child: Text(
                          '${json['originData']}',
                        ),
                      );
                    }
                    return Container(
                      child: Text('请输入密码解密！'),
                    );
                  },
                ),
              ),
            );
          case 'calendar':
            return Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(4),
              color: Colors.grey.withOpacity(0.1),
              child: CalendarDatePicker(
                firstDate: DateTime(1990),
                lastDate: DateTime(2100),
                currentDate: DateTime.now(),
                initialDate: DateTime.now(),
                onDateChanged: (value) {
                  debugPrint('new datetime: $value');
                },
              ),
            );
          case 'codeblock':
            return Container(
              width: Get.width * 0.9,
              padding: EdgeInsets.symmetric(horizontal: 8),
              margin: EdgeInsets.all(8),
              child: HighlightView(
                json['code'],
                language: json['mode'] ?? '',
                padding: EdgeInsets.all(8),
                theme: themeMap['github'],
              ),
            );
          case 'file':
            return Card(
              child: Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppIcon.iconType('file'),
                    ),
                    Text(
                      '${json['name']}',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                    Text('${json['size']} bytes'),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(Icons.download_outlined),
                      ),
                      onTap: () {
                        launch(json['src']);
                      },
                    ),
                  ],
                ),
              ),
            );
          case 'yuqueinline': //语雀链接
            var link = CardLinkDetailSeri.fromJson(json['detail']);
            return InkWell(
              onTap: () {},
              child: Container(
                child: Row(
                  children: [
                    AppIcon.iconType(link.type),
                    Text(
                      link.title ?? '',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            );
          case 'table':
            // var htmlTable = json['html'];
            // dom.Document doc = htmlparser.parse(htmlTable);
            // //TODO 完善Table的处理, 这里临时进行套娃处理
            // var tableStyle = doc.attributes['style'] ?? 'width: 1200px;';
            // var inlineStyle = HtmlUtil.parseInlineStyle(tableStyle);
            // var width = inlineStyle['width'].first as css.LengthTerm;
            return Container(
              // width: HtmlUtil.parseDouble(width.value),
              //TODO find a method to remove the fix width
              width: Get.width,
              padding: EdgeInsets.symmetric(vertical: 8),
              child: LakeRenderWidget(
                data: json['html'],
                shrinkWrap: true,
              ),
            );
          case 'video':
            return VideoPlayWidget(
              item: CardVideoSeri.fromJson(json),
            );
          case 'label':
            return Container(
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.5),
              ),
              child: Text(
                '${json['label']}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.green,
                ),
              ),
            );
          case 'yuque':
            var card = LakeCardSeri.fromJson(json);
            switch (card.mode) {
              case 'embed':
                return EmbedWebviewPage(
                  onUrlChanged: (url) {
                    MyRoute.webview(url);
                    // MyRoute.docDetail(bookId: null, slug: null);
                  },
                  url: card.url,
                );
            }
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              elevation: 2,
              child: child,
            );
          case 'image':
            var imageUrl = json['src'];
            if (json['status'] != 'done') {
              return _fallbackWidget;
            }
            var isSvg = (imageUrl as String).endsWith('.svg');
            if (!isSvg) imgUrl.add(imageUrl);
            var width = HtmlUtil.parseDouble(json['width']);
            var height = HtmlUtil.parseDouble(json['height']);
            var ratio = width / height;
            width = width.clamp(0, Get.width);
            height = width / ratio;
            return Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
              child: InkWell(
                onTap: () {
                  if (!isSvg) {
                    Get.to(
                      () => ImageViewerPage(
                        imageUrls: imgUrl,
                        initUrl: imageUrl,
                      ),
                    );
                  }
                },
                child: isSvg
                    ? SvgPicture.network(
                        imageUrl,
                        fit: BoxFit.contain,
                        width: width,
                        height: height,
                      )
                    : CachedNetworkImage(
                        fit: BoxFit.contain,
                        imageUrl: imageUrl,
                        width: width,
                        height: height,
                      ),
              ),
            );
          case 'checkbox':
            debugPrint('checkbox');
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: SizedBox.shrink(
                child: Checkbox(
                  value: json,
                  onChanged: (v) {
                    debugPrint('checkbox: $v');
                  },
                ),
              ),
            );
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
    };

    return Scrollbar(
      child: SingleChildScrollView(
        child: Html(
          shrinkWrap: widget.shrinkWrap,
          data: widget.data,
          style: _htmlStyle,
          customRender: _customRender,
        ),
      ),
    );
  }
}
