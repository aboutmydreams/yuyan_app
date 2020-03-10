import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:yuyan_app/models/component/appUI.dart';

class FloatingCollaps extends StatelessWidget {
  const FloatingCollaps(
      {Key key,
      this.panelControl,
      this.markFunc,
      this.likeFunc,
      this.ifMark: false,
      this.ifLike: false})
      : super(key: key);

  final Function markFunc;
  final Function likeFunc;
  final PanelController panelControl;
  final bool ifMark;
  final bool ifLike;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        panelControl.open();
      },
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
                "  说点什么吧⋯⋯",
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
                      margin: EdgeInsets.all(0),
                      child: FlareActor(
                        "assets/flare/Like.flr",
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
              onTap: () {
                print("object");
              },
            ),
            IconButton(
              icon: ifMark ? Icon(Icons.star) : Icon(Icons.star_border),
              onPressed: markFunc,
            )
          ],
        ),
      ),
    );
  }
}
