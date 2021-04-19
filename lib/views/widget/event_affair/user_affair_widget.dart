import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/model/document/doc.dart';
import 'package:yuyan_app/model/document/user.dart';
import 'package:yuyan_app/model/events/user_event_seri.dart';
import 'package:yuyan_app/config/app_ui.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/widget/user_widget.dart';

/// 用户、团队等动态组件
/// 例如，发布、更新文档，关注用户，关注知识库等
class UserAffairTileWidget extends StatelessWidget {
  final UserEventSeri item;

  UserAffairTileWidget(
    this.item, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (item.targetType) {
      case 'Doc':
        return _ActionTile(
          user: item.actor,
          action: item.type.transEvent(),
          actionTime: item.updatedAt,
          child: _DocTileNoUser(
            item: item.targets.first.serialize<DocSeri>(),
          ),
        );
      default:
        return ListTile(
          title: Text('Unsupported'),
          subtitle: Text('targetType: ${item.targetType}'),
          onTap: () {
            Util.toast('请联系作者进行反馈！');
          },
        );
    }
  }
}

class _ActionTile extends StatelessWidget {
  final Widget child;
  final UserSeri user;
  final String action;
  final String actionTime;

  const _ActionTile({
    Key key,
    this.child,
    this.user,
    this.action,
    this.actionTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4, left: 12, right: 8),
          child: UserActionTileWidget(
            user: user.toUserLiteSeri(),
            subTitle: action,
            actionTime: actionTime,
          ),
        ),
        Container(
          child: child,
        ),
      ],
    );
  }
}

class _DocTileNoUser extends StatelessWidget {
  final DocSeri item;

  const _DocTileNoUser({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildDoc(item);
  }

  buildDoc(DocSeri data) {
    bool hasCover = data.cover != null;
    Widget coverWidget;
    if (hasCover) {
      coverWidget = ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 90,
            maxHeight: 90,
          ),
          child: CachedNetworkImage(
            imageUrl: data.cover,
            placeholder: (context, url) => Container(
              color: AppColors.background,
            ), // Colors.white10,
            errorWidget: (context, url, error) => Icon(Icons.error),
            // fit: BoxFit.cover,
          ),
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
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            data.description ?? data.customDescription ?? '',
            maxLines: 3,
            style: AppStyles.textStyleCC,
          ),
        ),
      ],
    );
    if (hasCover) {
      child = Row(
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
        MyRoute.docDetail(
          bookId: data.bookId,
          slug: data.slug,
          book: data.book.slug,
          login: data.user.login,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.withOpacity(0.3),
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
