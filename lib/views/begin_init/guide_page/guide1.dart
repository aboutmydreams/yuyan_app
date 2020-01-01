import 'package:flutter/material.dart';

class Guide1 extends StatelessWidget {
  const Guide1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image.asset(
        'assets/images/guide/guide1.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}
