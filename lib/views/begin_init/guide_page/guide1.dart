import 'package:flutter/material.dart';

class Guide1 extends StatelessWidget {
  const Guide1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Container(
            color: Colors.pink,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/images/guide/guide1.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(right: 40, bottom: 90),
              child: Text(
                "此夜曲中闻折柳，".split("").join("\n"),
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
                "何人不起故园情。".split("").join("\n"),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
