import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/user/view/view/one_repos.dart';
import 'package:yuyan_app/models/net/requests_api/search/data/repos_data.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/nothing.dart';

class SearchReposPage extends StatelessWidget {
  const SearchReposPage({Key key, this.searchReposJson}) : super(key: key);

  final SearchReposJson searchReposJson;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: searchReposJson == null
          ? loading()
          : searchReposJson.data.hits.isEmpty
              ? NothingPage(
                  top: 50,
                  text: "暂无用户~",
                )
              : animationList(
                  context: context,
                  aniWhich: 2,
                  dataList: searchReposJson.data.hits
                      .map((data) => setData(data))
                      .toList(),
                  childBuilder: oneRepos,
                ),
    );
  }
}

Map<String, dynamic> setData(Hits data) {
  return {
    "type": data.rRecord.type,
    "login": data.rRecord.user.login,
    "bookId": data.rRecord.id,
    "bookSlug": data.slug,
    "description":
        data.description.replaceAll("<em>", "").replaceAll("</em>", ""),
    "name": data.name.replaceAll("<em>", "").replaceAll("</em>", ""),
  };
}
