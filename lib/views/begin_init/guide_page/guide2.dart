import 'package:flutter/material.dart';

class Guide2 extends StatelessWidget {
  const Guide2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(145, 186, 247, 1),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
        ),
        Positioned(
          child: Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 120),
              width: MediaQuery.of(context).size.width * 0.6,
              child: Image.asset(
                'assets/images/guide/guide2.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(right: 40, bottom: 90),
              child: Text(
                "自缘不睹榴皮字，".split("").join("\n"),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        Positioned(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(right: 60, bottom: 90),
              child: Text(
                "想像祇园蔓草书。".split("").join("\n"),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
