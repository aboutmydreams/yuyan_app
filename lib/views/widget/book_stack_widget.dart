import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/model/document/group_home/book_stack.dart';
import 'package:yuyan_app/model/document/group_home/summary.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/util/util.dart';

class BookStackWidget extends StatelessWidget {
  final List<BookStackSeri> stack;

  BookStackWidget({
    Key key,
    this.stack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: stack.mapWidget(
        (item) => _BlockWidgetWrap(
          title: '${item.name}',
          child: _buildStack(item),
        ),
      ),
    );
  }

  Widget _buildStack(BookStackSeri item) {
    return Column(
      children: item.books.mapWidget(
        (e) => _stackItem(e, item.displayType),
      ),
    );
  }

  Widget _stackItem(BookSeri item, int type) {
    Widget bottom;
    switch (type) {
      case 0: //基础样式，无summary
        break;
      case 1: //
        bottom = Column(
          children: _summaryList(item.summary, item.type),
        );
        break;
      case 2: //
      case 3: //
    }

    Widget child = BookTileWrapWidget(
      padding: const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 4,
      ),
      book: item,
      bottom: bottom,
    );

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(25, 0, 0, 0),
            offset: Offset(1, 2),
            blurRadius: 2,
          ),
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      child: child,
    );
  }

  List<Widget> _summaryList(List<SummarySeri> items, String type) {
    switch (type) {
      case 'Book':
      case 'Sheet':
        return items.mapWidget((e) => _docItem(e));
      case 'Design':
        return [
          Row(
            children: items.map((e) {
              return Flexible(
                flex: 1,
                child: Container(
                  child: CachedNetworkImage(imageUrl: e.image),
                ),
              );
            }).toList(),
          )
        ];
      default:
        return [
          Text('unsupport type: $type'),
        ];
    }
  }

  Widget _docItem(SummarySeri item) {
    return InkWell(
      onTap: () {
        MyRoute.docDetail(bookId: item.bookId, slug: item.slug);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 7, 0, 2),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                item.title ?? item.titleDraft ?? item.name ?? 'fallback',
              ),
            ),
            Text(
              Util.timeCut(item.contentUpdatedAt ?? item.createdAt),
              style: AppStyles.textStyleCC,
            ),
          ],
        ),
      ),
    );
  }
}

class BookTileWrapWidget extends StatelessWidget {
  final BookSeri book;
  final Widget top;
  final Widget bottom;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Widget divider;

  const BookTileWrapWidget({
    Key key,
    this.book,
    this.top,
    this.bottom,
    this.margin,
    this.divider = const Divider(
      height: 12,
      thickness: 0.3,
    ),
    this.padding = const EdgeInsets.symmetric(
      vertical: 4,
      horizontal: 8,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget tile = GestureDetector(
      onTap: () {
        MyRoute.bookDocs(book);
      },
      child: _buildTile(),
    );
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (top != null) top,
          if (top != null) divider,
          Container(
            margin: margin,
            padding: padding,
            child: tile,
          ),
          if (bottom != null) divider,
          if (bottom != null) bottom,
        ],
      ),
    );
  }

  _buildTile() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(right: 8),
          child: AppIcon.iconType(book.type, size: 24),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${book.name}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.textStyleB,
              ),
              if (!GetUtils.isNullOrBlank(book.description))
                Text(
                  "${book.description}",
                  style: AppStyles.textStyleCC,
                )
            ],
          ),
        ),
      ],
    );
  }
}

class _BlockWidgetWrap extends StatelessWidget {
  final String title;
  final Widget child;
  final Border border;

  const _BlockWidgetWrap({
    Key key,
    this.title,
    this.child,
    this.border = const Border(
      top: BorderSide(
        color: Colors.grey,
        width: 0.24,
      ),
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            child: Text(
              '$title',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.textStyleB,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              border: border,
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
