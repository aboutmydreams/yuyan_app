import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';

Widget blockquoteHtml(BuildContext context, String outerHtml) {
  return Stack(
    children: <Widget>[
      Container(
        child: Transform(
          transform: Matrix4.translationValues(24, 0, 0),
          child: HtmlWidget(
            outerHtml,
            textStyle: AppStyles.textStyleC,
            // builderCallback: (nn, ee) {
            //   if (ee.localName == 'code') {
            //     return lazySet(null, buildOp: BuildOp(
            //       onPieces: (meta, pieces) {
            //         final text = ' ';
            //         return pieces..first?.block?.addText(text);
            //       },
            //     ));
            //   }
            //
            //   return nn;
            // },
            onTapUrl: (url) {
              openUrl(context, url);
            },
          ),
        ),
      ),
      Positioned(
        child: Container(
          color: Colors.grey[300],
          width: 3,
        ),
        left: 0,
        top: 5,
        bottom: 5,
      ),
    ],
  );
}
