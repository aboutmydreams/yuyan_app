import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/state_manage/dataManage/news_manage.dart';
import 'package:yuyan_app/state_manage/toppest.dart';

Widget newsCountView(BuildContext context) {
  return ScopedModelDescendant<NewsManage>(builder: (context, child, model) {
    int count = model.newsCount.count;
    return Container(
      height: 38,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 1),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(128, 101, 101, 101),
            offset: Offset(0, 0),
            blurRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 18),
            child: Text(
              count == 0 ? "暂无未读消息" : "未读消息",
              textAlign: TextAlign.left,
              style: AppStyles.textStyleBB,
            ),
          ),
          count == 0
              ? Text("")
              : Container(
                  height: 14,
                  margin: EdgeInsets.only(left: 14),
                  decoration: BoxDecoration(
                    color: AppColors.yellow,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(128, 101, 101, 101),
                        offset: Offset(0, 1),
                        blurRadius: 5,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 6, right: 7),
                    child: Text(
                      "$count",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontFamily: "Silom",
                        fontWeight: FontWeight.w700,
                        fontSize: 9,
                      ),
                    ),
                  ),
                ),
          Spacer(),
          InkWell(
            onTap: () {
              topModel.newsManage.readAll();
            },
            child: Container(
              width: 18,
              height: 18,
              margin: EdgeInsets.only(right: 16),
              child: Image.asset(
                "assets/images/news/read_all.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  });
}
