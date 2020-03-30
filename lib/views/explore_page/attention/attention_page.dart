import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/state_manage/dataManage/data/attent_data.dart';
import 'package:yuyan_app/state_manage/toppest.dart';
import 'package:yuyan_app/views/explore_page/attention/view/to_artboard.dart';
import 'package:yuyan_app/views/explore_page/attention/view/to_book.dart';
import 'package:yuyan_app/views/explore_page/attention/view/to_doc.dart';
import 'package:yuyan_app/views/explore_page/attention/view/to_user.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        getMoreData();
      }
      // print(_controller.position.pixels);
      topModel.bottomManage.addPixels(_controller.position.pixels);
    });
  }

  getMoreData() async {
    await topModel.attentManage.getMoreData();
    setState(() {});
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(onRefresh: () async {
        topModel.attentManage.update();
        await Future.delayed(const Duration(milliseconds: 1500), () {});
      }, child: ScopedModelDescendant<TopStateModel>(
          builder: (context, child, model) {
        List<Data> attentDatas = model.attentManage.attentDataList;
        return ListView.builder(
          controller: _controller,
          itemCount: attentDatas.length,
          itemBuilder: (BuildContext context, int index) {
            if (attentDatas[index].subjectType == "Doc") {
              return toDoc(context, attentDatas[index]);
            } else if (attentDatas[index].subjectType == "Artboard") {
              return toArtboard(context, attentDatas[index]);
            } else if (attentDatas[index].subjectType == "User") {
              return toUser(context, attentDatas[index]);
            } else if (attentDatas[index].subjectType == "Book") {
              return toBook(context, attentDatas[index]);
            } else {
              return Text(attentDatas[index].subjectType);
            }
          },
        );
      })),
    );
  }
}
