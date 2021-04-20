import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/controller/document/book_controller.dart';
import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/model/document/doc.dart';
import 'package:yuyan_app/model/document/doc_detail/artboard_seri.dart';
import 'package:yuyan_app/model/user/user.dart';
import 'package:yuyan_app/config/app_ui.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/widget/lake/lake_image_widget.dart';
import 'package:yuyan_app/views/widget/user_widget.dart';

class BookDocPage extends StatelessWidget {
  final int bookId;
  final BookSeri book;

  BookDocPage({
    Key key,
    this.book,
  })  : bookId = book.id,
        super(key: key);

  String get tag => '$bookId';

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
      body: _typeBuilder(type, book),
    );
  }

  Widget _typeBuilder(String type, BookSeri book) {
    if (['Sheet', 'Book', 'Column'].contains(type)) {
      return GetBuilder<BookDocsController>(
        tag: tag,
        init: BookDocsController(bookId),
        builder: (c) => c.stateBuilder(
          onIdle: () => Scrollbar(
            child: SmartRefresher(
              enablePullUp: true,
              controller: c.refreshController,
              onRefresh: c.refreshCallback,
              onLoading: c.loadMoreCallback,
              child: _buildDocs(c.value, type),
            ),
          ),
        ),
      );
    }
    if (type == 'Design') {
      return GetBuilder<BookArtController>(
        init: BookArtController(bookId),
        builder: (c) => c.stateBuilder(
          onIdle: () => Scrollbar(
              child: SmartRefresher(
            controller: c.refreshController,
            enablePullUp: true,
            onRefresh: c.refreshCallback,
            onLoading: c.loadMoreCallback,
            child: ListView.builder(
              itemCount: c.value.length,
              itemBuilder: (_, i) => buildArt(c.value[i]),
            ),
          )),
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.all(24),
      child: Text(
        'Unsupported type: $type',
        style: AppStyles.textStyleA,
      ),
    );
  }

  Widget buildArt(ArtboardSeri art) {
    var arts = art.artboards; //.take(3).toList();
    var child = Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: arts.mapWidget(
                  (item) => Container(
                    constraints: BoxConstraints(
                      minHeight: 160,
                      maxHeight: 160,
                      maxWidth: 320,
                    ),
                    height: 160,
                    child: CachedNetworkImage(
                      imageUrl: item.image,
                    ),
                  ),
                ),
              ),
            ).onlyIf(
              !GetUtils.isNullOrBlank(arts),
              elseif: () => Container(
                alignment: Alignment.center,
                height: 160,
                child: Text(
                  '没有图片',
                ),
              ),
            ),
            Divider(height: 16, thickness: 1),
            Text(
              '${art.name}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.textStyleB,
            ),
            Text(
              '更新于：${Util.timeCut(art.updatedAt)} · ${arts.length}张图',
              style: AppStyles.textStyleC,
            ),
          ],
        ),
      ),
    );
    return GestureDetector(
      onTap: () {
        var user = book.user.login;
        var slug = book.slug;
        MyRoute.webview('${Util.baseUrl}/$user/$slug/artboards/${art.id}');
      },
      child: child,
    );
  }

  Widget _buildDocs(List<DocSeri> data, String type) {
    if (type == 'Sheet') {
      return SingleChildScrollView(
        child: Container(
          width: Get.width,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: data.mapWidget(
              (item) => buildDoc(item, 'Sheet'),
            ),
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (_, i) {
        return buildDoc(data[i], 'Book');
      },
    );
  }

  Widget buildDoc(DocSeri data, String style) {
    Widget child = Container(
      child: Text('Not supported: $style'),
    );
    if (style == 'Book') {
      child = Container(
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
      );
    } else if (style == 'Sheet') {
      var editor = data.user;
      child = Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.all(0),
        child: Container(
          width: 165,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 90,
                width: 90,
                child: CachedImageWidget(
                  url: '${data.cover}',
                ),
              ),
              Row(children: [
                Expanded(
                  child: Text(
                    '${data.title}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.textStyleB,
                  ),
                ),
                Icon(Icons.more_vert),
              ]),
              Text(
                '${editor.name} · ${Util.timeCut(data.updatedAt)}',
                style: AppStyles.textStyleC,
              ),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        MyRoute.docDetailWebview(
          bookId: data.bookId,
          slug: data.slug,
          login: book.user.login,
          book: book.slug,
        );
      },
      child: child,
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
