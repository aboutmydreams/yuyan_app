import 'package:flutter/material.dart';

class Guide2 extends StatelessWidget {
  const Guide2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image.asset(
        'assets/images/guide2.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}
