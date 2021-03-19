part of '../group_page.dart';

class _HomeWidget extends StatelessWidget {
  final List<GroupViewBlockSeri> items;

  _HomeWidget({
    Key key,
    this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<GroupViewBlockSeri> blocks = [];
    items.forEach((out) {
      /// placements一般有两个元素
      /// 第一个是左边区域，第二个是右边区域
      /// 但是手机一般不能同时显示左右区域
      /// 这里，给的顺序来，先左，后右
      out.placements.forEach((inner) {
        blocks.addAll(inner.blocks);
      });
    });

    return ListView.builder(
      itemCount: blocks.length,
      itemBuilder: (_, i) {
        var block = blocks[i];
        return _blockType(block);
      },
    );
  }

  _blockType(GroupViewBlockSeri block) {
    /// type类型
    /// 1. bookStack 首页知识库，支持自定义显示样式
    /// 2. custom 小记内容
    /// 3. quickLinks 快捷入口
    /// 4. events 团队动态
    /// 5. bookList 热门知识库，不用自定义样式
    /// 6. memberList 活跃用户
    /// 7. topicList  话题列表
    /// 8. searchInput 搜索框，支持推荐内容
    /// 9. docList 热门文档，支持自定义显示样式
    ///10. banner 轮播图
    switch (block.type) {
      case 'bookStacks':
        return Container(
          child: _BookStackWidget(
            stack: block.data.list<BookStackSeri>(),
          ),
        );
      case 'banner':
        return _BannerWidget(
          data: block.data.list<QuickLinkSeri>(),
        );
      // case 'custom':
      // case 'quickLinks':
      default:
        return Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
          ),
          child: Text('不支持主页类型: ${block.type}'),
        );
    }
  }
}

class _BannerWidget extends StatelessWidget {
  final List<QuickLinkSeri> data;

  const _BannerWidget({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      width: Get.width,
      height: 160,
      child: Swiper(
        itemCount: data.length,
        itemBuilder: (_, i) {
          var item = data[i];
          Widget child = Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    height: 160,
                    imageUrl: item.icon,
                    placeholder: (_, url) =>
                        Container(color: AppColors.background),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 8,
                  bottom: 4,
                  child: Text(
                    '${item.title}',
                    style: AppStyles.groupTextStyle.copyWith(
                      backgroundColor: Colors.black.withOpacity(0.3),
                    ),
                  ),
                ),
              ],
            ),
          );
          return GestureDetector(
            onTap: () {
              MyRoute.webview(item.url);
            },
            child: child,
          );
        },
      ),
    );
  }
}

class _BookStackWidget extends StatelessWidget {
  final List<BookStackSeri> stack;

  const _BookStackWidget({
    Key key,
    this.stack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: stack.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (_, i) {
        var item = stack[i];
        return Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: Text(
                  "${item.name}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.textStyleB,
                ),
              ),
              _buildStack(stack[i]),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStack(BookStackSeri item) {
    return Column(
      children: item.books.map((e) => _stackItem(e, item.displayType)).toList(),
    );
  }

  List<Widget> _summaryList(List<SummarySeri> items, String type) {
    switch (type) {
      case 'Book':
      case 'Sheet':
        return items.map((e) {
          return _docItem(e);
        }).toList();
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

  Widget _stackItem(BookSeri item, int type) {
    Widget child = _BookTileWrap(
      book: item,
      bottom: Container(
        padding: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey.withOpacity(0.5),
              width: 0.3,
            ),
          ),
        ),
        child: Column(
          children: _summaryList(item.summary, item.type),
        ),
      ),
    );

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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

  Widget _docItem(SummarySeri item) {
    return InkWell(
      onTap: () {
        // OpenPage.docWeb(
        //   context,
        //   login: login,
        //   bookSlug: bookSlug,
        //   bookId: data.bookId,
        //   docId: data.id,
        // );
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

class _BookTileWrap extends StatelessWidget {
  final BookSeri book;
  final Widget top;
  final Widget bottom;

  const _BookTileWrap({
    Key key,
    this.book,
    this.top,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget tile = GestureDetector(
      onTap: () {
        //TODO(@dreamer2q): 打开book
      },
      child: _buildTile(),
    );
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (top != null) top,
          tile,
          if (bottom != null) bottom,
        ],
      ),
    );
  }

  _buildTile() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(right: 12),
            child: AppIcon.iconType(book.type, size: 24),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${book.name}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.textStyleB,
                ),
                if (book.description != null)
                  Text(
                    "${book.description}",
                    style: AppStyles.textStyleCC,
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
