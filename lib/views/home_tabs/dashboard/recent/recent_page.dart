import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/controller/recent_controller.dart';
import 'package:yuyan_app/model/dashboard/user_recent_seri.dart';
import 'package:yuyan_app/model/document/doc.dart';
import 'package:yuyan_app/util/styles/app_ui.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/widget/animation.dart';
import 'package:yuyan_app/views/widget/menu_item.dart';

class RecentPage extends StatelessWidget {
  RecentPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecentController>(
      builder: (controller) => controller.builder(
        (state) => Container(
          width: MediaQuery.of(context).size.width,
          child: AnimationColumnWidget(
            children:
                state.data.map((e) => _UserRecentItemWidget(data: e)).toList(),
          ),
        ),
      ),
    );
  }
}

Map<String, String> actionType = {
  "Follow": "关注了",
  "Update": "更新了",
  "Create": "新建了",
  "Edit": "编辑了",
  "Join": "加入了",
  "Collect": "收藏了",
  "Collab": "加入了协作"
};

Map<String, String> subjectType = {
  "Doc": "文档",
  "Book": "知识库",
  "Thread": "话题",
  "Sheet": "表格文档",
  "Column": "博客专栏",
  "Group": "团队",
  "Design": "画板",
  "Mind": "思维导图",
};

class _UserRecentItemWidget extends StatelessWidget {
  final UserRecentSeri data;

  _UserRecentItemWidget({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String action =
        "${actionType[data.action]}${subjectType[data.subjectType]}";
    String url =
        data.url[0] == '/' ? "https://www.yuque.com" + data.url : data.url;
    return GestureDetector(
      onTap: () {
        switch (data.subjectType) {
          case 'Doc':
            var doc = data.target.serialize<DocSeri>();
            MyRoute.docDetailWebview(
              bookId: doc.bookId,
              slug: doc.slug,
              book: doc.book.slug,
              login: doc.book.user.login,
            );
            return;
          case 'Book':
          default:
            break;
        }
        // if (data.subjectType == "Doc") {
        //   // 防止收藏的 doc 后期变为私有时无法定位到 book
        //   if (data.book == null) {
        //     openUrl(context, url);
        //   } else {
        //     OpenPage.docWeb(
        //       context,
        //       login: data.book.user.login,
        //       bookSlug: data.book.slug,
        //       bookId: data.book.id,
        //       docId: data.targetId,
        //     );
        //   }
        // } else if (data.subjectType == "Book") {
        //   // print(data.u);
        //   OpenPage.docBook(
        //     context,
        //     bookId: data.target.id,
        //     bookSlug: data.target.slug,
        //   );
        // } else {
        //   openUrl(context, url);
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
              blurRadius: 1,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20),
              child: AppIcon.iconType(data.subjectType),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        data.title.clip(20),
                        style: AppStyles.textStyleB,
                      ),
                    ),
                    Container(
                      child: Text(
                        action,
                        style: AppStyles.textStyleC,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            PopupMenuButton(
              itemBuilder: (_) => [
                if (data.canEdit)
                  PopupMenuItem(
                    value: () {
                      MyRoute.webview(url + '/edit');
                    },
                    child: MenuItemWidget(
                      iconData: Icons.edit,
                      title: '编辑',
                    ),
                  ),
                PopupMenuItem(
                  value: () {
                    ApiRepository.deleteRecentItem(data.id).then((_) {
                      if (_) {
                        RecentController.to.remove(data);
                        BotToast.showText(text: '成功');
                      }
                    }).catchError((e) {
                      BotToast.showText(text: '失败');
                    });
                  },
                  child: MenuItemWidget(
                    iconData: Icons.delete,
                    title: '移除记录',
                  ),
                ),
              ],
              onSelected: (_) => _?.call(),
            ),
          ],
        ),
      ),
    );
  }
}
