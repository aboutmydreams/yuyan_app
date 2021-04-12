import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/model/events/book_event_seri.dart';
import 'package:yuyan_app/model/events/doc_event_seri.dart';
import 'package:yuyan_app/model/events/event_seri.dart';
import 'package:yuyan_app/model/events/user_lite_seri.dart';
import 'package:yuyan_app/config/app_ui.dart';
import 'package:yuyan_app/util/util.dart';

import '../user_widget.dart';

/// 用户、团队等动态组件
/// 例如，发布、更新文档，关注用户，关注知识库等
class AffairTileWidget extends StatelessWidget {
  final EventSeri item;

  const AffairTileWidget(
    this.item, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (item.subjectType) {
      // case "update_doc": //"更新了文档",
      // case "like_doc": //"打赏了稻谷",
      // case "publish_doc": //"发布了文章",
      // case "watch_book": //"关注了知识库",
      // case "follow_user": //"关注了雀友",
      // case "like_artboard": //"给画板赞赏了稻谷",
      // case "upload_artboards": // "更新了画板"
      case 'Doc':
        return _ToDocWidget(item: item);
      case 'Artboard':
        return ListTile(
          title: Text('Artboard event'),
          subtitle: Text('如果你看见这个信息，请记得进行反馈谢谢❤'),
        );
      case 'User':
        return _ToUserWidget(item: item);
      case 'Book':
        return _ToBookWidget(item: item);
      default:
        return ListTile(
          title: Text('Unsupported'),
          subtitle: Text('eventType: ${item.eventType}'),
          onTap: () {
            Util.toast('请联系作者进行反馈！');
          },
        );
    }
  }
}

class _ToUserWidget extends StatelessWidget {
  final EventSeri item;

  const _ToUserWidget({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (item.subjects == null) {
      item.subjects = [item.subject];
    }
    return Container(
      padding: EdgeInsets.only(top: 14, bottom: 20),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(128, 116, 116, 116),
            offset: Offset(0, 0),
            blurRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 18, right: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 44,
                  margin: EdgeInsets.only(right: 3),
                  child: UserActionTileWidget(
                    user: item.actor,
                    actionTime: item.updatedAt,
                    subTitle: item.eventType.transEvent(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 13),
                  decoration: BoxDecoration(
                    color: AppColors.eventBack,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var i in item.subjects)
                        _UserFollowWidget(
                          user: i.serialize<UserLiteSeri>(),
                        ),
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

class _ToDocWidget extends StatelessWidget {
  final EventSeri item;

  const _ToDocWidget({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sub = item.subject?.serialize<DocEventSeri>();
    final sub2 = item.secondSubject?.serialize<BookEventSeri>();
    String title;
    String desc;
    String time;
    if (sub != null) {
      title = sub.title;
      desc = sub.description ?? sub.customDescription;
      time = sub.updatedAt;
    } else {
      title = sub2.name;
      desc = sub2.description;
      time = sub2.updatedAt;
    }

    return GestureDetector(
      onTap: () {
        debugPrint('test $item');
        if (sub != null) {
          MyRoute.docDetailWebview(
            bookId: sub.bookId,
            slug: sub.slug,
            login: sub2.user.login,
            book: sub2.slug,
          );
        } else {
          MyRoute.bookDocs(sub2.toBookSeri());
        }
      },
      child: Container(
        padding: EdgeInsets.only(top: 14, bottom: 20),
        decoration: BoxDecoration(
          color: AppColors.background,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(128, 116, 116, 116),
              offset: Offset(0, 0),
              blurRadius: 1,
            ),
          ],
        ),
        child: Container(
          margin: EdgeInsets.only(left: 18, right: 19),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 44,
                margin: EdgeInsets.only(right: 3),
                child: UserActionTileWidget(
                  user: item.actor,
                  actionTime: time,
                  subTitle: item.eventType.transEvent(),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "$title",
                        textAlign: TextAlign.start,
                        style: AppStyles.textStyleB,
                      ),
                    ),
                    if (!desc.isBlank)
                      Container(
                        margin: EdgeInsets.only(top: 7),
                        child: Text(
                          "$desc",
                          textAlign: TextAlign.start,
                          style: AppStyles.textStyleC,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class _ToArtboardWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(top: 14, bottom: 20),
//       decoration: BoxDecoration(
//         color: AppColors.background,
//         boxShadow: [
//           BoxShadow(
//             color: Color.fromARGB(128, 116, 116, 116),
//             offset: Offset(0, 0),
//             blurRadius: 1,
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             margin: EdgeInsets.only(left: 18, right: 18),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // 动态的头像
//                 Container(
//                   height: 44,
//                   margin: EdgeInsets.only(right: 3),
//                   child: userEvent(
//                     context,
//                     login: data.login,
//                     userImg: data.avatarUrl,
//                     name: data.who,
//                     userId: data.userId,
//                     event: "${data.did}",
//                     time: timeCut(data.when),
//                   ),
//                 ),
//                 // 画板知识库
//                 GestureDetector(
//                   onTap: () {
//                     openUrl(context, data.event[0].url);
//                   },
//                   child: Container(
//                     margin: EdgeInsets.only(top: 4),
//                     child: Chip(
//                       backgroundColor: AppColors.eventBack,
//                       avatar: ClipOval(
//                         child: FadeInImage.assetNetwork(
//                           width: 20,
//                           image: data.event[0].avatarUrl,
//                           placeholder: 'assets/images/explore/book.png',
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       label: Text(
//                         "${data.event[0].title}",
//                         textAlign: TextAlign.center,
//                         style: AppStyles.textStyleBB,
//                       ),
//                     ),
//                   ),
//                 ),
//                 // 更新图片预览
//                 GestureDetector(
//                   onTap: () {
//                     openUrl(
//                         context,
//                         data.event[0].url +
//                             "/" +
//                             data.event[0].bookId.toString());
//                   },
//                   child: Container(
//                     width: MediaQuery.of(context).size.width - 36,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Stack(
//                       children: <Widget>[
//                         Hero(
//                           tag: randomString(5),
//                           child: FadeInImage.assetNetwork(
//                             width: MediaQuery.of(context).size.width - 36,
//                             image: data.event[0].image,
//                             placeholder: 'assets/images/logo.png',
//                             fit: BoxFit.fitWidth,
//                           ),
//                         ),
//                         Positioned(
//                           child: Opacity(
//                             opacity: 0.4,
//                             child: Container(
//                               padding:
//                                   EdgeInsets.only(top: 4, left: 4, right: 4),
//                               decoration: BoxDecoration(
//                                 color: Colors.black,
//                                 borderRadius: BorderRadius.circular(13),
//                               ),
//                               height: 26,
//                               child: Text(
//                                 "共 ${data.event.length} 张",
//                                 style: TextStyle(
//                                     fontSize: 12, color: Colors.white),
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class _UserFollowWidget extends StatelessWidget {
  final UserLiteSeri user;

  const _UserFollowWidget({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String tag = Util.genHeroTag();
    return GestureDetector(
      onTap: () => MyRoute.user(user: user),
      child: Container(
        height: 66,
        child: Row(
          children: [
            SizedBox(width: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(19),
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(128, 116, 116, 116),
                      offset: Offset(0, 0),
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: Hero(
                  tag: tag,
                  child: UserAvatarWidget(
                    avatar: user.avatarUrl,
                    height: 38,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 14),
                  child: Text(
                    "${user.name}",
                    textAlign: TextAlign.center,
                    style: AppStyles.textStyleBB,
                  ),
                ),
                if (!GetUtils.isNullOrBlank(user.description))
                  Container(
                    width: 180,
                    margin: EdgeInsets.only(left: 14, top: 2),
                    child: Text(
                      "${user.description}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.textStyleCC,
                    ),
                  )
              ],
            ),
            Spacer(),
            Container(
              width: 50,
              height: 17,
              margin: EdgeInsets.only(right: 12),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 16,
                      margin: EdgeInsets.only(right: 3),
                      child: Image.asset(
                        "assets/images/explore/fellower.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 3),
                      child: Text(
                        "${user.followersCount}",
                        textAlign: TextAlign.center,
                        style: AppStyles.textStyleCC,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ToBookWidget extends StatelessWidget {
  final EventSeri item;

  const _ToBookWidget({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (item.subjects == null) {
      item.subjects = [item.subject];
      // } else {
      //   debugPrint('test');
    }

    return Container(
      padding: EdgeInsets.only(top: 14, bottom: 20),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(128, 116, 116, 116),
            offset: Offset(0, 0),
            blurRadius: 1,
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.only(left: 18, right: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 44,
              margin: EdgeInsets.only(right: 3),
              child: UserActionTileWidget(
                user: item.actor,
                actionTime: item.updatedAt,
                subTitle: item.eventType.transEvent(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 13),
              decoration: BoxDecoration(
                color: AppColors.eventBack,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i in item.subjects)
                    _DocBookWidget(book: i.serialize<BookEventSeri>()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DocBookWidget extends StatelessWidget {
  final BookEventSeri book;

  const _DocBookWidget({Key key, this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MyRoute.bookDocs(book.toBookSeri());
      },
      child: Container(
        height: 66,
        child: Row(
          children: [
            SizedBox(width: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(19),
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(128, 116, 116, 116),
                      offset: Offset(0, 0),
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: ClipOval(
                  //TODO book_event是否有一个图片字段?
                  child: !GetUtils.isNullOrBlank(null)
                      ? FadeInImage.assetNetwork(
                          image: "",
                          placeholder: 'assets/images/explore/book.png',
                          fit: BoxFit.cover,
                        )
                      : Image.asset('assets/images/explore/book.png'),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 14),
                    child: Text(
                      "${book.name}",
                      textAlign: TextAlign.center,
                      style: AppStyles.textStyleBB,
                    ),
                  ),
                  if (!GetUtils.isNullOrBlank(book.description))
                    Container(
                      width: 180,
                      margin: EdgeInsets.only(left: 14, top: 2),
                      child: Text(
                        "${book.description}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.textStyleCC,
                      ),
                    )
                ],
              ),
            ),
            Container(
              width: 50,
              height: 17,
              margin: EdgeInsets.only(right: 12),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 16,
                      margin: EdgeInsets.only(right: 3),
                      child: Image.asset(
                        "assets/images/explore/fellower.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 3),
                      child: Text(
                        "${book.watchesCount}",
                        textAlign: TextAlign.center,
                        style: AppStyles.textStyleCC,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
