import 'package:flutter/material.dart';

class Guide1 extends StatelessWidget {
  const Guide1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(54, 63, 58, 1),
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
                'assets/images/guide/guide1.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 40, top: 90),
              child: Text(
                "思绪".split("").join("\n"),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: "Silom",
                ),
              ),
            ),
          ),
        ),
        Positioned(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(right: 40, bottom: 90),
              child: CoolText(
                "此夜曲中闻折柳，".split("").join("\n"),
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Silom",
                ),
              ),
            ),
          ),
        ),
        Positioned(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(right: 60, bottom: 90),
              child: CoolText(
                "何人不起故园情。".split("").join("\n"),
                style: TextStyle(color: Colors.white),
                delay: 400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CoolText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final int milliseconds;
  final int delay;

  const CoolText(this.text,
      {this.style: const TextStyle(color: Colors.black),
      this.milliseconds: 1000,
      this.delay: 0});

  @override
  State<CoolText> createState() {
    return _CoolTextState();
  }
}

class _CoolTextState extends State<CoolText>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<int> animation;
  String showText = '';
  String hideText = '';

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.milliseconds));

    animation = IntTween(begin: 0, end: widget.text.length).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeIn));

    animation.addListener(() {
      // print('${animation.value}');
      setState(() {
        showText = widget.text.substring(0, animation.value);
        hideText = widget.text.substring(animation.value, widget.text.length);
      });
    });

    Future.delayed(Duration(milliseconds: widget.delay), () {
      animationController.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Text(showText);
    return RichText(
      maxLines: 50,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(text: showText, style: widget.style),
          TextSpan(
            text: hideText,
            style: widget.style.copyWith(
              color: Colors.transparent,
            ),
          )
        ],
      ),
    );
  }
}
