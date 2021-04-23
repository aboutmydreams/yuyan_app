import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/controller/quick_link_controller.dart';
import 'package:yuyan_app/model/dashboard/quick_link_seri.dart';
import 'package:yuyan_app/util/styles/app_ui.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/widget/user_widget.dart';

class QuickSetPage extends StatelessWidget {
  const QuickSetPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List<Data> quickDataList = topModel.quickManage.quickData.data;

    return Scaffold(
      appBar: AppBar(
        title: Text("快捷入口"),
      ),
      body: Container(
        child: GetBuilder<QuickLinkController>(
          builder: (c) => c.builder(
            (state) {
              var data = state.data;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (_, index) {
                  return _QuickSetItemWidget(data: data[index]);
                },
              );
            },
          ),
        ),
      ),
      // 未来添加设置快捷功能
      // floatingActionButton: Stack(
      //   children: <Widget>[
      //     Positioned(
      //       bottom: 70,
      //       right: 0,
      //       child: FloatingActionButton(
      //         onPressed: () {},
      //         child: Icon(Icons.add),
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}

class _QuickSetItemWidget extends StatelessWidget {
  final QuickLinkSeri data;

  _QuickSetItemWidget({
    Key key,
    this.data,
  }) : super(key: key);

  final Map<String, String> iconType = {
    "Normal": "assets/images/dashboard/link.png",
    "Design": "assets/images/dashboard/design.png",
    "Book": "assets/images/dashboard/book.png"
  };

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
        height: 70,
        margin: EdgeInsets.only(top: 2, bottom: 9, left: 10, right: 10),
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
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: UserAvatarWidget(
                avatar: imageUrl,
                height: 50,
              ),
            ),
            Text(
              data.title,
              style: AppStyles.textStyleB,
            )
          ],
        ),
      ),
    );
  }
}
