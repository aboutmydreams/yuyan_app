import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:yuyan_app/controller/app/theme_controller.dart';
import 'package:yuyan_app/config/app_ui.dart';

class SettingTile extends StatelessWidget {
  const SettingTile(
      {Key key, this.title, this.icon, this.onTap, this.ifBadge: false})
      : super(key: key);

  final String title;
  final IconData icon;
  final Function onTap;
  final bool ifBadge;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: (title == "检查更新" && !ifBadge)
          ? Badge(
              padding: EdgeInsets.all(3),
              position: BadgePosition(start: 60),
              child: Text(
                '$title',
                textAlign: TextAlign.left,
                style: AppStyles.textStyleBC,
              ),
            )
          : Text(
              '$title',
              textAlign: TextAlign.left,
              style: AppStyles.textStyleBC,
            ),
      leading: Icon(
        icon,
        color: ThemeController.to.primarySwatchColor,
      ),
      onTap: onTap,
    );
  }
}
