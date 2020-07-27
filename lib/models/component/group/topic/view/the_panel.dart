import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/widgets_small/text_field.dart';

class HidePanel extends StatefulWidget {
  const HidePanel(
      {Key key,
      this.textControl,
      this.panelControl,
      this.onpressed,
      this.focusNode})
      : super(key: key);
  final TextEditingController textControl;
  final PanelController panelControl;
  final Function onpressed;
  final FocusNode focusNode;

  @override
  _HidePanelState createState() => _HidePanelState(
        textControl: textControl,
        panelControl: panelControl,
        onpressed: onpressed,
        focusNode: focusNode,
      );
}

class _HidePanelState extends State<HidePanel> {
  _HidePanelState(
      {Key key,
      this.textControl,
      this.panelControl,
      this.onpressed,
      this.focusNode});
  final TextEditingController textControl;
  final PanelController panelControl;
  final Function onpressed;
  final FocusNode focusNode;

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    // FocusNode focusNode;
    return Scaffold(
      body: Container(
        height: 130,
        margin: EdgeInsets.only(top: 13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 24),
              child: Text(
                "发表评论",
                style: AppStyles.textStyleBBB,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: w * 0.79,
                  padding: EdgeInsets.fromLTRB(w * 0.02, 12, w * 0.02, 12),
                  child: CommentTextfierd(
                    controller: textControl,
                    w: w * 0.76,
                    focusNode: focusNode,
                  ),
                ),
                Container(
                  height: 100,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: w * 0.20,
                        margin: EdgeInsets.only(left: w * 0.003),
                        child: FlatButton.icon(
                          onPressed: () {
                            panelControl.close().then((value) {});
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          icon: Icon(Icons.swap_vert),
                          label: Text("收起", style: AppStyles.textStyleBBB),
                          padding: EdgeInsets.all(0),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.16,
                        child: FlatButton(
                          onPressed: onpressed,
                          autofocus: true,
                          color: AppColors.primary,
                          textColor: Colors.white.withAlpha(235),
                          child: Text("发表",
                              style: TextStyle(
                                fontFamily: "sans_bold",
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                              )),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
