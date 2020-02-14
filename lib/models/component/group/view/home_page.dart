import 'package:flutter/material.dart';

class GroupHome extends StatefulWidget {
  GroupHome({Key key}) : super(key: key);

  @override
  _GroupHomeState createState() => _GroupHomeState();
}

class _GroupHomeState extends State<GroupHome> {
  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
      itemExtent: 50.0, //item高度或宽度，取决于滑动方向
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return ListTile(
            title: Text('Item $index'),
          );
        },
        childCount: 30,
      ),
    );
  }
}
