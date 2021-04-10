import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/controller/document/doc_controller.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/widget/drop_menu_item_widget.dart';
import 'package:yuyan_app/views/widget/lake/lake_render_widget.dart';
import 'package:yuyan_app/views/widget/user_widget.dart';

class DocDetailPage extends StatefulWidget {
  final int bookId;
  final String slug;

  const DocDetailPage({
    Key key,
    this.bookId,
    this.slug,
  }) : super(key: key);

  @override
  _DocDetailPageState createState() => _DocDetailPageState();
}

class _DocDetailPageState extends State<DocDetailPage> {
  var title = '文档详情'.obs;
  var webUrl = 'https://www.yuque.com/';

  String get tag => '${widget.bookId}';

  @override
  void initState() {
    super.initState();

    Get.put(
      DocDetailController(bookId: widget.bookId, slug: widget.slug),
      tag: tag,
    );
  }

  @override
  Widget build(BuildContext context) {
    var c = Get.find<DocDetailController>(tag: tag);
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(title.value)),
        elevation: 1,
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                value: () {
                  MyRoute.webview(webUrl);
                },
                child: MenuItemWidget(
                  iconData: Icons.open_in_browser,
                  title: '打开网页版',
                ),
              ),
              // PopupMenuItem(
              //   value: () {
              //     MyRoute.webview(webUrl);
              //   },
              //   child: MenuItemWidget(
              //     iconData: Icons.open_in_browser,
              //     title: '编辑',
              //   ),
              // ),
              PopupMenuItem(
                value: () {
                  MyRoute.webview('https://www.yuque.com/go/doc/${c.value.id}');
                },
                child: MenuItemWidget(
                  iconData: Icons.share,
                  title: '分享',
                ),
              ),
              PopupMenuItem(
                value: () {
                  Util.launchURL(webUrl);
                },
                child: MenuItemWidget(
                  iconData: Icons.open_in_new,
                  title: '其它应用打开',
                ),
              ),
            ],
            onSelected: (_) => _?.call(),
          ),
        ],
      ),
      body: GetBuilder<DocDetailController>(
        tag: tag,
        builder: (c) => c.stateBuilder(
          onIdle: () {
            Future.delayed(Duration(milliseconds: 100), () {
              webUrl = 'https://www.yuque.com/go/doc/${c.value.id}';
              title.value = c.value.title;
            });
            return Scrollbar(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    LakeRenderWidget(
                      data: c.value.content,
                      docId: c.value.id,
                    ),
                    // _buildDocInfo(),
                    // _buildBelongs(),
                    // _buildRecommend(),
                    // _buildComments(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  //文档点赞，点赞人数，
  //修改日期，阅读人数
  Widget _buildDocInfo() {
    var c = Get.find<DocDetailController>(tag: tag);
    var targetId = c.value.id;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 32),
        LikeButton(
          likeCount: c.value.likesCount,
          size: 48,
          onTap: (liked) async {
            var res = await Util.futureWrap(
              ApiRepository.doLike(target: targetId, unlike: liked),
              onData: (_) async => !liked,
              onError: (_) => false,
            );
            var docLike = Get.find<DocLikesController>(tag: tag);
            docLike.onRefresh(force: true);
            return res;
          },
          likeBuilder: (liked) {
            return Icon(
              liked ? Icons.thumb_up : Icons.thumb_up_outlined,
              size: 38,
              color: Colors.yellow,
            );
          },
        ),
        GetBuilder<DocLikesController>(
          init: DocLikesController(targetId),
          global: true,
          tag: tag,
          builder: (c) => c.stateBuilder(
            onEmpty: SizedBox.shrink(),
            onIdle: () => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: c.value.mapWidget(
                  (item) => UserAvatarWidget(
                    avatar: item.avatarUrl,
                    height: 32,
                  ).paddingSymmetric(horizontal: 3),
                ),
              ),
            ),
          ),
        ).paddingSymmetric(vertical: 8, horizontal: 12),
        DefaultTextStyle(
          style: TextStyle(
            color: Colors.grey,
          ),
          child: Wrap(
            children: [
              _label(
                Icons.people,
                c.value.contributors.take(3).map((e) => e.name).join('、') + '等',
              ),
              _label(Icons.access_time, Util.timeCut(c.value.contentUpdatedAt)),
              _label(Icons.menu_book_rounded, c.value.hits),
              _label(Icons.add_comment_outlined, c.value.commentsCount),
            ],
          ).paddingSymmetric(vertical: 8, horizontal: 12),
        ),
        SizedBox(height: 32),
      ],
    );
  }

  //文档的作者，文档的知识库
  Widget _buildBelongs() {
    var c = Get.find<DocDetailController>(tag: tag);
    return Column(
      children: [
        Text('关注作者和知识库后续更新'),
      ],
    );
  }

  //推荐阅读
  Widget _buildRecommend() {
    return SizedBox.shrink();
  }

  //文档的评论
  Widget _buildComments() {
    return SizedBox.shrink();
  }

  Widget _label(IconData icon, dynamic label) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.end,
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        SizedBox(width: 3),
        Text('$label'),
      ],
    ).paddingSymmetric(horizontal: 4);
  }
}
