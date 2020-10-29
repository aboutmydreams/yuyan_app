import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/user/view/view/one_group.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/group/group_data.dart';

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
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "# 语燕是什么",
                  style: AppStyles.textStyleA,
                ),
                Divider(),
                Text(
                  "这是历时一年时间开发，一款「 精美 」「 流畅 」满足文档用户基础需求的移动端产品。采用了过渡性交 互动画，数据预加载，期待能够验证「未来的交互趋势是充分过渡的」的想法，希望你会喜欢。\n",
                  style: AppStyles.textStyleBC,
                ),
                Text(
                  "注：语燕没有恶意，在语雀官方App发布后不保证会继续维护。\n",
                  style: AppStyles.textStyleBBB,
                ),
                SizedBox(height: 10),
                Text(
                  "项目归档的故事",
                  style: AppStyles.textStyleB,
                ),
                SizedBox(height: 10),
                Text(
                  "2018年12月，一连串的问题引起了我的深思「 为什么我们做的这么多的项目都死了？」「 为什么我们还要做曾经失败过的产品？」「 那些藏在 Gitlab 中的骨灰就不值得我们反思一下吗？」，当时我们在家园内部自建平台 US（当时话题圈子还没有分类），以及···「 百度网盘 」中整理项目组留下的文档。是的，你没有看错，就是你上传了上千百个文件 也难得从上面下载一个到本地来回味一下的百度网盘。上传很快，下载很慢，就像我们做的项目一样，发起很快，完善很慢，也像团队一般，发展很快，沉淀很慢。\n\n带着「 为团队找到更好的归档工具 」的使命，在12月12日，一个穷且无心逛淘宝的我……喵的 居然写哭了…… 后面就了然了，答案就是我们选择了「 语雀 」\n",
                  style: AppStyles.textStyleBC,
                ),
                SizedBox(height: 10),
                Text(
                  "园前盼归燕，语末待识君",
                  style: AppStyles.textStyleB,
                ),
                SizedBox(height: 10),
                Text(
                  "语雀对我们团队的影响很大，越来越多的项目文档、复盘被记录在语雀上了，所有人都知道我们在做什么，做到哪了，有什么收获，尽管如今的在语雀上积累并不多，但是我相信在未来这将是团队交口荐誉的财富，而对于那些已经毕业经历世态炎凉的老家园看来，无论那些项目是死是活都可以被拿出来津津乐道，相信当时的他们或未来的我们会喜欢这种回望经历的感觉。\n\n",
                  style: AppStyles.textStyleBC,
                ),
                Text(
                  "# 鸣谢",
                  style: AppStyles.textStyleA,
                ),
                Divider(),
                Text(
                  "Team",
                  style: AppStyles.textStyleB,
                ),
                SizedBox(height: 10),
                oneGroup(
                  context,
                  GroupData(
                    id: 84140,
                    login: "yuque",
                    name: "语雀",
                    description: "与用户一起成长",
                    avatarUrl:
                        "https://cdn.nlark.com/yuque/0/2019/png/84147/1547032500238-d93512f4-db23-442f-b4d8-1d46304f9673.png",
                  ),
                  margin: EdgeInsets.only(bottom: 10),
                ),
                oneGroup(
                  context,
                  GroupData(
                    id: 98619,
                    login: "ncuhome",
                    name: "家园工作室",
                    description: "用不长的四年，做值得一生骄傲的事",
                    avatarUrl:
                        "https://cdn.yuque.com/yuque/0/2018/png/98602/1526020974933-avatar/6dbfeb43-9e23-41b4-967a-3d981936cec6.png",
                  ),
                  margin: EdgeInsets.only(bottom: 10),
                ),
                oneGroup(
                  context,
                  GroupData(
                    id: 671004,
                    login: "vyan",
                    name: "语燕项目组",
                    description: "自缘不睹榴皮字，想像祇园蔓草书",
                    avatarUrl:
                        "https://cdn.nlark.com/yuque/0/2020/png/164272/1581178391840-avatar/dfd33ab4-7115-4fce-b504-faeb9d3ca24d.png",
                  ),
                  margin: EdgeInsets.only(bottom: 20),
                ),
                Text(
                  "一些前辈产品",
                  style: AppStyles.textStyleB,
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    oneProduct(
                      context,
                      text: "Xque",
                      url: "https://github.com/okoala/xque",
                    ),
                    oneProduct(
                      context,
                      text: "滴雀",
                      url: "https://github.com/FEMessage/dique",
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  "开源技术",
                  style: AppStyles.textStyleB,
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Container(
                      child: CachedNetworkImage(
                          height: 20,
                          imageUrl:
                              "https://cdn.jsdelivr.net/gh/flutterchina/website@1.0/images/flutter-mark-square-100.png"),
                    ),
                    Text(
                      " Flutter",
                      style: AppStyles.countStyle,
                    ),
                  ],
                ),
                SizedBox(height: 35),
                Text(
                  "# 其他",
                  style: AppStyles.textStyleA,
                ),
                Divider(),
                Text(
                  "用户反馈",
                  style: AppStyles.textStyleB,
                ),
                SizedBox(height: 10),
                Text(
                  "反馈系统基于团队讨论区是我见过最有趣的设定之一，所以团队都可以使用想语雀一样的反馈方式，是不是很 cool ！",
                  style: AppStyles.textStyleBC,
                ),
                SizedBox(height: 10),
                FlatButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, "/my/suggest");
                  },
                  icon: Icon(
                    Icons.add_comment,
                    color: Colors.white,
                  ),
                  label: Text("点我反馈"),
                  color: AppColors.primary,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
                SizedBox(height: 20),
                Text(
                  "加入一起开发",
                  style: AppStyles.textStyleB,
                ),
                SizedBox(height: 10),
                Text(
                  "如你所见，语燕的设计、开发工作量是庞大的，我们强烈希望有兴趣的设计师/开发者加入我们一起工作，感恩！ 联系开发者: developlove@vip.qq.com",
                  style: AppStyles.textStyleBC,
                ),
                SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
  return <Widget>[
    SliverAppBar(
      centerTitle: true,
      expandedHeight: 200.0,
      pinned: true,
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

Widget oneProduct(context, {String text, String url}) {
  return InkWell(
    child: Container(
      margin: EdgeInsets.only(right: 5, left: 5),
      child: Chip(label: Text(text)),
    ),
    onTap: () {
      openUrl(context, url);
    },
  );
}

bool after1019() {
  return 1603114201000 > DateTime.now().millisecondsSinceEpoch;
}
