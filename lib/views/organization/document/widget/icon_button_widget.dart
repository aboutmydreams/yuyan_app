import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/util/util.dart';

//返回 true 表示允许动作，false 表示不切换
typedef FlagTapCallback = Future<bool> Function(bool);

class StarAnimButtonWidget extends StatelessWidget {
  final Future<bool> initValue;
  final FlagTapCallback onTap;

  const StarAnimButtonWidget({
    Key key,
    this.initValue,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _AnimationIconWidget(
      futureFlag: initValue,
      onChanged: onTap,
      defaultWidget: Container(
        margin: EdgeInsets.all(13),
        child: FaIcon(
          FontAwesomeIcons.star,
          size: 18,
          color: Colors.red,
        ),
      ),
      flagWidget: Container(
        height: 62,
        width: 47,
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(0),
        child: FlareActor(
          "assets/flares/mark.flr",
          animation: "Favourite_star",
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}

class LikeAnimButtonWidget extends StatelessWidget {
  final Future<bool> initValue;
  final FlagTapCallback onTap;

  const LikeAnimButtonWidget({
    Key key,
    this.initValue,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _AnimationIconWidget(
      futureFlag: initValue,
      onChanged: onTap,
      defaultWidget: Container(
        margin: EdgeInsets.all(13),
        child: Icon(
          Icons.favorite_border,
          size: 22,
          color: Colors.red,
        ),
      ),
      flagWidget: Container(
        height: 48,
        width: 47,
        child: FlareActor(
          "assets/flares/Like.flr",
          animation: "Like heart",
        ),
      ),
    );
  }
}

class _AnimationIconWidget extends StatefulWidget {
  final Future<bool> futureFlag;
  final Widget flagWidget;
  final Widget defaultWidget;
  final FlagTapCallback onChanged;
  final Duration duration;

  _AnimationIconWidget({
    Key key,
    this.futureFlag,
    this.duration = const Duration(milliseconds: 100),
    this.flagWidget,
    this.defaultWidget,
    this.onChanged,
  }) : super(key: key);

  @override
  __AnimationIconWidgetState createState() => __AnimationIconWidgetState();
}

class __AnimationIconWidgetState extends State<_AnimationIconWidget> {
  RxBool state = false.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.onChanged != null) {
          var res = await widget.onChanged(!state.value);
          if (res) {
            state.value = !state.value;
          }
        }
      },
      child: futureBuilder(
        widget.futureFlag,
        onData: (value) {
          state = RxBool(value ?? false);
          return Obx(
            () => widget.defaultWidget.onlyIf(
              !state.value,
              elseif: () => widget.flagWidget,
            ),
          );
        },
      ),
    );
  }
}
