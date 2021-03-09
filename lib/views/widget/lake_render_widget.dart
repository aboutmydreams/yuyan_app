import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

// ignore: implementation_imports
import 'package:flutter_html/src/css_parser.dart' as cssutil;
import 'package:csslib/parser.dart' as cssparser;
import 'package:csslib/visitor.dart' as css;
import 'package:html/dom.dart' as dom;
import 'package:get/get.dart';
import 'package:yuyan_app/model/document/card/card_link_detail.dart';
import 'package:yuyan_app/model/document/card/card_video_seri.dart';
import 'package:yuyan_app/model/document/lake/lake_card_seri.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/views/image_page/image_view_page.dart';
import 'package:yuyan_app/views/widget/video_widget.dart';

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

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Html(
            shrinkWrap: shrinkWrap,
            data: data,
            style: {
              '*': Style(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
              ),
              'li': Style(
                listStylePosition: ListStylePosition.INSIDE,
                padding: EdgeInsets.zero,
              ),
              'h1': Style(
                padding: EdgeInsets.only(left: 4, top: 4),
              ),
              'h2': Style(
                padding: EdgeInsets.only(left: 8, top: 2),
              ),
              'h3': Style(
                padding: EdgeInsets.only(left: 10),
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
              'p': Style(
                padding: EdgeInsets.zero,
                // border: Border.all(
                //   color: Colors.red,
                //   width: 2,
                // ),
                margin: EdgeInsets.zero,
              ),
              'img': Style(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              ),
              'blockquote': Style(
                color: Colors.grey,
              ),
            },
            customRender: {
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
              'p': (_, child, attr, elem) {
                debugPrint('${elem.nodes.first.nodeType}');
                var firstElem = elem.nodes.first;
                if (firstElem is dom.Element) {
                  if (firstElem.localName == 'br') {
                    debugPrint('p => br');
                    return SizedBox(height: 8, child: child);
                  }
                }
                return Container(
                  padding: EdgeInsets.all(8),
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
                      return null;
                  }
                }
                var raw = Uri.decodeComponent(value);
                var json = jsonDecode(raw.substring(5));
                // debugPrint('elem: $elem');
                attr['value'] = '!value!'; //for less print
                debugPrint('attr: $attr');
                switch (name) {
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
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                }
                return null;
              }
            },
          ),
        ),
      ),
    );
  }
}
