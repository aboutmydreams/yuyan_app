import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yuyan_app/config/viewstate/view_controller.dart';

class FetchRefreshListViewBuilder<T extends FetchListValueController>
    extends StatelessWidget {
  final Function(T) builder;

  const FetchRefreshListViewBuilder({
    Key key,
    this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<T>(
      builder: (c) => SmartRefresher(
        controller: c.refreshController,
        onRefresh: () => c.onRefresh(),
        onLoading: c.onRefreshMore,
        child: builder(c),
        // child: builder(c),
      ),
    );
  }
}

abstract class FetchRefreshListViewPage<T extends FetchSavableController>
    extends GetView<T> {
  final String title;
  final Key key;

  FetchRefreshListViewPage({
    this.key,
    @required this.title,
  }) : super(key: key);

  Widget buildChild();

  Widget buildEmpty() => null;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (c) => Scaffold(
        appBar: AppBar(title: Text(title)),
        body: controller.builder(
          (state) => AnimationLimiter(
            child: SmartRefresher(
              controller: controller.refreshController,
              onRefresh: controller.onRefreshCallback,
              child: buildChild(),
            ),
          ),
          onEmpty: buildEmpty(),
        ),
      ),
    );
  }
}
