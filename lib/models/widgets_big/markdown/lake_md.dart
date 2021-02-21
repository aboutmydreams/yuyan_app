import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/widgets_big/html/view/img.dart';
import 'package:html2md/html2md.dart' as html2md;

lake2md(String htmlLake) {
  String markdown = html2md.convert(htmlLake);
  if ((htmlLake.contains('name="image"'))) {
    String startStr = 'data:%7B%22src%22%3A%22';
    String endStr = '%22%2C%22originWidth';
    int imgStart = htmlLake.toString().indexOf(startStr);
    int imgEnd = htmlLake.toString().indexOf(endStr);
    if (imgEnd == -1) {
      /// 通过 markdown convert to lake 上传的 endStr 有所变化
      // print('htmlLake==========$imgStart');
      // print('startStr==========$imgEnd');
      // print('endStr==========$endStr');
      endStr = '%22%2C%22';
      imgEnd = htmlLake.toString().indexOf(endStr);
    }

    String imgUrl = Uri.decodeComponent(
        htmlLake.substring(imgStart + startStr.length, imgEnd));
    markdown = markdown + '\n\n' + '![img]($imgUrl)';
    return markdown;
  }
  // Delta delta = notusMarkdown.decode(markdown);

  // String deltaStr = markdownToQuill(markdown).replaceAll('"link"', '"a"');
  // deltaStr = deltaStr.replaceAll('{"heading":4}', '{"heading":3}');
  // deltaStr = deltaStr.replaceAll('{"heading":5}', '{"heading":3}');
  // deltaStr = deltaStr.replaceAll('{"list":"bullet"}', '{"block":"ul"}');

  return markdown;
}

myLakeView(BuildContext context, String lake) {
  String markdown = lake2md(lake);
  return MarkdownBody(
    data: markdown,
    selectable: true,
    onTapLink: (String name, String url, String c) {
      openUrl(context, url, title: name);
    },
    imageBuilder: (uri, title, alt) {
      return imgHtml(context, uri.toString());
    },
    // extensionSet: MarkdownExtensionSet.githubWeb.value,
  );
}
