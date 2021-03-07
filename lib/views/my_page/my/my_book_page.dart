import 'package:flutter/material.dart';
import 'package:yuyan_app/config/viewstate/view_page.dart';
import 'package:yuyan_app/controller/global/user_controller.dart';
import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/widgets_small/nothing.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/widget/animation_widget.dart';

class MyBooksPage extends FetchRefreshListViewPage<MyBookController> {
  MyBooksPage()
      : super(
          title: "我的知识库",
        );

  @override
  Widget buildEmpty() {
    return NothingPage(
      top: 50,
      text: "暂无关注~",
    );
  }

  @override
  Widget buildChild() {
    var data = controller.value.data;
    return AnimationListWidget(
      itemCount: data.length,
      itemBuilder: (_, i) {
        return MyBookItemWidget(book: data[i]);
      },
    );
  }
}

// class MyReposPage extends StatefulWidget {
//   MyReposPage({Key key}) : super(key: key);
//
//   @override
//   _MyReposPageState createState() => _MyReposPageState();
// }
//
// class _MyReposPageState extends State<MyReposPage> {
//   int offset = 0;
//   List<UserReposData> dataList;
//   int userIdLocal;
//
//   @override
//   void initState() {
//     super.initState();
//     getFollowerData();
//   }
//
//   getFollowerData() async {
//     var userId = await getUserId();
//     UserReposJson res = await DioUser.getReposData(userId: userId);
//     setState(() {
//       userIdLocal = userId;
//       dataList = res.data;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     analytics.logEvent(name: 'my_repos');
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("我的知识库"),
//       ),
//       body: dataList == null
//           ? loading()
//           : dataList.isEmpty
//               ? NothingPage(
//                   top: 50,
//                   text: "暂无关注~",
//                 )
//               : animationList(
//                   context: context,
//                   dataList: dataList,
//                   childBuilder: myOneRepos,
//                 ),
//     );
//   }
// }

class MyBookItemWidget extends StatelessWidget {
  final BookSeri book;

  const MyBookItemWidget({
    Key key,
    this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // openUrl(context, "https://www.yuque.com/${data.userId}/${data.slug}");

        // if (data.type == "Book") {
        //   OpenPage.docBook(context, bookId: data.id, bookSlug: data.slug);
        // } else {
        //   openUrl(context, "https://www.yuque.com/${data.userId}/${data.slug}");
        // }
      },
      child: Container(
        height: 70,
        margin: EdgeInsets.only(left: 10, top: 2, bottom: 8, right: 10),
        decoration: BoxDecoration(
          color: AppColors.background,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(25, 0, 0, 0),
              offset: Offset(1, 2),
              blurRadius: 4,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 20),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: AppIcon.iconType(book.type),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      book.name.clip(10),
                      style: AppStyles.textStyleB,
                    ),
                  ),
                  SizedBox(height: 2),
                  if (book.description != null)
                    Container(
                      width: 200,
                      child: Text(
                        "${book.description}",
                        style: AppStyles.textStyleC,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
