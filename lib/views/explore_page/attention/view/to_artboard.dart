import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/tools/time_cut.dart';
import 'package:yuyan_app/models/widgets_small/user_event.dart';
import 'package:yuyan_app/state_manage/dataManage/data/attent_data.dart';

Widget toArtboard(BuildContext context, Data data) {
  return Container(
    padding: EdgeInsets.only(top: 14, bottom: 20),
    decoration: BoxDecoration(
      color: AppColors.background,
      boxShadow: [
        BoxShadow(
          color: Color.fromARGB(128, 116, 116, 116),
          offset: Offset(0, 0),
          blurRadius: 1,
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 18, right: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 动态的头像
              Container(
                height: 44,
                margin: EdgeInsets.only(right: 3),
                child: userEvent(
                  context,
                  login: data.login,
                  userImg: data.avatarUrl,
                  title: data.who,
                  event: "${data.did}",
                  time: timeCut(data.when),
                ),
              ),
              // 画板知识库
              GestureDetector(
                onTap: () {
                  openUrl(context, data.event[0].url);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 4),
                  child: Chip(
                    backgroundColor: AppColors.eventBack,
                    avatar: ClipOval(
                      child: FadeInImage.assetNetwork(
                        width: 20,
                        image: data.event[0].avatarUrl,
                        placeholder: 'assets/images/explore/book.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    label: Text(
                      "${data.event[0].title}",
                      textAlign: TextAlign.center,
                      style: AppStyles.textStyleBB,
                    ),
                  ),
                ),
              ),
              // 更新图片预览
              GestureDetector(
                onTap: () {
                  openUrl(
                      context,
                      data.event[0].url +
                          "/" +
                          data.event[0].bookId.toString());
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Hero(
                        tag: "artboard",
                        child: FadeInImage.assetNetwork(
                          width: MediaQuery.of(context).size.width - 36,
                          image: data.event[0].image,
                          placeholder: 'assets/images/explore/book.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Positioned(
                        child: Opacity(
                          opacity: 0.4,
                          child: Container(
                            padding: EdgeInsets.only(top: 4, left: 4, right: 4),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(13),
                            ),
                            height: 26,
                            child: Text(
                              "共 ${data.event.length} 张",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
