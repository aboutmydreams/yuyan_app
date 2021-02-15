import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:flutter_html/flutter_html.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/widgets_big/html/view/blockquote.dart';
import 'package:yuyan_app/models/widgets_big/html/view/img.dart';
import 'package:yuyan_app/models/widgets_big/html/view/pre.dart';

Widget getHtml(BuildContext context, String bodyHtml, {EdgeInsets padding}) {
  return Html(
    data: bodyHtml,
    useRichText: false,
    padding: padding ?? EdgeInsets.all(0),
    onLinkTap: (url) {
      _onLinkTap(context, url);
    },
    customRender: (node, children) {
      try {
        if (node is dom.Element) {
          // print(node.localName);
          // if (node.outerHtml.contains("对外开放")) {
          //   print(node.localName);
          //   if (node.localName == 'blockquote') {
          //     print(node.innerHtml);
          //   }
          // }

          switch (node.localName) {
            case 'img':
              if (node.attributes['src'] == null) {
                return null;
              }
              return imgHtml(context, node.attributes['src']);

            case 'pre':
              return preHtml(context, node.outerHtml);

            case 'blockquote':
              return blockquoteHtml(context, node.outerHtml);
            case 'code':
              return Container(
                color: Colors.grey[300],
                child: Text(node.text),
              );
            case 'Card':
              return Container(
                color: Colors.grey[300],
                child: Text(node.text),
              );
            // case 'table':
            //   return SingleChildScrollView(
            //     // scrollDirection: Axis.horizontal,
            //     child: Container(
            //       width: MediaQuery.of(context).size.width*1.5,
            //         // padding: EdgeInsets.all(5),
            //         child: Html(
            //           data: node.outerHtml,
            //           onLinkTap: (url) {
            //             _onLinkTap(context, url);
            //           },
            //         )),
            //   );
            case 'ol':
            case 'ul':
              return HtmlWidget(
                node.outerHtml,
                webView: true,
                bodyPadding: EdgeInsets.all(0),
                onTapUrl: (url) {
                  _onLinkTap(context, url);
                },
                builderCallback: (nodeData, element) {
                  if (element.classes.contains('lake-list')) {
                    return null;
                  }
                  if (element.localName == 'li' &&
                      element.outerHtml.contains('checkbox') &&
                      element.getElementsByTagName('input').length > 0) {
                    return lazySet(
                      null,
                      buildOp: BuildOp(
                        onWidgets: (n, w) {
                          return [
                            Container(
                              // padding: EdgeInsets.only(bottom: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 5),
                                    constraints: BoxConstraints(
                                        maxHeight: 20, maxWidth: 20),
                                    child: AbsorbPointer(
                                      child: Checkbox(
                                        activeColor: Colors.green,
                                        checkColor: Colors.white,
                                        tristate: true,
                                        value: element.outerHtml
                                            .contains('checked'),
                                        onChanged: (checked) {
                                          print(checked);
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 3),
                                    child: Text('${element.text}'),
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width -
                                                45),
                                  ),
                                ],
                              ),
                            )
                          ];
                        },
                      ),
                    );
                  }
                  return nodeData;
                },
              );
              break;
            //文字样式
            case 'span':
              var styleStr = node.attributes['style'];
              var classStr = node.attributes['class'];
              String textColor = '#000000';
              String textBackgroundColor = '#FFFFFF';
              String fontStr = '14';

              if (styleStr != null) {
                styleStr = styleStr.replaceAll(' ', '');
                List li = styleStr.split(';');

                li.forEach((ob) {
                  String obj = ob;
                  if (obj.startsWith('color')) {
                    textColor = obj.split(':').last;
                  }
                  if (obj.startsWith('background-color')) {
                    textBackgroundColor = obj.split(':').last;
                  }
                });
                return Text(
                  node.text,
                  style: TextStyle(
                    color: parseColor(textColor),
                    decorationColor: parseColor(textBackgroundColor),
                  ),
                );
              }
              // if (classStr!=null) {
              //  fontStr =  classStr.contains('lake-fontsize-')?classStr.substring(14):'14';
              //   return Text(
              //     node.text,
              //     style: TextStyle(
              //         color: colorParseValue(textColor),
              //         backgroundColor: colorParseValue(textBackgroundColor),
              //         fontSize: double.parse(fontStr)+3
              //   ));
              // }
              break;
            case 'br':
              return Container(
                margin: EdgeInsets.all(2),
                child: Text("\n"),
              );
            case 'p':
              if (node.outerHtml.contains('name="image"')) {
                String startStr = 'data:%7B%22src%22%3A%22';
                String endStr = '%22%2C%22originWidth';
                int imgStart = node.outerHtml.toString().indexOf(startStr);
                int imgEnd = node.outerHtml.toString().indexOf(endStr);
                String imgUrl = Uri.decodeComponent(node.outerHtml
                    .substring(imgStart + startStr.length, imgEnd));
                print(imgUrl);

                return imgHtml(context, imgUrl);
              }
              if (!node.outerHtml.contains("img")) {
                // return HtmlWidget(
                //   node.outerHtml,
                //   bodyPadding: EdgeInsets.only(bottom: 3),
                // );
                return Text(node.text);
              }
              break;
            case 'h1':
              if (!node.outerHtml.contains("img")) {
                // return HtmlWidget(
                //   node.outerHtml,
                //   bodyPadding: EdgeInsets.only(bottom: 3),
                // );
                return Text(
                  node.text,
                  style: AppStyles.textStyleA,
                );
              }
              break;
            case 'h2':
              if (!node.outerHtml.contains("img")) {
                // return HtmlWidget(
                //   node.outerHtml,
                //   bodyPadding: EdgeInsets.only(bottom: 3),
                // );
                return Text(
                  node.text,
                  style: AppStyles.textStyleA,
                );
              }
              break;
          }
        }
      } catch (e) {
        print('解析HTML存在异常--$e');
      }
    },
  );
}

_onLinkTap(context, url) {
  print('$url');
  if (url != null && url.contains('http')) {
    openUrl(context, url);
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
              height: 20, alignment: Alignment(0, 0), child: Text('超链接识别有误')),
          contentTextStyle: TextStyle(color: Colors.black54, fontSize: 17),
        );
      },
    );
  }
}
