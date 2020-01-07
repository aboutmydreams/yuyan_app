import 'package:flutter/material.dart';

class Guide3 extends StatelessWidget {
  const Guide3({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            bottom: MediaQuery.of(context).size.width * 0.2,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.2,
              child: Image.asset(
                'assets/images/guide/guide3.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              // alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.3,
              color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/login");
                    },
                    color: Colors.yellow,
                    child: Container(
                      child: Text("login"),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
