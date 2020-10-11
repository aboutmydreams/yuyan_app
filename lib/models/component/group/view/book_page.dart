import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/open_page.dart';
import 'package:yuyan_app/models/component/user/view/view/one_repos.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/net/requests_api/group/data/group_book_data.dart';
import 'package:yuyan_app/models/tools/clear_text.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/nothing.dart';

class BookPage extends StatefulWidget {
  BookPage({Key key, this.bookJson}) : super(key: key);
  final GroupBookJson bookJson;

  @override
  _BookPageState createState() => _BookPageState(bookJson: bookJson);
}

class _BookPageState extends State<BookPage> {
  _BookPageState({Key key, this.bookJson});
  GroupBookJson bookJson;

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
                      return oneRepos(context, setGroupBook(a));
                    }).toList()),
                ),
              );
  }
}

Map<String, dynamic> setGroupBook(BookData data) {
  return {
    "type": data.type,
    "login": data.user.login,
    "bookId": data.id,
    "bookSlug": data.slug,
    "description": data.description,
    "name": data.name,
  };
}
