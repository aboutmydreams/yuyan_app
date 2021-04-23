import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/controller/quick_link_controller.dart';
import 'package:yuyan_app/model/dashboard/quick_link_seri.dart';
import 'package:yuyan_app/util/styles/app_ui.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/widget/absorb.dart';
import 'package:yuyan_app/views/widget/user_widget.dart';

class NoteButton extends StatelessWidget {
  const NoteButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        Navigator.pushNamed(context, "/note");
      },
      icon: Icon(Icons.note),
      label: Text("小记"),
    );
  }
}

class QuickView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final widget = Container(
      height: 70,
      color: AppColors.background,
      child: Row(
        children: [
          quickText("设置快捷入口"),
          setEntry(context),
        ],
      ),
    );
    return GetBuilder<QuickLinkController>(
      builder: (c) => c.builder(
        (state) {
          return Container(
            height: 70,
            color: AppColors.eventBack,
            child: Row(
              children: [
                Expanded(
                  child: NotificationAbsorbWidget(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        quickText("快捷入口"),
                        NoteButton(),
                        ...state.data.map((e) {
                          return _QuickLinkEntryWidget(data: e);
                        }).toList(),
                      ],
                    ),
                  ),
                ),
                setEntry(context)
              ],
            ),
          );
        },
        onLoading: widget,
        onEmpty: widget,
        onError: (_) => widget,
      ),
    );
  }

  Widget setEntry(BuildContext context) {
    return Container(
      height: 70,
      child: IconButton(
        onPressed: () {
          Get.toNamed(RouteName.quickSet);
        },
        icon: Icon(
          Icons.more,
          color: AppColors.primaryText,
        ),
      ),
    );
  }

  Widget quickText(String text) {
    return Container(
      height: 70,
      margin: EdgeInsets.only(left: 20, right: 10),
      child: Center(
        child: Text(
          "$text",
          style: AppStyles.textStyleB,
        ),
      ),
    );
  }
}

class _QuickLinkEntryWidget extends StatelessWidget {
  final Map<String, String> iconType = {
    "Normal": "assets/images/dashboard/link.png",
    "Design": "assets/images/dashboard/design.png",
    "Book": "assets/images/dashboard/book.png"
  };

  final QuickLinkSeri data;

  _QuickLinkEntryWidget({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageUrl = data.icon.toString().contains("http")
        ? data.icon
        : iconType[data.type] ?? "assets/images/dashboard/book.png";
    return GestureDetector(
      onTap: () {
        Util.handleQuickLinkNav(data);
      },
      child: Container(
        height: 50,
        margin: EdgeInsets.only(left: 5, top: 10, bottom: 10, right: 5),
        decoration: BoxDecoration(
          color: AppColors.background,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(25, 0, 0, 0),
              offset: Offset(1, 2),
              blurRadius: 4,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Hero(
                tag: data.targetId ?? '',
                child: UserAvatarWidget(
                  avatar: imageUrl,
                  height: 36,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 20),
              child: Text(
                data.title.clip(6),
                style: AppStyles.textStyleB,
              ),
            )
          ],
        ),
      ),
    );
  }
}
