import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

// ignore: implementation_imports
import 'package:flutter_html/src/css_parser.dart' as cssutil;
import 'package:csslib/parser.dart' as cssparser;
import 'package:csslib/visitor.dart' as css;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:html/dom.dart' as dom;
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
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
import 'package:yuyan_app/views/widget/video_widget.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' as inapp;
import 'package:webview_flutter/webview_flutter.dart' as view;

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
}

class BodyRenderWidget extends StatelessWidget {
  final String data;

  BodyRenderWidget({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(
      data: data,
      style: {
        'li': Style(
          display: Display.LIST_ITEM,
        ),
        'p': Style(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
        ),
        'span': Style(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
        ),
        'img': Style(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          display: Display.INLINE,
        ),
      },
      customRender: {
        'li': (_, child, attr, elem) {
          debugPrint('parent element: ${elem.parent}');
          if (elem.parent.localName == 'ul') {
            return Container(
              padding: const EdgeInsets.only(left: 14),
              child: child,
            );
          }
          return null;
        },
        'br': (_, child, attr, elem) {
          return Container(
            height: 10,
            width: double.infinity,
            color: Colors.green,
          );
        },
        'img': (_, child, attr, elem) {
          // var type = attr['type']; //style type
          // var name = attr['name']; //type name
          // var value = attr['value']; //json value
          debugPrint('elem: $elem');
          debugPrint('attr: $attr');

          var heightPx = attr['data-height'];
          var height = HtmlUtil.parseDouble(heightPx.replaceAll('px', ''));

          var src = attr['src'];
          var inlineStyle = attr['style'];
          var style = HtmlUtil.parseInlineStyle(inlineStyle);
          var widthExp = style['width'].first as css.LengthTerm;
          var width = HtmlUtil.parseDouble(widthExp.value);
          var ratio = width / height;
          height = height.clamp(0.0, Get.width / ratio);
          width = width.clamp(0.0, height * ratio);
          debugPrint('size: ($width, $height)');
          return Container(
            // padding: const EdgeInsets.all(8),
            // color: Colors.red,
            child: CachedNetworkImage(
              fit: BoxFit.fitWidth,
              imageUrl: src,
              width: width,
              height: height,
            ),
          );
        }
      },
    );
  }
}

class LakeRenderWidget extends StatelessWidget {
  final String data;
  final bool shrinkWrap;

  LakeRenderWidget({
    Key key,
    this.data = '<h1>Empty Page</h1>',
    this.shrinkWrap = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imgUrl = <String>[];

    return Scrollbar(
      child: SingleChildScrollView(
        child: Html(
          shrinkWrap: shrinkWrap,
          data: data,
          style: {
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
            ),
            'h2': Style(
              padding: EdgeInsets.only(left: 12, bottom: 6),
            ),
            'h3': Style(
              padding: EdgeInsets.only(left: 12),
            ),
            'h4': Style(
              padding: EdgeInsets.only(left: 12),
            ),
            'h5': Style(
              padding: EdgeInsets.only(left: 14),
            ),
            'h6': Style(
              padding: EdgeInsets.only(left: 16),
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
          },
          customRender: {
            'a': (_, child, attr, elem) {
              debugPrint('$attr');
              return GestureDetector(
                onTap: () {
                  MyRoute.webview(attr['href']);
                },
                child: child,
              );
            },
            'li': (_, child, attr, elem) {
              debugPrint('parent element: ${elem.parent}');
              return null;
              return Container(
                decoration: BoxDecoration(
                  // shape: BoxShape.circle,
                  // color: Colors.black,
                  border: Border(
                    left: BorderSide(
                      color: Colors.black,
                      width: 5,
                    ),
                  ),
                ),
                child: child,
              );
            },
            'span': (_, child, attr, elem) {
              debugPrint('render span !!!');
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
              return null;
            },
            'p': (_, child, attr, elem) {
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
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 4),
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
                case 'vote':
                  return null;
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
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
                  //TODO 完善Table的处理, 这里临时进行套娃处理
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      width: 1080,
                      //TODO find a method to remove the fix width
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: LakeRenderWidget(
                        data: json['html'],
                        shrinkWrap: true,
                      ),
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
                  imgUrl.add(imageUrl);
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    child: InkWell(
                      onTap: () {
                        Get.to(
                          () => ImageViewerPage(
                            imageUrls: imgUrl,
                            initUrl: imageUrl,
                          ),
                        );
                      },
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
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
              return null;
            }
          },
        ),
      ),
    );
  }
}
