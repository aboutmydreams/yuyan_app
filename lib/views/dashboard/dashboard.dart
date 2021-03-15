import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yuyan_app/controller/quick_link_controller.dart';
import 'package:yuyan_app/controller/recent_controller.dart';
import 'package:yuyan_app/models/net/requests_api/doc/data/all_doc_book_data.dart';
import 'package:yuyan_app/models/net/requests_api/doc/doc.dart';
import 'package:yuyan_app/models/widgets_small/toast.dart';
import 'package:yuyan_app/views/dashboard/quick/note_editor/note_editor.dart';
import 'package:yuyan_app/views/dashboard/quick/quick_view.dart';
import 'package:yuyan_app/views/dashboard/recent/recent_page.dart';
import 'package:yuyan_app/views/explore_page/search/search_bar.dart';
import 'package:yuyan_app/views/widget/org_space_widget.dart';

class MyDashBoardPage extends StatefulWidget {
  MyDashBoardPage({Key key}) : super(key: key);

  @override
  _MyDashBoardPageState createState() => _MyDashBoardPageState();
}

class _MyDashBoardPageState extends State<MyDashBoardPage> {
  AllDocBookJson allDocBookJson;

  @override
  void initState() {
    super.initState();
    getEditable();
  }

  getEditable() async {
    AllDocBookJson _books = await DioDoc.getAllDocBook();
    setState(() {
      allDocBookJson = _books;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        toolbarOpacity: 1.0,
        bottomOpacity: 5.0,
        elevation: 1,
        title: Text("书桌"),
        leading: OrgSpaceLeadingWidget(),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            tooltip: '搜索与我有关',
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchBarDelegate(aboutMe: true),
              );
            },
          )
        ],
      ),
      floatingActionButton: GestureDetector(
        onLongPress: () {
          Timer(Duration(milliseconds: 400), () {
            myToast(context, "感谢你的期待 💕");
          });
        },
        child: FloatingActionButton(
          onPressed: () {
            Get.to(MarkdownEditorPage());
          },
          child: Icon(Icons.edit),
        ),
      ),
      body: GetBuilder<RecentController>(
        builder: (c) {
          return SmartRefresher(
            controller: c.refreshController,
            onRefresh: () {
              c.onRefreshCallback();
              QuickLinkController.to.onRefreshCallback();
            },
            onLoading: c.onLoadMoreCallback,
            enablePullUp: true,
            child: SingleChildScrollView(
              child: Column(children: [
                QuickView(),
                RecentPage(),
              ]),
            ),
          );
        },
      ),
    );
  }
}
