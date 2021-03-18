import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/model/document/doc.dart';
import 'package:yuyan_app/model/document/user.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/widget/user_widget.dart';

class DocTileWidget extends StatelessWidget {
  final DocSeri item;

  const DocTileWidget({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildDoc(item);
  }

  buildDoc(DocSeri data) {
    bool hasCover = data.cover != null;
    UserSeri user = data.user ?? data.book.user;
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
            MyRoute.user(user: user.toUserLiteSeri());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UserAvatarWidget(
                avatar: user.avatarUrl,
                height: 22,
              ),
              SizedBox(width: 7),
              Container(
                child: Text(
                  user.name.clip(6, ellipsis: true),
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
