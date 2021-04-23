import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yuyan_app/util/styles/app_ui.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/controller/global/group_controller.dart';
import 'package:yuyan_app/model/dashboard/quick_link_seri.dart';
import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/model/document/doc.dart';
import 'package:yuyan_app/model/document/group_home/book_stack.dart';
import 'package:yuyan_app/model/document/group_home/group_home_seri.dart';
import 'package:yuyan_app/model/document/note/doclet.dart';
import 'package:yuyan_app/model/topic/topic.dart';
import 'package:yuyan_app/model/user/group/group_user.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/organization/widget/book_stack_widget.dart';
import 'package:yuyan_app/views/widget/lake/cards/mention.dart';
import 'package:yuyan_app/views/widget/lake/lake_render.dart';
import 'package:yuyan_app/views/widget/user_widget.dart';

import 'group_event_widget.dart';

class GroupHomeWidget extends StatelessWidget {
  final List<GroupViewBlockSeri> items;
  final Map meta;
  final int version;
  final int groupId;

  GroupHomeWidget({
    Key key,
    this.items,
    this.meta,
    this.groupId,
  })  : version = meta['version'] ?? 3,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (version < 2) {
      return Container(
        child: Text('鬼畜的版本:$version, 希望你永远不要遇到'),
      );
    }
    if (version == 2) {
      //兼容之前的版本，没有数据，只有meta
      return _build2();
    }
    // 这里是version 3版本，携带有数据
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
    var c = Get.find<GroupHomeController>(tag: '$groupId');
    return Scrollbar(
      child: SmartRefresher(
        controller: c.refreshController,
        onRefresh: c.refreshCallback,
        onLoading: c.loadMoreCallback,
        enablePullUp: true,
        child: ListView.builder(
          itemCount: blocks.length,
          itemBuilder: (_, i) {
            var block = blocks[i];
            return _blockType(block);
          },
        ),
      ),
    );
  }

  Widget _build2() {
    var layout = meta['homepage']['layout'];
    List<String> blocks = [
      ...(layout['header'] ?? []),
      ...(layout['content'] ?? []),
      ...(layout['aside'] ?? []),
    ];

    var tag = '$groupId';
    var controllers = {
      'headlines': null,
      'book_stacks': () => GroupStackController(groupId),
      'topics': () => GroupTopicController(groupId),
      'quick_links': null,
      'latest_books': () => GroupBookController(groupId),
      'latest_docs': null,
    };

    blocks.forEach((blk) {
      var c = controllers[blk];
      if (c != null) Get.lazyPut(() => c, tag: tag);
    });

    return _upgrade3(blocks, tag);
  }

  Widget _upgrade3(List<String> blocks, String tag) {
    return ListView.builder(
      itemCount: blocks.length,
      itemBuilder: (_, i) {
        var block = blocks[i];
        return _proxy2to3(block, tag);
      },
    );
  }

  Widget _proxy2to3(String block, String tag) {
    switch (block) {
      case 'topics':
        return GetBuilder<GroupTopicController>(
          tag: tag,
          builder: (c) => c.stateBuilder(
            onIdle: () {
              var data = c.value;
              return _BlockWidgetWrap(
                title: '话题',
                child: Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: _TopicListWidget(
                    topics: data,
                  ),
                ),
              );
            },
          ),
        );
      case 'headlines':
        return SizedBox.shrink();
      case 'book_stacks':
        return GetBuilder<GroupStackController>(
          tag: tag,
          builder: (c) => c.stateBuilder(
            onIdle: () {
              var data = c.value;
              return BookStackWidget(
                stack: data,
              );
            },
          ),
        );
      case 'latest_books':
        return GetBuilder<GroupBookController>(
          tag: tag,
          builder: (c) => c.stateBuilder(
            onIdle: () {
              var books = c.value;
              return _BlockWidgetWrap(
                title: '最新知识库',
                child: Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 12,
                  ),
                  child: ListView.separated(
                    separatorBuilder: (_, __) => Divider(height: 0.3),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: books.length,
                    shrinkWrap: true,
                    itemBuilder: (_, i) {
                      var book = books[i];
                      return BookTileWrapWidget(
                        padding: const EdgeInsets.all(10),
                        book: book,
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );
      default:
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.3,
              color: Colors.red,
            ),
          ),
          child: Text('Not supported: $block\n'
              '非常抱歉！你查看的团队首页使用了旧版本的API\n'
              '不能很好的被【雨燕】支持\n'
              '如果你有权限可以通过编辑一下团队首页即可升级\n'
              '如果没有权限，可以去讨论区留言\n'
              '当然，你可以选择打开网页版来解决这个问题\n'
              '或者，你可以反馈给开发者，谢谢。'),
        );
    }
  }

  Widget _blockType(GroupViewBlockSeri block) {
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
    ///11. headlines 头条?
    switch (block.type) {
      case 'headlines':

        ///头条是啥东西呢?
        ///不想研究了，直接屏蔽吧
        return SizedBox.shrink();
      case 'searchInput':
        //TODO(@dreamer2q): 组织内部搜索，由scope参数提供
        return SizedBox.shrink();
      case 'memberList':
        var members = block.data.list<GroupUserSeri>();
        return _BlockWidgetWrap(
          title: block.title,
          child: _MemberListWidget(
            members: members,
          ),
        );
      case 'bookList':
        var books = block.data.list<BookSeri>();
        return _BlockWidgetWrap(
          title: block.title,
          child: Card(
            margin: const EdgeInsets.symmetric(
              vertical: 6,
              horizontal: 12,
            ),
            child: Column(
              children: books.mapWidget(
                (item) => BookTileWrapWidget(
                  book: item,
                  padding: const EdgeInsets.all(10),
                ),
                divide: true,
              ),
            ),
          ),
        );
      case 'quickLinks':
        var links = block.data.list<QuickLinkSeri>();
        return _BlockWidgetWrap(
          title: block.title,
          child: _GroupQuickLinks(
            links: links,
          ),
        );
      case 'custom':
        var data = block.data.serialize<DocletSeri>();
        return _BlockWidgetWrap(
          title: block.title,
          child: Card(
            margin: const EdgeInsets.symmetric(
              vertical: 6,
              horizontal: 12,
            ),
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
              ),
              child: LakeRenderWidget(
                data: data.bodyAsl,
              ),
            ),
          ),
        );
      case 'topicList':
        return _BlockWidgetWrap(
          title: block.title,
          child: Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            child: _TopicListWidget(
              topics: block.data.list<TopicSeri>(),
            ),
          ),
        );
      case 'bookStacks':
        return BookStackWidget(
          stack: block.data.list<BookStackSeri>(),
        );
      case 'banner':
        return _BannerWidget(
          data: block.data.list<QuickLinkSeri>(),
        );
      case 'docList':
        return _BlockWidgetWrap(
          title: block.title,
          child: _DocListWidget(
            docs: block.data.list<DocSeri>(),
          ),
        );
      case 'events':
        return _BlockWidgetWrap(
          title: block.title,
          child: Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            child: GroupEventWidget(
              blockId: block.id,
            ),
          ),
        );
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

class _GroupQuickLinks extends StatelessWidget {
  final List<QuickLinkSeri> links;

  const _GroupQuickLinks({
    Key key,
    this.links,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      elevation: 1,
      child: Container(
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: links.length,
          itemBuilder: (_, i) {
            var link = links[i];
            return InkWell(
              onTap: () => Util.handleQuickLinkNav(link),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    AppIcon.iconType(link.type),
                    Text(
                      '${link.title}',
                      style: AppStyles.textStyleC,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
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

class _DocListWidget extends StatelessWidget {
  final List<DocSeri> docs;

  const _DocListWidget({
    Key key,
    this.docs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: docs.map((e) {
            return _DocTileWidget(doc: e, last: e == docs.last);
          }).toList(),
        ),
      ),
    );
  }
}

class _DocTileWidget extends StatelessWidget {
  final DocSeri doc;
  final bool last;
  final Border border;

  const _DocTileWidget({
    Key key,
    this.doc,
    this.last = false,
    this.border = const Border(
      bottom: BorderSide(
        width: 0.25,
        color: Colors.grey,
      ),
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: last ? null : border,
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(right: 8, left: 12),
            child: AppIcon.iconType(doc.type, size: 24),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${doc.title}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.textStyleB,
                ),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                  child: Row(
                    children: [
                      LakeMentionWidget(
                        before: '',
                        showLogin: false,
                        login: doc.user.login,
                        name: doc.user.name,
                        fontSize: 10,
                      ),
                      Text(
                        ' 发布于 ',
                        style: AppStyles.textStyleCC.copyWith(
                          fontSize: 10,
                        ),
                      ),
                      Text('${doc.book.name}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TopicListWidget extends StatelessWidget {
  final List<TopicSeri> topics;

  const _TopicListWidget({
    Key key,
    this.topics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: topics.mapWidget(
          (item) => _TopicTileWidget(topic: item),
          divide: true,
        ),
      ),
    );
  }
}

class _TopicTileWidget extends StatelessWidget {
  final TopicSeri topic;

  _TopicTileWidget({
    Key key,
    this.topic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget ans = Container(
      padding: EdgeInsets.only(left: 16, right: 4),
      alignment: Alignment.centerRight,
      width: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.question_answer, size: 16),
          Text(
            "${topic.commentsCount}",
            style: AppStyles.textStyleCC,
          )
        ],
      ),
    );
    Widget user = Row(
      children: [
        UserAvatarWidget(
          avatar: topic.user.avatarUrl,
          height: 18,
        ),
        SizedBox(width: 4),
        Container(
          child: Text(
            "${topic.user.name} 创建于 ${Util.timeCut(topic.createdAt)}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.textStyleCC,
          ),
        ),
      ],
    );
    Widget child = Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    '${topic.title}',
                    style: AppStyles.textStyleB,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 5),
                user,
              ],
            ),
          ),
          ans,
        ],
      ),
    );
    return GestureDetector(
      onTap: () {
        MyRoute.topic(topic.iid, topic.groupId);
      },
      child: child,
    );
  }
}

class _MemberListWidget extends StatelessWidget {
  final List<GroupUserSeri> members;

  const _MemberListWidget({
    Key key,
    this.members,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 12,
      ),
      child: Container(
        height: 125,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: members.length,
          itemBuilder: (_, i) {
            var member = members[i].user;
            var tag = '${member.id}';
            Widget child = Container(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 8,
              ),
              child: Column(
                children: [
                  Hero(
                    tag: tag,
                    child: UserAvatarWidget(
                      avatar: member.avatarUrl,
                      height: 64,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0, -8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.4),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.fire,
                            size: 12,
                            //TODO(@dreamer2q): 添加颜色映射
                            color: Colors.red.withOpacity(
                              (1 / (i + 1) + 0.4).clamp(0.4, 1).toDouble(),
                            ),
                          ),
                          Text(
                            '${members[i].epv30}',
                            style: AppStyles.textStyleCC,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    '${member.name}',
                    style: AppStyles.textStyleC,
                  ),
                ],
              ),
            );
            return GestureDetector(
              onTap: () {
                MyRoute.user(
                  heroTag: tag,
                  user: member.toUserLiteSeri(),
                );
              },
              child: child,
            );
          },
        ),
      ),
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
