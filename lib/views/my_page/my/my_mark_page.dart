import 'package:flutter/material.dart';
import 'package:yuyan_app/config/viewstate/view_page.dart';
import 'package:yuyan_app/controller/global/user_controller.dart';
import 'package:yuyan_app/model/document/action.dart';
import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/model/document/doc_lite.dart';
import 'package:yuyan_app/model/events/user_lite_seri.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/widgets_small/nothing.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';
import 'package:yuyan_app/views/widget/animation_widget.dart';

class MyMarkPage extends FetchRefreshListViewPage<MyMarkController> {
  MyMarkPage()
      : super(
          title: '我的收藏',
        );

  @override
  Widget buildEmpty() {
    return NothingPage(
      top: 50,
      text: "暂无收藏~",
    );
  }

  @override
  Widget buildChild() {
    var data = controller.value.data;
    return AnimationListWidget(
      itemCount: data.length,
      itemBuilder: (_, i) {
        return MyMarkItemWidget(data: data[i]);
      },
    );
  }
}

class MyMarkItemWidget extends StatelessWidget {
  final ActionSeri data;

  const MyMarkItemWidget({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 如果收藏的是团队，那么 avatarUrl 的位置变了一下...
    String userName;
    String avatarUrl;
    String description = '';
    switch (data.targetType) {
      case 'User':
        var user = data.target.serialize<UserLiteSeri>();
        userName = data.title;
        avatarUrl = user.avatarUrl;
        description = user.description;
        break;
      case 'Book':
        var book = data.target.serialize<BookSeri>();
        userName = book.user.name;
        avatarUrl = book.user.avatarUrl;
        description = book.description;
        break;
      case 'Doc':
        var doc = data.target.serialize<DocLiteSeri>();
        userName = doc.user.name;
        avatarUrl = doc.user.avatarUrl;
        description = doc.description;
        break;
      default:
        userName = 'default_user_name';
        avatarUrl = 'default_avatar_url';
    }

    return GestureDetector(
      onTap: () {
        // if (data.targetType == "User") {
        //   OpenPage.group(
        //     context,
        //     groupdata: GroupData(
        //       id: data.target.id,
        //       login: data.target.login,
        //       name: data.target.name ?? "",
        //       description: data.target.description,
        //       avatarUrl: data.target.avatarUrl,
        //     ),
        //   );
        // } else if (data.targetType == "Book") {
        //   OpenPage.docBook(
        //     context,
        //     bookId: data.target.id,
        //     bookSlug: data.target.slug,
        //   );
        // } else if (data.targetType == "Doc") {
        //   // 防止收藏的 doc 后期变为私有时无法定位到 book
        //   if (data.targetGroup == null) {
        //     openUrl(context, "https://www.yuque.com" + data.sUrl);
        //   } else {
        //     OpenPage.docWeb(
        //       context,
        //       login: data.targetGroup.login,
        //       bookSlug: data.targetBook.slug,
        //       bookId: data.targetBookId,
        //       docId: data.targetId,
        //     );
        //   }
        // } else {
        //   openUrl(context, "https://www.yuque.com${data.sUrl}");
        // }
      },
      child: Container(
        margin: EdgeInsets.only(top: 2, bottom: 9, left: 10, right: 10),
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.background,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(25, 0, 0, 0),
              offset: Offset(1, 2),
              blurRadius: 4,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(9.5)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                userAvatar(avatarUrl, height: 25),
                SizedBox(width: 6),
                Text(
                  '$userName',
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.textStyleC,
                )
              ],
            ),
            SizedBox(height: 6),
            Text(
              '${data.title}',
              style: AppStyles.textStyleB,
            ),
            SizedBox(height: 2),
            Text(
              '$description',
              style: AppStyles.textStyleC,
            )
          ],
        ),
      ),
    );
  }
}
