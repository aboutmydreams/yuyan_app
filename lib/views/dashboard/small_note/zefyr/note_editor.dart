// import 'package:bot_toast/bot_toast.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:notus/convert.dart';
// import 'package:yuyan_app/config/service/api_repository.dart';
// import 'package:yuyan_app/controller/global/upload_controller.dart';
// import 'package:yuyan_app/models/widgets_small/loading.dart';
// import 'package:yuyan_app/views/widget/lake_image_widget.dart';
//
// import 'package:zefyr/zefyr.dart';
// import 'package:quill_delta/quill_delta.dart';
//
// part 'image_handler.dart';
//
// class NoteEditorPage extends StatefulWidget {
//   @override
//   _NoteEditorPageState createState() => _NoteEditorPageState();
// }
//
// class _NoteEditorPageState extends State<NoteEditorPage> {
//   ZefyrController _zefyrController;
//   FocusNode _focusNode;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _zefyrController = ZefyrController(
//       NotusDocument.fromDelta(Delta()..insert('\n')),
//     );
//
//     _zefyrController.document.changes.listen((event) {
//       debugPrint('${event.source} => ${event.change}');
//     });
//
//     _focusNode = FocusNode();
//
//     Get.put(NoteStatusController());
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//
//     _focusNode.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final loading = Scaffold(appBar: AppBar(title: Text('小记')));
//     final toolbar = ZefyrToolbar(
//       children: [
//         ToggleStyleButton(
//           attribute: NotusAttribute.bold,
//           icon: Icons.format_bold,
//           controller: _zefyrController,
//         ),
//         SizedBox(width: 1),
//         ToggleStyleButton(
//           attribute: NotusAttribute.italic,
//           icon: Icons.format_italic,
//           controller: _zefyrController,
//         ),
//         VerticalDivider(
//           indent: 16,
//           endIndent: 16,
//           color: Colors.grey.shade400,
//         ),
//         SelectHeadingStyleButton(
//           controller: _zefyrController,
//         ),
//         VerticalDivider(
//           indent: 16,
//           endIndent: 16,
//           color: Colors.grey.shade400,
//         ),
//         ToggleStyleButton(
//           attribute: NotusAttribute.block.numberList,
//           controller: _zefyrController,
//           icon: Icons.format_list_numbered,
//         ),
//         ToggleStyleButton(
//           attribute: NotusAttribute.block.bulletList,
//           controller: _zefyrController,
//           icon: Icons.format_list_bulleted,
//         ),
//         VerticalDivider(
//           indent: 16,
//           endIndent: 16,
//           color: Colors.grey.shade400,
//         ),
//         ToggleStyleButton(
//           attribute: NotusAttribute.block.quote,
//           controller: _zefyrController,
//           icon: Icons.format_quote,
//         ),
//         CustomInsertImageButton(
//           controller: _zefyrController,
//           icon: Icons.image,
//         ),
//       ],
//     );
//
//     return GetBuilder<NoteStatusController>(
//       builder: (c) => c.stateBuilder(
//         onLoading: loading,
//         onIdle: () {
//           return Scaffold(
//             appBar: AppBar(
//               title: Text('小记'),
//               actions: [
//                 _publish(c.value.mirror.id),
//               ],
//               bottom: PreferredSize(
//                 preferredSize: Size.fromHeight(45),
//                 child: toolbar,
//               ),
//             ),
//             body: ZefyrEditor(
//               controller: _zefyrController,
//               focusNode: _focusNode,
//               autofocus: true,
//               onLaunchUrl: (url) {
//                 debugPrint('url launch wanted => $url');
//               },
//               embedBuilder: _customZefyrBuilder,
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _publish(int mirrorId) {
//     return GetBuilder<PostNoteController>(
//       init: PostNoteController(mirrorId),
//       builder: (pub) {
//         if (pub.isLoadingState) return ViewLoadingWidget();
//         return FlatButton.icon(
//           onPressed: () async {
//             // debugPrint('发布');
//             // var delta = _zefyrController.document.toDelta();
//             // var res = await pub.postNote(delta);
//             // BotToast.showText(text: res ? '发布成功' : '发布失败');
//             // if (res) Get.back();
//           },
//           icon: Icon(
//             Icons.send_sharp,
//             color: Colors.white,
//           ),
//           label: Text(
//             '发布',
//             style: Get.theme.primaryTextTheme.bodyText1,
//           ),
//         );
//       },
//     );
//   }
// }
