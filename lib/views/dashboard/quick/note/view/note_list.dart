import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/edit_markdown/convert/to_markdown.dart';
import 'package:yuyan_app/models/net/requests_api/notes/data/note_data.dart';
import 'package:yuyan_app/models/widgets_big/markdown/lake_md.dart';
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
                    childBuilder: oneNote,
                  ),
      );
    });
  }
}

Widget oneNote(BuildContext context, Data data) {
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
        child: myLakeView(context, data.description)),
  );
}
