import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/user/view/view/one_repos.dart';
import 'package:yuyan_app/models/net/requests_api/user/data/user_repos_data.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/nothing.dart';

class UserBookPage extends StatelessWidget {
  UserBookPage({Key key, this.bookJson}) : super(key: key);
  final UserReposJson bookJson;

  @override
  Widget build(BuildContext context) {
    return bookJson == null
        ? loading()
        : bookJson.data.isEmpty
            ? NothingPage(top: 190, text: "知识库空空")
            : SingleChildScrollView(
                child: aniColumn(
                  aniWhich: 4,
                  children: [SizedBox(height: 155)]
                    ..addAll(bookJson.data.map((a) {
                      return oneRepos(context, reposMap(a));
                    }).toList()),
                ),
              );
  }
}

Map reposMap(UserReposData data) {
  return {
    "type": data.type,
    "login": data.user.login,
    "bookId": data.id,
    "bookSlug": data.slug,
    "description": data.description != null
        ? data.description.replaceAll("<em>", "").replaceAll("</em>", "")
        : null,
    "name": data.name.replaceAll("<em>", "").replaceAll("</em>", ""),
    "onlyUser": true,
  };
}
