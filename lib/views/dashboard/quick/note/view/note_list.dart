import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:quill_markdown/quill_markdown.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/edit_markdown/convert/to_markdown.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/net/requests_api/notes/data/note_data.dart';
import 'package:yuyan_app/models/widgets_big/html/view/img.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/nothing.dart';
import 'package:yuyan_app/state_manage/dataManage/note_manage.dart';

const NotusMarkdownCodec notusMarkdown = NotusMarkdownCodec();

class NoteList extends StatelessWidget {
  const NoteList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<NoteManage>(builder: (context, child, model) {
      List dataList = model.noteData.data;
      return Container(
        child: dataList == null
            ? loading()
            : dataList.isEmpty
                ? NothingPage(
                    top: 50,
                    text: "还没写过小记，点击右下角创建一个吧！",
                  )
                : animationList(
                    context: context,
                    dataList: dataList,
                    childBuilder: oneTopic,
                  ),
      );
    });
  }
}

Widget oneTopic(BuildContext context, Data data) {
  return GestureDetector(
    onTap: () {},
    child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 2, left: 10, right: 10),
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.background,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(25, 0, 0, 0),
              offset: Offset(1, 2),
              blurRadius: 4,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(9.5)),
        ),
        child: mdView(context, data.description)),
  );
}

lake2md(String htmlLake) {
  String markdown = html2md.convert(htmlLake);
  if ((htmlLake.contains('name="image"'))) {
    String startStr = 'data:%7B%22src%22%3A%22';
    String endStr = '%22%2C%22originWidth';
    int imgStart = htmlLake.toString().indexOf(startStr);
    int imgEnd = htmlLake.toString().indexOf(endStr);
    String imgUrl = Uri.decodeComponent(
        htmlLake.substring(imgStart + startStr.length, imgEnd));
    markdown = markdown + '![img]($imgUrl)';
    return markdown;
  }
  // Delta delta = notusMarkdown.decode(markdown);

  // String deltaStr = markdownToQuill(markdown).replaceAll('"link"', '"a"');
  // deltaStr = deltaStr.replaceAll('{"heading":4}', '{"heading":3}');
  // deltaStr = deltaStr.replaceAll('{"heading":5}', '{"heading":3}');
  // deltaStr = deltaStr.replaceAll('{"list":"bullet"}', '{"block":"ul"}');

  return markdown;
}

mdView(BuildContext context, String markdown) {
  markdown = lake2md(markdown);
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
