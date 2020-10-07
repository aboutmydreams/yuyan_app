import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/group/topic/view/the_comment.dart';
import 'package:yuyan_app/models/net/requests_api/doc/data/comments_data.dart';
import 'package:yuyan_app/models/widgets_small/text_field.dart';

class CommentPanel extends StatelessWidget {
  const CommentPanel({
    Key key,
    this.textControl,
    this.panelControl,
    this.onpressed,
    this.comments,
    this.scrollController,
    this.myFocusNode,
  }) : super(key: key);
  final TextEditingController textControl;
  final PanelController panelControl;
  final Function onpressed;
  final FocusNode myFocusNode;
  final Comments comments;
  final scrollController;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    print(comments.data.length);
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 13),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 16,
              child: Text(
                "评论",
                style: AppStyles.textStyleBp,
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: comments.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return oneComment(context, comments.data[index]);
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: w * 0.79,
                        padding:
                            EdgeInsets.fromLTRB(w * 0.02, 12, w * 0.02, 12),
                        child: CommentTextfierd(
                          controller: textControl,
                          w: w * 0.76,
                          maxLines: 1,
                          focusNode: myFocusNode,
                          hintText: " 说点什么吧⋯",
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.16,
                        child: FlatButton(
                          onPressed: onpressed,
                          autofocus: true,
                          color: AppColors.primary,
                          textColor: Colors.white.withAlpha(235),
                          child: Text(
                            "发表",
                            style: TextStyle(
                              fontFamily: "sans_bold",
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
