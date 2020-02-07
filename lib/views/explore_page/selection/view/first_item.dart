import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yuyan_app/models/browser_web/browser_appbar.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/widgets_small/user_event.dart';
import 'package:yuyan_app/state_manage/dataManage/data/selection_data.dart';

Widget firstItemUI(BuildContext context, Data data) {
  String imageUrl = data.cover +
      "?x-oss-process=image%2Fresize%2Cm_fill%2Cw_400%2Ch_220%2Fformat%2Cpng";
  return GestureDetector(
    /// 临时解决方案，临时的时间可能会很久
    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return BrowserWithBar(
        url:
            "https://www.yuque.com/${data.book.user.login}/${data.book.slug}/${data.slug}",
        appbar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          elevation: 0,
          backgroundColor: AppColors.background,
        ),
      );
    })),
    child: Container(
      height: 216,
      margin: EdgeInsets.only(left: 18, top: 9, right: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              height: 164,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) => Container(
                  width: 147,
                  height: 91,
                  color: AppColors.background,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Spacer(),
          Container(
            height: 46,
            margin: EdgeInsets.only(right: 47),
            child: userEvent(
              context,
              userImg: data.user.avatarUrl,
              login: data.user.login,
              title: data.title,
              event: data.user.name + " 发布于 " + data.book.name,
            ),
          ),
        ],
      ),
    ),
  );
}
