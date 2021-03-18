import 'package:flutter/material.dart';
import 'package:yuyan_app/views/explore_page/search/search_delegate.dart';

class SearchActionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.search,
        color: Colors.white,
      ),
      tooltip: '在语雀中搜索',
      onPressed: () {
        showSearch(
          context: context,
          delegate: SearchBarDelegate(),
        );
      },
    );
  }
}
