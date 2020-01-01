import 'package:flutter/material.dart';

class Guide3 extends StatelessWidget {
  const Guide3({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image.asset(
        'assets/images/guide/guide3.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}
