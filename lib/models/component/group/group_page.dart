import 'package:flutter/material.dart';

class GroupPage extends StatefulWidget {
  GroupPage({Key key, this.groupId, this.pageIndex}) : super(key: key);
  final groupId;
  final pageIndex;

  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  _GroupPageState({Key key, this.groupId});
  final groupId;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("data"),
    );
  }
}
