import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/open_page.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/net/requests_api/user/data/my_follow_book_data.dart';
import 'package:yuyan_app/models/net/requests_api/user/user.dart';
import 'package:yuyan_app/models/tools/clear_text.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';

class FollowBookPage extends StatefulWidget {
  FollowBookPage({Key key}) : super(key: key);

  @override
  _FollowBookPageState createState() => _FollowBookPageState();
}

class _FollowBookPageState extends State<FollowBookPage> {
  int offset = 0;
  List<FollowBookData> dataList = [];
  // 之后收藏数量增加 需要上滑加载更多
  // ScrollController _controller;

  @override
  void initState() {
    super.initState();
    getFollowerData();
  }

  getFollowerData() async {
    FollowBookJson res = await DioUser.getFollowBook(limit: 200, offset: 0);
    setState(() {
      dataList = res.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我关注的知识库"),
      ),
      body: dataList.isEmpty
          ? loading()
          : animationList(
              context: context,
              dataList: dataList,
              childBuilder: oneFollow,
            ),
    );
  }
}

Widget oneFollow(BuildContext context, FollowBookData data) {
  data.ifFollow = true;
  return GestureDetector(
    onTap: () {
      if (data.target.type == "Book") {
        OpenPage.docBook(
          context,
          bookId: data.target.id,
          bookSlug: data.target.slug,
          login: data.targetGroup.login,
        );
      } else {
        openUrl(context, "https://www.yuque.com${data.sUrl}");
      }
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
          userAvatar(data.targetGroup.avatarUrl, height: 50),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: (data.target.description != null) &&
                    (data.target.description != "")
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          clearText(data.target.name, 10),
                          style: AppStyles.textStyleB,
                        ),
                      ),
                      SizedBox(height: 2),
                      Container(
                        width: 200,
                        child: Text(
                          "${data.target.description}",
                          style: AppStyles.textStyleC,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  )
                : Container(
                    child: Text(
                      clearText(data.target.name, 10),
                      style: AppStyles.textStyleB,
                    ),
                  ),
          ),
          Spacer(),
          // FollowButtom(data: data),
        ],
      ),
    ),
  );
}
