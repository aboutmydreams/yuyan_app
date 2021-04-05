import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/controller/global/my_controller.dart';
import 'package:yuyan_app/controller/global/user_controller.dart';
import 'package:yuyan_app/model/document/note/note.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/widget/drop_menu_item_widget.dart';
import 'package:yuyan_app/views/widget/lake/lake_render_widget.dart';

class SmallNotePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarOpacity: 1.0,
        bottomOpacity: 5.0,
        elevation: 1,
        title: Text("小记"),
      ),
      floatingActionButton: GestureDetector(
        child: FloatingActionButton(
          onPressed: () {
            Get.toNamed(RouteName.editNote);
          },
          child: Icon(Icons.add),
        ),
      ),
      body: GetBuilder<MyNoteController>(
        init: MyNoteController(),
        builder: (c) => c.builder(
          (state) => SmartRefresher(
            controller: c.refreshController,
            onRefresh: c.onRefreshCallback,
            onLoading: c.onLoadMoreCallback,
            enablePullUp: true,
            child: ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (_, i) {
                return _NoteItemWidget(
                  key: Key('${state.data[i].id}'),
                  item: state.data[i],
                );
              },
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}

class _NoteItemWidget extends StatelessWidget {
  final NoteSeri item;

  const _NoteItemWidget({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      padding: EdgeInsets.only(bottom: 14, left: 8, right: 8),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(25, 0, 0, 0),
            offset: Offset(1, 2),
            blurRadius: 2,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: _buildNoteContent(item),
    );
  }

  _buildNoteContent(NoteSeri item) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              Util.timeCut(item.updatedAt),
              style: TextStyle(
                color: Colors.grey.withOpacity(0.5),
              ),
            ),
            Spacer(),
            PopupMenuButton(
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: () {
                    BotToast.showText(text: '敬请期待');
                  },
                  child: MenuItemWidget(
                    iconData: Icons.edit,
                    title: '编辑',
                  ),
                ),
                PopupMenuItem(
                  value: () {
                    // MyRoute.webview(webUrl);
                    ApiRepository.deleteNote(item.id).then((_) {
                      if (_) {
                        MyNoteController.to.remove(item);
                        BotToast.showText(text: '成功');
                      }
                    }).catchError((e) {
                      BotToast.showText(text: '失败');
                    });
                  },
                  child: MenuItemWidget(
                    iconData: Icons.delete,
                    title: '删除',
                  ),
                ),
              ],
              onSelected: (_) => _?.call(),
            ),
          ],
        ),
        LakeRenderWidget(
          data: item.description,
          docId: item.id,
        ),
        if (item.description.endsWith('<!-- note-viewmore -->'))
          FlatButton(
            onPressed: () {
              debugPrint('查看全部');
              Get.to(
                MyNoteDetailPage(),
                binding: BindingsBuilder.put(
                  () => NoteDetailController(item.id),
                ),
              );
            },
            child: Text('查看全部'),
          ),
      ],
    );
  }
}

class MyNoteDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('小记详情'),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<NoteDetailController>(
          builder: (c) => c.stateBuilder(
            onIdle: () => LakeRenderWidget(
              data: c.value.doclet.bodyAsl,
              docId: c.value.docletId,
            ),
          ),
        ),
      ),
    );
  }
}
