import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/net/requests_api/doc/data/all_doc_book_data.dart';
import 'package:yuyan_app/models/net/requests_api/doc/doc.dart';
import 'package:yuyan_app/models/widgets_big/change_org/org_leading.dart';
import 'package:yuyan_app/models/widgets_small/show_dialog/show_dialog.dart';
import 'package:yuyan_app/models/widgets_small/toast.dart';
import 'package:yuyan_app/state_manage/dataManage/mydata_manage.dart';
import 'package:yuyan_app/state_manage/dataManage/quick_manage.dart';
import 'package:yuyan_app/state_manage/toppest.dart';
import 'package:yuyan_app/views/dashboard/create_doc/select_book.dart';
import 'package:yuyan_app/views/dashboard/quick/quick_view.dart';
import 'package:yuyan_app/views/dashboard/recent/recent_page.dart';
import 'package:yuyan_app/views/explore_page/search/search_bar.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
        leading: ScopedModel<MyInfoManage>(
          model: topModel.myInfoManage,
          child: OrgLeading(),
        ),
        actions: <Widget>[
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
          myToast(context, "text123");
        },
        child: FloatingActionButton(
          onPressed: () {
            showWindow(context,
                title: "选择一个知识库",
                children: allDocBookJson == null
                    ? null
                    : allDocBookJson.data.isEmpty
                        ? [Text("暂无知识库", style: AppStyles.textStyleBB)]
                        : allDocBookJson.data
                            .map((onebook) => SelectView(
                                  book: onebook,
                                ))
                            .toList());
          },
          child: Icon(Icons.edit),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          ScopedModel<QuickManage>(
            model: topModel.quickManage,
            child: QuickView(),
          ),
          RecentPage(),
        ]),
      ),
    );
  }
}
