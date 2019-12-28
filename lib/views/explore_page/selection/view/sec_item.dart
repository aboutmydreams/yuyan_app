import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/tools/clear_text.dart';
import 'package:yuyan_app/views/explore_page/data/selection_data.dart';

Widget secItemUI(Data data) {
  return Container(
    height: 102,
    margin: EdgeInsets.only(left: 18, top: 21, right: 18),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              width: 147,
              height: 91,
              child: FadeInImage.assetNetwork(
                image: data.cover,
                placeholder: 'assets/images/guide1.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  clearText(data.title, 26),
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppColors.accentText,
                    fontFamily: "PingFang SC",
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Expanded(child: SizedBox()),
                Container(
                  margin: EdgeInsets.only(bottom: 11, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(11),
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(128, 116, 116, 116),
                                offset: Offset(0, 0),
                                blurRadius: 1,
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: FadeInImage.assetNetwork(
                              image: data.user.smallAvatarUrl,
                              placeholder: 'assets/images/guide1.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 7),
                      Container(
                        margin: EdgeInsets.only(right: 38),
                        child: Text(
                          clearText(data.user.name, 12),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontFamily: "PingFang SC",
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Container(
                        width: 52,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 21,
                              height: 21,
                              margin: EdgeInsets.only(right: 5),
                              child: SvgPicture.asset("assets/images/paddy.svg",
                                  semanticsLabel: 'paddy'),
                            ),
                            Expanded(child: SizedBox()),
                            Container(
                              margin: EdgeInsets.only(left: 1),
                              child: Text(
                                "${data.likesCount * 7}",
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
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}