import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/state_manage/dataManage/data/attent_data.dart';
import 'package:yuyan_app/state_manage/toppest.dart';
import 'package:yuyan_app/views/explore_page/attention/view/to_artboard.dart';
import 'package:yuyan_app/views/explore_page/attention/view/to_doc.dart';
import 'package:yuyan_app/views/explore_page/attention/view/to_user_or_book.dart';

class AttentionPage extends StatefulWidget {
  AttentionPage({Key key}) : super(key: key);

  @override
  _AttentionPageState createState() => _AttentionPageState();
}

class _AttentionPageState extends State<AttentionPage>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true; //非常重要

  ScrollController _controller;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ScopedModelDescendant<TopStateModel>(
      builder: (context, child, model) {
        List<Data> attentDatas = model.attentManage.attentData.data;
        return Scaffold(
          backgroundColor: AppColors.background,
          body: RefreshIndicator(
            onRefresh: () async {
              model.attentManage.update();
              await Future.delayed(const Duration(milliseconds: 1500), () {});
            },
            child: ListView.builder(
              controller: _controller,
              itemCount: attentDatas.length,
              itemBuilder: (BuildContext context, int index) {
                if (attentDatas[index].subjectType == "Doc") {
                  return toDoc(context, attentDatas[index]);
                } else if (attentDatas[index].subjectType == "Artboard") {
                  return toArtboard(context, attentDatas[index]);
                } else if (attentDatas[index].subjectType == "User") {
                  return toUserOrBook(context, attentDatas[index]);
                } else if (attentDatas[index].subjectType == "Book") {
                  return toUserOrBook(context, attentDatas[index]);
                } else {
                  return Text(attentDatas[index].subjectType);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
