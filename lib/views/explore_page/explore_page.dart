import 'package:flutter/material.dart';
import 'package:yuyan_app/models/widgets_small/toast.dart';
import 'package:yuyan_app/state_manage/toppest.dart';
import 'package:yuyan_app/views/explore_page/search/search_bar.dart';
import 'attention/attention_page.dart';
import 'selection/selection_page.dart';

class ExplorePage extends StatefulWidget {
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarOpacity: 1.0,
          bottomOpacity: 5.0,
          leading: Container(
              height: 35,
              // width: MediaQuery.of(context).size.width - 140,
              child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                items: [
                  DropdownMenuItem(
                    child: Text('同意'),
                    value: '同意',
                  ),
                  DropdownMenuItem(
                    child: Text('拒绝'),
                    value: '拒绝',
                  ),
                ],
                hint: Text('请选择'),
                onChanged: (value) {
                  // setState(() {
                  //   _selectType = value;
                  // });
                },
                isExpanded: true,
                value: "拒绝",
                elevation: 24, //设置阴影的高度
                style: new TextStyle(
                  //设置文本框里面文字的样式
                  color: Colors.blue,
                  fontSize: 12,
                ),
                isDense:
                    false, //减少按钮的高度。默认情况下，此按钮的高度与其菜单项的高度相同。如果isDense为true，则按钮的高度减少约一半。 这个当按钮嵌入添加的容器中时，非常有用
                iconSize: 40.0,
              ))),

          // InkWell(
          //   child: Icon(Icons.access_time),
          //   onTap: () {
          //     myToast(context, topModel.myInfoManage.organizData.data[0].name);
          //   },
          // ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              tooltip: '在语雀中搜索',
              onPressed: () {
                showSearch(context: context, delegate: SearchBarDelegate());
              },
            )
          ],
          elevation: 0.0,
          title: TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white.withOpacity(0.95),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3.0,
            tabs: <Widget>[
              Tab(
                text: "关注",
              ),
              Tab(
                text: "精选",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            GestureDetector(
              onPanDown: (DragDownDetails details) {
                topModel.bottomManage.initd();
              },
              child: Container(
                child: AttentionPage(),
              ),
            ),
            Container(
              child: SelectionPage(),
            ),
          ],
        ),
      ),
    );
  }
}
