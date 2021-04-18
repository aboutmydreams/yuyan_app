import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/app.dart';
import 'package:yuyan_app/config/app_ui.dart';
import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/controller/document/doc_controller.dart';
import 'package:yuyan_app/controller/topic/topic_controller.dart';
import 'package:yuyan_app/model/document/commen/comment_detail.dart';
import 'package:yuyan_app/models/widgets_small/show_dialog/show_confirm.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/topic_page/topic_detail_page.dart';

class DocCommentsWidget extends StatefulWidget {
  final String tag;
  final ScrollController scrollController;

  DocCommentsWidget({
    Key key,
    @required this.tag,
    @required this.scrollController,
  }) : super(key: key);

  @override
  _DocCommentsWidgetState createState() => _DocCommentsWidgetState();
}

class _DocCommentsWidgetState extends State<DocCommentsWidget> {
  final _editController = TextEditingController();

  void _onReplyTo(DocCommentsController c, CommentDetailSeri data) {
    var postController = Get.find<CommentPostController>(tag: widget.tag);
    Get.bottomSheet(
      ReplyBottomSheetWidget(
        replyTo: data.id,
        hintText: '回复：${data.user.name}',
        postController: postController,
        editingController: _editController,
      ),
    ).then((value) {
      c.onRefresh();
      Future.delayed(Duration(milliseconds: 10), () {
        Get.focusScope.unfocus();
      });
    });
  }

  void _onDeleteComment(DocCommentsController c, CommentDetailSeri data) {
    if (data.userId == App.userProvider.data.id) {
      showConfirmDialog(
        context,
        content: '删除这条评论吗?',
        confirmCallback: () {
          Util.futureWrap(
            ApiRepository.deleteComment(data.id),
            onData: (data) {
              c.onRefresh();
              Util.toast('删除成功');
            },
            onError: (err) {
              Util.toast('删除失败: $err');
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GetBuilder<DocCommentsController>(
        tag: widget.tag,
        builder: (c) => Container(
          margin: EdgeInsets.only(top: 8),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 16,
                    bottom: 4,
                  ),
                  child: Text(
                    "评论",
                    style: AppStyles.textStyleBp,
                  ),
                ),
              ),
              Positioned(
                top: 32,
                left: 0,
                right: 0,
                bottom: 70,
                child: c.stateBuilder(
                  onIdle: () => Scrollbar(
                    child: ListView(
                      physics: ClampingScrollPhysics(),
                      controller: widget.scrollController,
                      children: c.comments.mapWidget(
                        (data) => CommentDetailItemWidget(
                          key: Key('comment-${data.id}'),
                          current: data,
                          comments: c.comments,
                          onTap: () => _onReplyTo(c, data),
                          onLongPressed: () => _onDeleteComment(c, data),
                        ),
                      ),
                      // itemCount: c.comments.length,
                      // itemBuilder: (BuildContext context, int index) {
                      //   var data = c.comments[index];
                      //   return CommentDetailItemWidget(
                      //     key: Key('comment-$index'),
                      //     current: data,
                      //     comments: c.comments,
                      //     onTap: () => _onReplyTo(c, data),
                      //     onLongPressed: () => _onDeleteComment(c, data),
                      //   );
                      // },
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _buildCommentEditor(c),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCommentEditor(DocCommentsController c) {
    return GetBuilder<CommentPostController>(
      tag: widget.tag,
      init: CommentPostController(c.commentableId, commentType: 'Doc'),
      builder: (comment) => Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
                child: CommentTextField(
                  maxLines: null,
                  controller: _editController,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 12),
              child: ElevatedButton(
                onPressed: () {
                  if (_editController.text.trim() == '') {
                    Util.toast('说点什么呢？');
                    return;
                  }
                  comment.postComment(
                    comment: _editController.text,
                    success: () {
                      Util.toast('发布成功');
                      c.onRefresh();
                      _editController.text = '';
                      Get.focusScope.unfocus();
                    },
                    error: () {
                      Util.toast('失败了，发生什么了呢？');
                    },
                  );
                },
                child: Text(
                  "发表",
                  style: TextStyle(
                    fontFamily: "sans_bold",
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ReplyBottomSheetWidget extends StatelessWidget {
  final String hintText;
  final int replyTo;
  final CommentPostController postController;
  final TextEditingController editingController;

  const ReplyBottomSheetWidget({
    Key key,
    this.replyTo,
    this.hintText = '评论千万条，友善第一条',
    @required this.postController,
    @required this.editingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor.withOpacity(0.9),
        borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 8),
          CommentTextField(
            hintText: hintText,
            controller: editingController,
            autoFocus: true,
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.centerRight,
            child: _buildCommentButton(),
          ),
        ],
      ),
    );
  }

  _buildCommentButton() {
    return GetBuilder<CommentPostController>(
      init: postController,
      autoRemove: false,
      global: false,
      builder: (c) {
        if (c.isLoadingState) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoActivityIndicator(),
          );
        }
        return TextButton(
          onPressed: () {
            if (editingController.text.trim() == '') {
              Util.toast('😶 你要说什么呢？');
              return;
            }
            c.postComment(
              parentId: replyTo,
              comment: editingController.text,
              success: () {
                editingController.text = '';
                if (Get.isBottomSheetOpen) {
                  Get.back();
                }
                if (Get.focusScope.hasFocus) {
                  Get.focusScope.unfocus();
                }
                Util.toast('🎉 成功');
              },
              error: () {
                Util.toast('💔 失败');
              },
            );
          },
          child: Text(
            replyTo != null ? '回复' : '评论',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        );
      },
    );
  }
}

class CommentTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FocusNode focusNode;
  final int maxLines;
  final bool autoFocus;

  CommentTextField({
    Key key,
    this.hintText = "说点什么吧⋯⋯",
    this.controller,
    this.focusNode,
    this.autoFocus = false,
    this.maxLines = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      maxLines: maxLines,
      autofocus: autoFocus,
      // 是否自动更正
      autocorrect: true,
      // 是否自动对焦
      // autofocus: autofocus,
      focusNode: focusNode,
      decoration: InputDecoration(
        // labelText: "标 题",
        // labelStyle: TextStyle(textBaseline: TextBaseline.alphabetic),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        contentPadding: EdgeInsets.all(15.0),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.black26,
          fontSize: 16,
        ),
      ),
      // 输入样式
      style: AppStyles.textStyleBBB,
    );
  }
}
