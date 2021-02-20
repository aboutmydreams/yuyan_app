import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/open_page.dart';
import 'package:yuyan_app/models/net/requests_api/user/data/user_follow_data.dart';
import 'package:yuyan_app/models/net/requests_api/user/user.dart';
import 'package:yuyan_app/models/tools/analytics.dart';
import 'package:yuyan_app/models/tools/clear_text.dart';
import 'package:yuyan_app/models/tools/get_pref.dart';
import 'package:yuyan_app/models/tools/get_tag.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/nothing.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';
import 'package:yuyan_app/views/my_page/follower/one_buttom.dart';

class FollowingPage extends StatefulWidget {
  FollowingPage({Key key}) : super(key: key);

  @override
  _FollowingPageState createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  int offset = 0;
  List<FollowsData> dataList;
  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    getFollowerData();
  }

  getFollowerData() async {
    var myId = await getPrefIntData("my_id");
    Follows res = await DioUser.getFollowingData(offset: offset, userId: myId);
    setState(() {
      dataList = res.data;
      offset += 20;
    });
  }

  @override
  Widget build(BuildContext context) {
    analytics.logEvent(name: 'following');
    return Scaffold(
      appBar: AppBar(
        title: Text("我关注的"),
      ),
      body: dataList == null
          ? loading()
          : dataList.isEmpty
              ? NothingPage(
                  top: 50,
                  text: "暂无关注~",
                )
              : animationList(
                  context: context,
                  dataList: dataList,
                  childBuilder: oneFollow,
                ),
    );
  }
}

Widget oneFollow(BuildContext context, FollowsData data) {
  data.isfollow = true;
  String tag = getTag();
  return GestureDetector(
    onTap: () {
      OpenPage.user(
        context,
        login: data.login,
        tag: tag,
        name: data.name,
        avatarUrl: data.avatarUrl,
        userId: data.id,
      );
    },
    child: Container(
      height: 70,
      margin: EdgeInsets.only(left: 5, top: 2, bottom: 8, right: 5),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(25, 0, 0, 0),
            offset: Offset(1, 2),
            blurRadius: 4,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: 20),
          userAvatar(data.avatarUrl, height: 50),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            margin: EdgeInsets.only(left: 20),
            child: data.description != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          clearText(data.name, 10),
                          style: AppStyles.textStyleB,
                        ),
                      ),
                      SizedBox(height: 2),
                      Container(
                        child: Text(
                          "${clearText(data.description, 15)}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.textStyleC,
                        ),
                      ),
                    ],
                  )
                : Container(
                    child: Text(
                      clearText(data.name, 10),
                      style: AppStyles.textStyleB,
                    ),
                  ),
          ),
          Spacer(),
          FollowButtom(data: data),
        ],
      ),
    ),
  );
}
