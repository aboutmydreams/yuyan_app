import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/open_page.dart';
import 'package:yuyan_app/models/tools/time_cut.dart';
import 'package:yuyan_app/models/widgets_small/user_event.dart';
import 'package:yuyan_app/state_manage/dataManage/data/attent_data.dart';

Widget toDoc(BuildContext context, Data data) {
  return GestureDetector(
    onTap: () {
      // openUrl(context, data.event[0].url);
      OpenPage.docWeb(
        context,
        login: data.event[0].url.split("/")[3],
        bookSlug: data.event[0].url.split("/")[4],
        url: data.event[0].url,
        bookId: data.event[0].bookId,
        docId: data.event[0].id,
      );
    },
    child: Container(
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
            margin: EdgeInsets.only(left: 18, right: 19),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 44,
                  margin: EdgeInsets.only(right: 3),
                  child: userEvent(context,
                      login: data.login,
                      userImg: data.avatarUrl,
                      name: data.who,
                      userId: data.userId,
                      event: "${data.did}",
                      time: timeCut(data.when)),
                ),
                Container(
                  margin: EdgeInsets.only(top: 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "${data.event[0].title}",
                          textAlign: TextAlign.start,
                          style: AppStyles.textStyleB,
                        ),
                      ),
                      data.event[0].description == ""
                          ? SizedBox(height: 7)
                          : Container(
                              margin: EdgeInsets.only(top: 7),
                              child: Text(
                                "${data.event[0].description}",
                                textAlign: TextAlign.start,
                                style: AppStyles.textStyleC,
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
    ),
  );
}
