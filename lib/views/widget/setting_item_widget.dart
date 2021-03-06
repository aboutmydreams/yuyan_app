import 'package:badges/badges.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/models/component/appUI.dart';

class SettingItemWidget extends StatelessWidget {
  final String title;
  final String imgAsset;
  final String namedRoute;
  final bool badge;

  const SettingItemWidget({
    Key key,
    this.title,
    this.imgAsset,
    this.namedRoute,
    this.badge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        margin: EdgeInsets.only(left: 24),
        child: Image.asset(
          'assets/images/my_page/$imgAsset.png',
          width: 25,
          height: 25,
          fit: BoxFit.contain,
        ),
      ),
      title: Badge(
        padding: EdgeInsets.all(3),
        position: BadgePosition.topStart(),
        alignment: Alignment.centerLeft,
        child: Text(
          '$title',
          textAlign: TextAlign.left,
          style: AppStyles.textStyleBC,
        ),
        showBadge: badge ?? false,
      ),
      trailing: Container(
        margin: EdgeInsets.only(right: 20),
        child: Icon(Icons.chevron_right),
      ),
      onTap: () {
        Get.toNamed(namedRoute);
      },
    );
  }
}
