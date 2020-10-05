import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/open_page.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/net/requests/dio_requests.dart';
import 'package:yuyan_app/models/net/requests_api/user/data/my_mark_data.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/nothing.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/group/group_data.dart';

class MarkPage extends StatefulWidget {
  MarkPage({Key key}) : super(key: key);

  @override
  _MarkPageState createState() => _MarkPageState();
}

class _MarkPageState extends State<MarkPage> {
  int offset = 0;
  List<MarkData> dataList;
  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    getFollowerData();
  }

  getFollowerData() async {
    var res = await DioReq.get("/mine/marks?limit=200&offset=$offset&type=all");
    MarkJson theData = MarkJson.fromJson(res);
    setState(() {
      dataList = theData.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的收藏"),
      ),
      body: dataList == null
          ? loading()
          : dataList.isEmpty
              ? NothingPage(
                  top: 50,
                  text: "暂无收藏~",
                )
              : animationList(
                  context: context,
                  dataList: dataList,
                  childBuilder: oneMark,
                ),
    );
  }
}

Widget oneMark(BuildContext context, MarkData data) {
  // 如果收藏的是团队，那么 avatarUrl 的位置变了一下...
  String userName =
      data.targetType == "User" ? data.title : data.target.user.name;
  String avatarUrl = data.targetType == "User"
      ? data.target.avatarUrl
      : data.target.user.avatarUrl;

  return GestureDetector(
    onTap: () {
      if (data.targetType == "User") {
        OpenPage.group(
          context,
          groupdata: GroupData(
            id: data.target.id,
            login: data.target.login,
            name: data.target.name ?? "",
            description: data.target.description,
            avatarUrl: data.target.avatarUrl,
          ),
        );
      } else if (data.targetType == "Book") {
        OpenPage.docBook(
          context,
          bookId: data.target.id,
          bookSlug: data.target.slug,
        );
      } else if (data.targetType == "Doc") {
        OpenPage.docWeb(
          context,
          login: data.targetGroup.login,
          bookSlug: data.targetBook.slug,
          bookId: data.targetBookId,
          docId: data.targetId,
        );
      } else {
        openUrl(context, "https://www.yuque.com${data.sUrl}");
      }
    },
    child: Container(
      margin: EdgeInsets.only(top: 2, bottom: 9, left: 10, right: 10),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              userAvatar(avatarUrl, height: 25),
              SizedBox(width: 6),
              Text(
                userName,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.textStyleC,
              )
            ],
          ),
          SizedBox(height: 6),
          Text(
            data.title,
            style: AppStyles.textStyleB,
          ),
          SizedBox(height: 2),
          Text(
            data.target.description,
            style: AppStyles.textStyleC,
          )
        ],
      ),
    ),
  );
}
