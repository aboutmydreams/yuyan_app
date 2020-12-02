import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/open_page.dart';
import 'package:yuyan_app/models/tools/clear_text.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';
import 'package:yuyan_app/state_manage/dataManage/data/selection_data.dart';

Widget secItemUI(BuildContext context, Data data) {
  String imageUrl = data.cover.contains("x-oss-process")
      ? data.cover
      : data.cover +
          "?x-oss-process=image%2Fresize%2Cm_fill%2Cw_200%2Ch_120%2Fformat%2Cpng";
  return GestureDetector(
    onTap: () {
      OpenPage.docWeb(
        context,
        login: data.book.user.login,
        bookSlug: data.book.slug,
        bookId: data.bookId,
        docId: data.id,
        onlyUser: true,
      );
    },
    child: Container(
      height: 102,
      margin: EdgeInsets.only(left: 16, top: 21, right: 15),
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
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) => Container(
                    width: 147,
                    height: 91,
                    color: AppColors.background,
                  ), // Colors.white10,
                  errorWidget: (context, url, error) => Icon(Icons.error),
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
                    data.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyles.textStyleBB,
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
                            child: userAvatar(data.user.avatarUrl, height: 22),
                          ),
                        ),
                        SizedBox(width: 7),
                        Container(
                          child: Text(
                            clearText(data.user.name, 12),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.textStyleCC,
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 55,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 21,
                                height: 21,
                                margin: EdgeInsets.only(right: 5),
                                child: SvgPicture.asset(
                                  "assets/images/paddy.svg",
                                  semanticsLabel: 'paddy',
                                ),
                              ),
                              Expanded(child: SizedBox()),
                              Container(
                                margin: EdgeInsets.only(left: 0),
                                child: Text(
                                  "${data.likesCount * 7}",
                                  textAlign: TextAlign.center,
                                  style: AppStyles.textStyleCC,
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
    ),
  );
}
