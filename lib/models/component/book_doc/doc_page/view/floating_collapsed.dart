import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yuyan_app/config/app_ui.dart';

class FloatingCollaps extends StatelessWidget {
  const FloatingCollaps(
      {Key key,
      this.onTap,
      this.markFunc,
      this.likeFunc,
      this.commentCount,
      this.ifMark: false,
      this.ifLike: false})
      : super(key: key);

  final Function markFunc;
  final Function likeFunc;
  final Function onTap;
  final bool ifMark;
  final bool ifLike;
  final int commentCount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: commentCount != null ? onTap : () {},
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
          color: AppColors.background,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(25, 0, 0, 0),
              offset: Offset(1, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.edit,
              size: 15,
              color: AppColors.primaryText,
            ),
            Container(
              child: Text(
                commentCount != null
                    ? "  $commentCount 人评论 说点什么呢⋯⋯"
                    : "  知识库不支持评论",
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: "sans_bold",
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ),
            Spacer(),

            // 点赞
            GestureDetector(
              child: ifLike
                  ? Container(
                      height: 48,
                      width: 47,
                      child: FlareActor(
                        "assets/flares/Like.flr",
                        animation: "Like heart",
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.all(13),
                      child: Icon(
                        Icons.favorite_border,
                        size: 22,
                        color: Colors.red,
                      ),
                    ),
              onTap: likeFunc,
            ),

            // 收藏
            GestureDetector(
              child: ifMark
                  ? Container(
                      height: 62,
                      width: 47,
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.all(0),
                      child: FlareActor(
                        "assets/flares/mark.flr",
                        animation: "Favourite_star",
                        fit: BoxFit.fitHeight,
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.all(13),
                      child: FaIcon(
                        FontAwesomeIcons.star,
                        size: 18,
                        color: Colors.red,
                      ),
                    ),
              onTap: markFunc,
            ),
          ],
        ),
      ),
    );
  }
}
