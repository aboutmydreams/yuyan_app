import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {
  final _colors = [
    Colors.redAccent,
    Colors.yellowAccent,
    Colors.lightGreen,
    Colors.grey,
    Colors.lightBlue,
    Colors.blueAccent,
    Colors.transparent,
  ];

  final String label;
  final TextStyle style;
  final int colorIndex;
  final VoidCallback onTap;

  LabelWidget({
    Key key,
    @required this.label,
    this.style,
    this.onTap,
    this.colorIndex = 6,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: _colors[colorIndex % _colors.length],
      ),
      child: Text(
        label,
        style: style ??
            TextStyle(
              color: DefaultTextStyle.of(context).style.color.withOpacity(0.6),
            ),
      ),
    );
    if (onTap != null) {
      child = GestureDetector(
        onTap: onTap,
        child: child,
      );
    }
    return child;
  }
}
