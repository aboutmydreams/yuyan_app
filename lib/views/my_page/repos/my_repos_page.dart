import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/net/requests_api/user/data/my_follow_book_data.dart';
import 'package:yuyan_app/models/net/requests_api/user/data/user_repos_data.dart';
import 'package:yuyan_app/models/net/requests_api/user/user.dart';
import 'package:yuyan_app/models/tools/clear_text.dart';
import 'package:yuyan_app/models/tools/get_pref.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';

class MyReposPage extends StatefulWidget {
  MyReposPage({Key key}) : super(key: key);

  @override
  _MyReposPageState createState() => _MyReposPageState();
}

class _MyReposPageState extends State<MyReposPage> {
  int offset = 0;
  List<UserBookData> dataList = [];

  @override
  void initState() {
    super.initState();
    getFollowerData();
  }

  getFollowerData() async {
    var login = await getLogin();
    UserBookJson res = await DioUser.getReposData(login);
    setState(() {
      dataList = res.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的知识库"),
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

Widget oneFollow(BuildContext context, UserBookData data) {
  return GestureDetector(
    onTap: () {
      openUrl(context, "https://www.yuque.com/${data.namespace}");
    },
    child: Container(
      height: 70,
      margin: EdgeInsets.only(left: 10, top: 2, bottom: 8, right: 10),
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
          // userAvatar(data.targetGroup.avatarUrl, height: 50),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: iconType[data.type],
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: (data.description != null) && (data.description != "")
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
                        width: 200,
                        child: Text(
                          "${data.description}",
                          style: AppStyles.textStyleC,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
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
          // FollowButtom(data: data),
        ],
      ),
    ),
  );
}
