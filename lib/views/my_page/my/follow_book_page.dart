import 'package:flutter/material.dart';
import 'package:yuyan_app/config/viewstate/view_page.dart';
import 'package:yuyan_app/controller/global/my_controller.dart';
import 'package:yuyan_app/model/document/action.dart';
import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/widget/animation_widget.dart';
import 'package:yuyan_app/views/widget/user_widget.dart';

class MyFollowBookPage
    extends FetchRefreshListViewPage<MyFollowBookController> {
  MyFollowBookPage() : super(title: '我关注的知识库');

  @override
  Widget buildChild() {
    var data = controller.value.data;
    return AnimationListWidget(
      itemCount: data.length,
      itemBuilder: (_, i) {
        return MyFollowBookItemWidget(data: data[i]);
      },
    );
  }
}

class MyFollowBookItemWidget extends StatelessWidget {
  final ActionSeri data;

  const MyFollowBookItemWidget({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // data.ifFollow = true;
    return GestureDetector(
      onTap: () {
        // if (data.target.type == "Book") {
        //   OpenPage.docBook(
        //     context,
        //     bookId: data.target.id,
        //     bookSlug: data.target.slug,
        //     login: data.targetGroup.login,
        //   );
        // } else {
        //   openUrl(context, "https://www.yuque.com${data.sUrl}");
        // }
      },
      child: Container(
        height: 70,
        margin: EdgeInsets.only(left: 5, top: 2, bottom: 8, right: 5),
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
            UserAvatarWidget(
              avatar: data.targetGroup.avatarUrl,
              height: 50,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      data.title.clip(10, ellipsis: true),
                      style: AppStyles.textStyleB,
                    ),
                  ),
                  SizedBox(height: 2),
                  Container(
                    width: 200,
                    child: Text(
                      "${data.target.serialize<BookSeri>().description}",
                      style: AppStyles.textStyleC,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            // FollowButtom(data: data),
          ],
        ),
      ),
    );
  }
}
