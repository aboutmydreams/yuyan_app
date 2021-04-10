import 'package:flutter/material.dart';

class MenuItemWidget extends StatelessWidget {
  final IconData iconData;
  final String title;

  const MenuItemWidget({
    Key key,
    @required this.title,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(
            iconData ?? Icons.error,
            size: 20,
            // color: Theme.of(context).primaryColor,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title),
          ),
        ],
      ),
    );
  }
}
