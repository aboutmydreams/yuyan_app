import 'package:flutter/material.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/explore_page/search/search_result_page.dart';

class SearchBarDelegate extends SearchDelegate {
  SearchBarDelegate() : super(searchFieldLabel: 'Search');

  int pageIndex = 0;

  // 重写叉叉
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          if (query.length > 0 && query != null) {
            query = "";
          } else {
            close(context, "");
          }
        },
      )
    ];
  }

  //重写返回图标
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      //关闭上下文，当前页面
      onPressed: () => close(context, null),
    );
  }

  // 重写搜索结果
  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) return buildSuggestions(context);
    return SearchResultWidget(
      query: query,
      initIndex: pageIndex,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSuggestions();
  }

  goSearch([int index = 0]) {
    if (query.isEmpty) {
      var tipList = ["🔍 丶❔", "找点什么呢", "先打字再 🔍 ❗"];
      Util.toast(tipList.rand());
    } else {
      pageIndex = index;
      showResults(null);
    }
  }

  Widget _buildSuggestions() {
    final Map searchAll = {
      "文档": Icons.description,
      "知识库": Icons.book,
      "讨论": Icons.comment,
      "团队": Icons.supervised_user_circle,
      "用户": Icons.person,
    };
    var leading = searchAll.keys.toList();
    var trailing = searchAll.values.toList();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: searchAll.length,
      itemBuilder: (_, i) {
        return ListTile(
          title: Text.rich(
            TextSpan(
              text: "搜索 ",
              style: TextStyle(color: Colors.grey),
              children: [
                TextSpan(
                  text: query + " ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: leading[i],
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          trailing: Icon(trailing[i]),
          focusColor: Colors.amber,
          onTap: () => goSearch(i),
        );
      },
    );
  }
}
