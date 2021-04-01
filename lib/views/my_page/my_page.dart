import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/controller/global/my_controller.dart';
import 'package:yuyan_app/controller/version_controller.dart';
import 'package:yuyan_app/model/document/group.dart';
import 'package:yuyan_app/views/group_page/group_page.dart';
import 'package:yuyan_app/views/my_page/widget/user_info_card_widget.dart';
import 'package:yuyan_app/views/widget/list_helper_widget.dart';
import 'package:yuyan_app/views/widget/setting_item_widget.dart';

class MyPage extends StatefulWidget {
  MyPage({Key key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  ScrollController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = ScrollController();
    // _controller.addListener(() {
    //   print(_controller.position.pixels);
    //   if (_controller.position.pixels == _controller.position.maxScrollExtent) {
    //     // getMoreData();
    //   }
    // });
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    _controller.dispose();
    super.dispose();
  }

  _buildBackground(ThemeData theme) {
    return Positioned(
      top: 0,
      child: ClipPath(
        clipper: ArcClipper(),
        child: Container(
          height: Get.height * 0.33,
          width: Get.width,
          decoration: BoxDecoration(
            color: theme.primaryColor,
            gradient: LinearGradient(
              colors: [
                theme.primaryColor,
                theme.primaryColor.withAlpha(60),
              ],
              begin: FractionalOffset(0, 0),
              end: FractionalOffset(0, 1),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(55, 0, 0, 0),
                offset: Offset(1, 2),
                blurRadius: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // analytics.logEvent(name: 'my_page', parameters: {'name': '/MyPage'});
    // List<Widget> widgetList = [];
    // getVersion();

    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          // 背景图形
          _buildBackground(theme),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 70,
                    left: 24,
                    right: 24,
                    bottom: 20,
                  ),
                  child: GetBuilder<MyUserController>(
                    builder: (c) => c.builder(
                      (state) => MyInfoCardWidget(info: state.data),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      SettingListWidget(),
                      SizedBox(height: 300),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SettingListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimationColumnWidget(
      children: [
        SettingItemWidget(
          title: "我的收藏",
          imgAsset: "collections",
          namedRoute: RouteName.myMark,
        ),
        SettingItemWidget(
          title: "关注知识库",
          imgAsset: "follow_book",
          namedRoute: RouteName.myFollowBook,
        ),
        SettingItemWidget(
          title: "我的讨论",
          imgAsset: "topics",
          namedRoute: RouteName.myTopic,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 10,
          color: Color.fromRGBO(0, 0, 0, 0.03),
        ),
        SettingItemWidget(
          title: "意见与反馈",
          imgAsset: "suggest",
          namedRoute: RouteName.mySuggest,
        ),
        SettingItemWidget(
          title: "关于语燕",
          imgAsset: "about",
          namedRoute: RouteName.myAbout,
        ),
        GetBuilder<VersionController>(
          builder: (c) => SettingItemWidget(
            title: "设置",
            imgAsset: "setting",
            namedRoute: RouteName.mySetting,
            badge: c?.isLatest,
          ),
        ),
        GestureDetector(
          onTap: () {
            final avatarUrl =
                "https://cdn.nlark.com/yuque/0/2020/png/164272/1581178391840-avatar/dfd33ab4-7115-4fce-b504-faeb9d3ca24d.png";
            Get.to(GroupPage(
              group: GroupSeri(
                id: 2616655,
                name: "Redhome",
                description: "没有内容的哦",
                avatarUrl: avatarUrl,
              ),
            ));
          },
          child: AbsorbPointer(
            child: SettingItemWidget(
              title: "测试",
              imgAsset: "about",
            ),
          ),
        ),
      ],
    );
  }
}
