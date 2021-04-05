import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

Widget loading() {
  return Center(
    child: Container(
      width: 90,
      height: 90,
      child: FlareActor(
        "assets/flares/progress.flr",
        animation: "active",
      ),
    ),
  );
  // CircularProgressIndicator(),
}

class ViewLoadingWidget extends StatelessWidget {
  const ViewLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 90,
        height: 90,
        child: FlareActor(
          "assets/flares/progress.flr",
          animation: "active",
        ),
      ),
    );
  }
}
