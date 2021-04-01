import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/controller/document/book_controller.dart';
import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/model/document/doc.dart';
import 'package:yuyan_app/model/document/user.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/views/widget/list_helper_widget.dart';
import 'package:yuyan_app/views/widget/lake_image_widget.dart';
import 'package:yuyan_app/views/widget/user_widget.dart';

class BookDocPage extends StatelessWidget {
  final int bookId;
  final BookSeri book;

  BookDocPage({
    Key key,
    this.book,
  })  : bookId = book.id,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var title = '文档知识库';
    var type = book?.type ?? 'Book';
    return Scaffold(
      appBar: AppBar(
        title: Text(book?.name ?? title),
        actions: [
          IconButton(
            icon: Icon(Icons.star_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: _typeBuilder(type),
    );
  }

  Widget _typeBuilder(String type) {
    switch (type) {
      case 'Book':
        // var layout = book.layout ?? 'Book';
        // return GetBuilder<BookTocController>(
        //   tag: '$bookId',
        //   init: BookTocController(bookId),
        //   builder: (c) => c.stateBuilder(
        //     onIdle: () {
        //       var data = c.value;
        //       var tree = Util.parseTocTree(data);
        //       return SingleChildScrollView(
        //         child: TreeView(
        //           indent: 24,
        //           nodes: tree,
        //         ),
        //       );
        //     },
        //   ),
        // );
        return GetBuilder<BookDocsController>(
          tag: '$bookId',
          init: BookDocsController(bookId),
          builder: (c) => c.stateBuilder(
            onIdle: () {
              var data = c.value;
              return AnimationListWidget(
                itemCount: data.length,
                itemBuilder: (_, i) {
                  return buildDoc(data[i]);
                },
              );
            },
          ),
        );
      default:
        return Container(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Unsupported type: $type',
            style: AppStyles.textStyleA,
          ),
        );
    }
  }

  Widget buildDoc(DocSeri data) {
    // String url =
    //     "https://www.yuque.com/${data['login']}/${data['bookSlug']}/${data['docId'].toString()}";
    return GestureDetector(
      onTap: () {
        // bool onlyUser = data["onlyUser"] ?? false;
        // if ((data["type"] == "Doc") || (data["type"] == "doc")) {
        // OpenPage.docWeb(
        //   context,
        //   login: data["login"],
        //   bookId: data["bookId"],
        //   docId: data["docId"],
        //   bookSlug: data["bookSlug"],
        //   onlyUser: onlyUser,
        // );
        // } else {
        //   openUrl(context, url);
        // }
        MyRoute.docDetail(
          bookId: data.bookId,
          slug: data.slug,
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, top: 6, bottom: 4, right: 10),
        padding: EdgeInsets.only(left: 16, top: 10, bottom: 10, right: 10),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: autoText(
                title: data.title,
                desc: data.description ?? data.customDescription,
                user: data.user,
              ),
            ),
            if (!GetUtils.isNullOrBlank(data.cover))
              Container(
                margin: EdgeInsets.only(left: 10),
                child: circularImage(data.cover),
              )
          ],
        ),
      ),
    );
  }

  Widget autoText({
    String title,
    String desc,
    UserSeri user,
    int maxLines = 2,
  }) {
    desc ??= "";
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          maxLines: 1,
          style: AppStyles.textStyleB,
        ),
        SizedBox(height: 2),
        Text(
          desc,
          style: AppStyles.textStyleC,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        SizedBox(height: 8),
        Row(
          children: [
            UserAvatarWidget(
              avatar: user.avatarUrl,
              height: 22,
            ),
            SizedBox(width: 5),
            Text(
              user.name,
              style: AppStyles.textStyleC,
            ),
          ],
        )
      ],
    );
  }

  Widget circularImage(
    String imgUrl, {
    double height = 91,
    double width = 147,
    double circular = 8,
  }) {
    // int times = height.toInt() ~/ 60;
    imgUrl ??=
        "https://cdn.nlark.com/yuque/0/2019/png/84147/1547032500238-d93512f4-db23-442f-b4d8-1d46304f9673.png";
    return ClipRRect(
      borderRadius: BorderRadius.circular(circular),
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: imgUrl.contains("assets/")
            ? Image.asset(imgUrl)
            : CachedImageWidget(
                url: imgUrl,
              ),
      ),
    );
  }
}
