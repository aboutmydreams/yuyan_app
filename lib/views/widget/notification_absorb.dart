import 'package:flutter/material.dart';

class NotificationAbsorbWidget extends StatelessWidget {
  final Widget child;

  const NotificationAbsorbWidget({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (_) => true,
      child: child,
    );
  }
}
