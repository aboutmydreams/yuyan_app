import 'package:flutter/material.dart';

class FloatingActionWidget extends StatelessWidget {
  final Widget button;
  final VoidCallback onPressed;
  final Widget child;

  const FloatingActionWidget({
    Key key,
    this.button,
    this.onPressed,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: button,
        onPressed: onPressed,
      ),
      body: child,
    );
  }
}
