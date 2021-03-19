import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:yuyan_app/config/viewstate/view_state.dart';
import 'package:yuyan_app/models/widgets_small/nothing.dart';

class ViewErrorWidget extends StatelessWidget {
  final ViewError error;

  const ViewErrorWidget({
    Key key,
    this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('error: $error'),
    );
  }
}

class ViewEmptyWidget extends StatelessWidget {
  const ViewEmptyWidget();

  @override
  Widget build(BuildContext context) {
    return NothingPage(
      top: 100,
      text: 'Empty Result',
    );
  }
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
