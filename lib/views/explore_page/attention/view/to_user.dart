import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/tools/time_cut.dart';
import 'package:yuyan_app/state_manage/dataManage/data/attent_data.dart';

Widget toUser(BuildContext context, Data data) {
  print(data.avatarUrl);
  return Container(
    height: 202,
    margin: EdgeInsets.only(top: 7),
    decoration: BoxDecoration(
      color: AppColors.primaryText,
      boxShadow: [
        BoxShadow(
          color: Color.fromARGB(128, 116, 116, 116),
          offset: Offset(0, 0),
          blurRadius: 1,
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 170,
          margin: EdgeInsets.only(left: 18, right: 19),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 39,
                margin: EdgeInsets.only(right: 3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 38,
                        height: 38,
                        child: FadeInImage.assetNetwork(
                          image: data.avatarUrl,
                          placeholder: 'assets/images/logo.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: 127,
                      margin: EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: EdgeInsets.only(left: 1),
                              child: Text(
                                "闲鱼技术",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.primaryText,
                                  fontFamily: "PingFang SC",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "${data.who + data.did}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.primaryText,
                                fontFamily: "PingFang SC",
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${timeCut(data.when)}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontFamily: "PingFang SC",
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 118,
                margin: EdgeInsets.only(top: 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "${data.event[0].title}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontFamily: "PingFang SC",
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 7),
                      child: Text(
                        "作者：闲鱼技术-然道0. 什么是Candy引擎 Candy引擎是闲鱼技术团队设计开发的一款APP嵌入式的、轻量级的、易于开发、性能稳定的互动引擎。其中游戏系列符合业界标准，绘制系统高度融合Flutter体系，游戏场景和Flutter UI可以无缝混排，动画系统对主流格式的支持友好且易扩展。本...",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromARGB(255, 89, 89, 89),
                          fontFamily: "PingFang SC",
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
