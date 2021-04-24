import 'package:flutter/material.dart';
import 'package:yuyan_app/config/viewstate/view_page.dart';
import 'package:yuyan_app/controller/home/personal/my_controller.dart';
import 'package:yuyan_app/views/component/nothing_page.dart';
import 'package:yuyan_app/views/organization/widget/book_row_widget.dart';

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
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (_, i) {
        return BookRowItemWidget(book: data[i]);
      },
    );
  }
}

// class MyBookItemWidget extends StatelessWidget {
//   final BookSeri book;

//   const MyBookItemWidget({
//     Key key,
//     this.book,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => MyRoute.bookDocs(book),
//       child: Container(
//         height: 70,
//         margin: EdgeInsets.only(left: 10, top: 2, bottom: 8, right: 10),
//         decoration: BoxDecoration(
//           color: AppColors.background,
//           boxShadow: [
//             BoxShadow(
//               color: Color.fromARGB(25, 0, 0, 0),
//               offset: Offset(1, 2),
//               blurRadius: 4,
//             ),
//           ],
//           borderRadius: BorderRadius.all(Radius.circular(5)),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             SizedBox(width: 20),
//             Container(
//               margin: EdgeInsets.only(left: 10),
//               child: AppIcon.iconType(book.type),
//             ),
//             Container(
//               margin: EdgeInsets.only(left: 20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Container(
//                     child: Text(
//                       book.name.clip(10),
//                       style: AppStyles.textStyleB,
//                     ),
//                   ),
//                   SizedBox(height: 2),
//                   if (book.description != null)
//                     Container(
//                       width: 200,
//                       child: Text(
//                         "${book.description}",
//                         style: AppStyles.textStyleC,
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 1,
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//             Spacer(),
//           ],
//         ),
//       ),
//     );
//   }
// }
