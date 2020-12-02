import 'package:badges/badges.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/state_manage/dataManage/attent_manage.dart';
import 'package:yuyan_app/state_manage/dataManage/news_manage.dart';
import 'package:yuyan_app/state_manage/layout_manage/hide_bottom.dart';
import 'package:yuyan_app/state_manage/toppest.dart';
import 'package:yuyan_app/views/explore_page/explore_page.dart';
import 'package:yuyan_app/views/my_page/my_page.dart';
import 'package:yuyan_app/views/news_page/news_page.dart';
import 'dashboard/dashboard.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.pageKey: 0}) : super(key: key);
  final int pageKey;

  @override
  _HomePageState createState() => _HomePageState(pageKey: pageKey);
}

class _HomePageState extends State<HomePage> {
  _HomePageState({Key key, this.pageKey: 0});
  int pageKey;
  bool hideBottom = false;
  List<Widget> pageList = List();
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    pageList
      ..add(ScopedModel<AttentManage>(
        model: topModel.attentManage,
        child: ExplorePage(),
      ))
      ..add(Dashboard())
      ..add(ScopedModel<NewsManage>(
        model: topModel.newsManage,
        child: NewsPage(),
      ))
      ..add(MyPage());

    super.initState();
  }

  Color iconColor(int index) {
    Color theColor =
        pageKey == index ? topModel.primarySwatchColor : Colors.black87;
    return theColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: QuickSetPage(),
      bottomNavigationBar: ScopedModel<BottomManage>(
          model: topModel.bottomManage,
          child: ScopedModelDescendant<BottomManage>(
              builder: (context, child, model) {
            return Opacity(
              opacity: model.y < 30 ? model.y < 3 ? 0 : model.y / 30 : 1,
              child: CurvedNavigationBar(
                key: _bottomNavigationKey,
                color: Color.fromRGBO(0, 0, 0, 0.06),
                backgroundColor: Colors.white,
                animationCurve: Curves.easeInQuad,
                height: model.y,
                items: <Widget>[
                  Icon(
                    Icons.insert_emoticon,
                    size: 34,
                    color: iconColor(0),
                  ),
                  Icon(
                    Icons.wrap_text,
                    size: 34,
                    color: iconColor(1),
                  ),
                  Badge(
                    padding: EdgeInsets.all(0),
                    badgeColor: Colors.transparent,
                    elevation: 0,
                    badgeContent: Icon(
                      Icons.notifications_none,
                      size: 34,
                      color: iconColor(2),
                    ),
                  ),
                  Icon(
                    Icons.perm_identity,
                    size: 34,
                    color: iconColor(3),
                  ),
                ],
                animationDuration: Duration(milliseconds: 300),
                onTap: (index) {
                  setState(() {
                    pageKey = index;
                  });
                },
              ),
            );
          })),
      body: pageList[pageKey],
    );
  }
}
