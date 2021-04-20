import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shifting_tabbar/shifting_tabbar.dart';
import 'package:yuyan_app/config/viewstate/view_page.dart';
import 'package:yuyan_app/controller/global/search_controller.dart';
import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/model/document/doc.dart';
import 'package:yuyan_app/model/user/group/group.dart';
import 'package:yuyan_app/model/user/user_lite_seri.dart';
import 'package:yuyan_app/model/topic/topic.dart';
import 'package:yuyan_app/views/explore_page/widget/book_tile_widget.dart';
import 'package:yuyan_app/views/explore_page/widget/doc_tile_widget.dart';
import 'package:yuyan_app/views/topic_page/topic_item_widget.dart';
import 'package:yuyan_app/views/widget/group_widget.dart';
import 'package:yuyan_app/views/widget/user_widget.dart';

class SearchResultWidget extends StatefulWidget {
  final String query;
  final RxInt initIndex;

  const SearchResultWidget({
    Key key,
    this.query,
    this.initIndex,
  }) : super(key: key);

  @override
  _SearchResultWidgetState createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends State<SearchResultWidget>
    with SingleTickerProviderStateMixin {
  final Map tabs = {
    'doc': '文档',
    'book': '知识库',
    'topic': '讨论',
    'group': '团队',
    'user': '用户',
  };
  final Map tabIcons = {
    "doc": Icons.description,
    "book": Icons.book,
    "topic": Icons.comment,
    "group": Icons.supervised_user_circle,
    "user": Icons.person,
  };

  List<ShiftingTab> _buildTabs() {
    return tabs.keys.map((e) {
      return ShiftingTab(
        icon: Icon(
          tabIcons[e],
        ),
        text: tabs[e],
      );
    }).toList();
  }

  TabController _tabController;

  initState() {
    super.initState();

    /// doc, book , topic, group, user,
    /// attachment, resource, note, content, edison
    var query = widget.query;
    tabs.keys.forEach((type) {
      Get.lazyPut(
        () => SearchController(
          type: type,
        )..doSearch(query),
        tag: '$type+$query',
      );
    });

    _tabController = TabController(
      initialIndex: widget.initIndex.value,
      length: tabIcons.length,
      vsync: this,
    );

    _tabController.addListener(() {
      debugPrint('new index => ${_tabController.index}');
      widget.initIndex.value = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShiftingTabBar(
        color: Theme.of(context).scaffoldBackgroundColor,
        controller: _tabController,
        tabs: _buildTabs(),
      ),
      body: Container(
        child: TabBarView(
          controller: _tabController,
          children: _buildTabView(),
        ),
      ),
    );
  }

  List<Widget> _buildTabView() {
    var query = widget.query;
    return [
      //文档
      FetchRefreshListViewBuilder<SearchController>(
        tag: 'doc+' + query,
        builder: (c) {
          var data = c.hits;
          return ListView.builder(
            key: PageStorageKey('doc'),
            itemCount: data.length,
            itemBuilder: (_, i) {
              var item = data[i].record.serialize<DocSeri>();
              return DocTileWidget(item: item);
            },
          );
        },
      ),
      //知识库
      FetchRefreshListViewBuilder<SearchController>(
        tag: 'book+' + query,
        builder: (c) {
          var data = c.hits;
          return ListView.builder(
            key: PageStorageKey('book'),
            itemCount: data.length,
            itemBuilder: (_, i) {
              var item = data[i].record.serialize<BookSeri>();
              return BookTileWidget(item: item);
            },
          );
        },
      ),
      //话题
      FetchRefreshListViewBuilder<SearchController>(
        tag: 'topic+' + query,
        builder: (c) {
          var data = c.hits;
          return ListView.builder(
            key: PageStorageKey('topic'),
            itemCount: data.length,
            itemBuilder: (_, i) {
              var item = data[i].record.serialize<TopicSeri>();
              return TopicRowItemWidget(data: item);
            },
          );
        },
      ),
      //组织
      FetchRefreshListViewBuilder<SearchController>(
        tag: 'group+' + query,
        builder: (c) {
          var data = c.hits;
          return ListView.builder(
            key: PageStorageKey('group'),
            itemCount: data.length,
            itemBuilder: (_, i) {
              var item = data[i].record.serialize<GroupSeri>();
              return GroupTileWidget(group: item);
            },
          );
        },
      ),
      //用户
      FetchRefreshListViewBuilder<SearchController>(
        tag: 'user+' + query,
        builder: (c) {
          var data = c.hits;
          return ListView.builder(
            key: PageStorageKey('user'),
            itemCount: data.length,
            itemBuilder: (_, i) {
              var item = data[i].record.serialize<UserLiteSeri>();
              return UserTileWidget(user: item);
            },
          );
        },
      ),
    ];
  }
}
