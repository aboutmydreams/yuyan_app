import 'package:flutter/material.dart';
import 'package:yuyan_app/model/document/card/card_link_detail.dart';
import 'package:yuyan_app/util/styles/app_ui.dart';

class LakeInlineLinkWidget extends StatelessWidget {
  const LakeInlineLinkWidget({
    Key key,
    @required this.link,
  }) : super(key: key);

  final CardLinkDetailSeri link;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        child: Row(
          children: [
            AppIcon.iconType(link.type),
            Text(
              link.title ?? '',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
