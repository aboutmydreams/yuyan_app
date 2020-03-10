import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/widgets_small/text_field.dart';

class HidePanel extends StatelessWidget {
  const HidePanel(
      {Key key, this.textControl, this.panelControl, this.onpressed})
      : super(key: key);
  final TextEditingController textControl;
  final PanelController panelControl;
  final Function onpressed;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: 110,
        margin: EdgeInsets.only(top: 26),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: w * 0.80,
              padding: EdgeInsets.fromLTRB(w * 0.02, 16, w * 0.02, 12),
              child: CommentTextfierd(
                controller: textControl,
                w: w * 0.76,
              ),
            ),
            Container(
              height: 100,
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.20,
                    child: FlatButton.icon(
                      onPressed: () {
                        panelControl.close();
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
                      child: Text("发表"),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
