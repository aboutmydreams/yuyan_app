import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';

class AboutYuyan extends StatefulWidget {
  AboutYuyan({Key key}) : super(key: key);

  @override
  _AboutYuyanState createState() => _AboutYuyanState();
}

class _AboutYuyanState extends State<AboutYuyan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: _sliverBuilder,
        body: Container(
          margin: EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "# 写在前面",
                style: AppStyles.textStyleA,
              ),
              Divider(),
              Text(
                "2018年的12月，一连串的问题引起了我的深思「 为什么我们做的这么多的项目都死了？」「 为什么我们还要做曾经失败过的产品？」「 那些藏在Gitlab中的骨灰就不值得我们反思一下吗？」，当时我们在家园内部自建平台「 US 」（当时话题圈子还没有分类），以及···「 百度网盘 」中整理项目组留下的文档。是的，你没有看错，就是你上传了上千百个文件 也难得从上面下载一个到本地来回味一下的百度网盘。上传很快，下载很慢，就像我们做的项目一样，发起很快，完善很慢，也像团队一般，发展很快，沉淀很慢。",
                style: AppStyles.textStyleBC,
              )
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
  return <Widget>[
    SliverAppBar(
      centerTitle: true, //标题居中
      expandedHeight: 200.0, //展开高度200
      // backgroundColor: Colors.tealAccent,
      floating: false, // 不随着滑动隐藏标题
      pinned: false, // 固定
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 0,
              child: Image.asset(
                "assets/images/first.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        title: Text("关于语燕"),
      ),
    )
  ];
}
