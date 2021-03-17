import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/controller/explore_controller.dart';
import 'package:yuyan_app/model/document/doc.dart';
import 'package:yuyan_app/model/serializer/serializer.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/widget/user_widget.dart';

class SelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: GetBuilder<ExploreRecommendController>(
        builder: (controller) {
          return controller.builder(
            (state) {
              var data = state.data;
              return SmartRefresher(
                controller: controller.refreshController,
                onRefresh: controller.onRefreshCallback,
                onLoading: controller.onLoadMoreCallback,
                enablePullUp: true,
                child: ListView.builder(
                  itemCount: data.length + 1,
                  itemBuilder: (context, index) {
                    if (index.isEqual(0)) {
                      return GetBuilder<ExploreSelectionController>(
                        builder: (_) => _.builder(
                          (state) => _ExploreBannerWidget(
                            data: state.data,
                          ),
                        ),
                      );
                    }
                    return _RecommendItemWidget(item: data[index - 1]);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _RecommendItemWidget extends StatelessWidget {
  //Doc, Book, User
  final Serializer item;

  const _RecommendItemWidget({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (item.serializer) {
      case 'web.doc':
        return buildDoc(item.serialize<DocSeri>());
      case 'web.book':
        return SizedBox.shrink();
        return Text('book');
      case 'web.user':
        return SizedBox.shrink();
        return Text('user');
      default:
        return Text('default');
    }
  }

  buildDoc(DocSeri data) {
    bool hasCover = data.cover != null;
    Widget coverWidget;
    Widget descWidget;
    if (hasCover) {
      coverWidget = ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 148,
          height: 90,
          child: CachedNetworkImage(
            imageUrl: data.cover,
            placeholder: (context, url) => Container(
              color: AppColors.background,
            ), // Colors.white10,
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      descWidget = Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          data.description ?? data.customDescription ?? '',
          maxLines: 3,
          style: AppStyles.textStyleCC,
        ),
      );
    }
    Widget child = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          data.title,
          maxLines: hasCover ? 4 : 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: AppStyles.textStyleBB,
        ),
        if (!hasCover) descWidget,
        Spacer(),
        GestureDetector(
          onTap: () {
            MyRoute.user(user: data.user.toUserLiteSeri());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UserAvatarWidget(
                avatar: data.user.avatarUrl,
                height: 22,
              ),
              SizedBox(width: 7),
              Container(
                child: Text(
                  data.user.name.clip(6, ellipsis: true),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.textStyleCC,
                ),
              ),
              Spacer(),
              Container(
                width: 21,
                height: 21,
                margin: EdgeInsets.only(right: 5),
                child: SvgPicture.asset(
                  "assets/images/paddy.svg",
                  semanticsLabel: 'paddy',
                ),
              ),
              Text(
                "${data.likesCount * 7}",
                textAlign: TextAlign.left,
                style: AppStyles.textStyleCC,
              )
            ],
          ),
        ),
      ],
    );
    if (hasCover) {
      child = Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          coverWidget,
          SizedBox(width: 12),
          Expanded(
            child: child,
          ),
        ],
      );
    }
    return GestureDetector(
      onTap: () {
        MyRoute.docDetail(bookId: data.bookId, slug: data.slug);
      },
      child: Container(
        height: 134,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.withOpacity(0.1),
              width: 0.5,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: child,
      ),
    );
  }
}

class _ExploreBannerWidget extends StatefulWidget {
  final List<DocSeri> data;

  _ExploreBannerWidget({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  __ExploreBannerWidgetState createState() => __ExploreBannerWidgetState();
}

class __ExploreBannerWidgetState extends State<_ExploreBannerWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NotificationListener(
      onNotification: (_) => true,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        height: 220,
        child: Swiper(
          itemCount: widget.data.length,
          itemBuilder: (context, index) {
            var item = widget.data[index];
            return buildItem(item);
          },
          controller: SwiperController(),
          autoplay: true,
        ),
      ),
    );
  }

  Widget buildItem(DocSeri data) {
    var imageUrl = data.cover;
    // Util.ossImg(data.cover);
    return GestureDetector(
      onTap: () {
        MyRoute.docDetail(bookId: data.bookId, slug: data.slug);
      },
      child: Container(
        height: 216,
        margin: EdgeInsets.only(left: 18, top: 9, right: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                height: 164,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) => Container(
                    width: 147,
                    height: 91,
                    color: AppColors.background,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Spacer(),
            Container(
              height: 46,
              child: UserTileWidget(
                user: data.user,
                title: '${data.title}',
                subTitle: '${data.user.name} 发布于 ${data.book.name}',
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
