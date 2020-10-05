import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/open_page.dart';
import 'package:yuyan_app/models/net/requests_api/search/search.dart';
import 'package:yuyan_app/models/widgets_small/toast.dart';
import 'package:yuyan_app/views/explore_page/search/search_result/result_page.dart';

class SearchBarDelegate extends SearchDelegate<String> {
  List searchList = ["wangcai", "xiaoxianrou", "dachangtui", "nvfengsi"];

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
  Widget buildResults(BuildContext context) {
    // searchSomething(context, text: query, index: 0);
    return SearchResultPage(
      text: query,
      aboutMe: false,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    searchList = query == "" ? [] : []; //DioSearch.getBaidu(text: query)
    // final suggestionList = query.isEmpty ? [] : [];
    //searchList.where((input) => input.startsWith(query)).toList();

    return ListView.builder(
      itemCount: 6,
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
                  text: recentSuggest[index],
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          trailing: Icon(suggestIcons[index]),
          focusColor: Colors.amber,
          onTap: () => searchSomething(context, index: index, text: query)),
    );
  }
}

const recentSuggest = ["文档", "知识库", "画板", "讨论", "团队", "用户"];
const List<IconData> suggestIcons = [
  Icons.description,
  Icons.book,
  Icons.collections,
  Icons.comment,
  Icons.supervised_user_circle,
  Icons.person
];

Null searchSomething(context, {String text, int index}) {
  if (text == "") {
    myToast(context, "🔍找点什么呢❓");
  } else {
    index == 0
        ? OpenPage.search(context, text: text, aboutMe: true)
        : OpenPage.search(context, text: text);
  }
}
