import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/open_page.dart';
import 'package:yuyan_app/models/net/requests_api/search/search.dart';
import 'package:yuyan_app/models/widgets_small/toast.dart';
import 'package:yuyan_app/views/explore_page/search/search_result/result_page.dart';
import 'package:yuyan_app/views/explore_page/search/tabbar_config.dart';

class SearchBarDelegate extends SearchDelegate<String> {
  int pageIndex = 0;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        //将搜索内容置为空
        onPressed: () {
          if (query.length > 0) {
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
  Widget buildResults(BuildContext context, {bool aboutMe: false}) {
    // searchSomething(context, text: query, index: 0);
    if (query == "") {
      myToast(context, "🔍找点什么呢❓");
      return null;
    } else {
      return SearchResultPage(
        text: query,
        aboutMe: aboutMe,
        pageIndex: pageIndex,
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // searchList = query == "" ? [] : []; //DioSearch.getBaidu(text: query)
    // final suggestionList = query.isEmpty ? [] : [];
    //searchList.where((input) => input.startsWith(query)).toList();

    return ListView.builder(
      itemCount: searchAll.keys.length,
      itemBuilder: (context, index) => ListTile(
          title: RichText(
            text: TextSpan(
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
                  text: searchAll.keys.toList()[index],
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          trailing: Icon(searchAll.values.toList()[index]),
          focusColor: Colors.amber,
          onTap: () {
            if (query == "") {
              myToast(context, "🔍找点什么呢❓");
              return null;
            } else {
              pageIndex = index;
              showResults(context);
            }
          }),
    );
  }
}
