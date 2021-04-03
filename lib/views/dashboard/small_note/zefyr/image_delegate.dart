// import 'dart:io';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flare_flutter/flare_actor.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:yuyan_app/config/service/api_repository.dart';
// import 'package:yuyan_app/controller/global/upload_controller.dart';
// import 'package:zefyr/zefyr.dart';
//
// class NoteImageDelegate implements ZefyrImageDelegate<ImageSource> {
//   final int attachId;
//
//   NoteImageDelegate(this.attachId);
//
//   @override
//   ImageSource get cameraSource => ImageSource.camera;
//
//   @override
//   ImageSource get gallerySource => ImageSource.gallery;
//
//   @override
//   Future<String> pickImage(ImageSource source) async {
//     final picker = ImagePicker();
//     final file = await picker.getImage(source: source);
//     if (file == null) return null;
//     // var imgUrl = await DioReq.uploadImage(
//     //   file.path,
//     //   'Doclet',
//     //   topModel.noteManage.noteData.meta.mirror.id,
//     // );
//     // return imgUrl;
//     var res = await ApiRepository.postNoteImage(
//       path: file.path,
//       attachableType: 'Doclet',
//       attachableId: attachId,
//     );
//
//     // Get.lazyPut(() => ImageUploadController(file.path, attachId),
//     //     tag: '${file.path}');
//     // return file.path;
//     return res.url;
//   }
//
//   @override
//   Widget buildImage(BuildContext context, String imgUrl) {
//     // We use custom "asset" scheme to distinguish asset images from other files.
//     // print(imgUrl);
//
//     // return ImageUploaderWidget(
//     //   asset: imgUrl,
//     //   attachId: attachId,
//     // );
//
//     if (imgUrl.startsWith('http')) {
//       // Otherwise assume this is a file stored locally on user's device.
//       return CachedNetworkImage(
//         imageUrl: imgUrl,
//         placeholder: (context, url) => FlareActor(
//           "assets/flares/progress.flr",
//           animation: "active",
//         ),
//         errorWidget: (context, url, error) => Icon(Icons.error),
//         fit: BoxFit.cover,
//       );
//     } else if (imgUrl.startsWith('asset')) {
//       return Image.asset(imgUrl);
//     } else {
//       final file = File.fromUri(Uri.parse(imgUrl));
//
//       final image = FileImage(file);
//       return Image(image: image);
//     }
//   }
// }
//
// class ImageUploaderWidget extends StatelessWidget {
//   final String asset;
//   final int attachId;
//
//   ImageUploaderWidget({
//     Key key,
//     this.asset,
//     this.attachId,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ImageUploadController>(
//       tag: asset,
//       builder: (c) {
//         var file = File.fromUri(Uri.parse(asset));
//         Widget child = Image(
//           image: FileImage(file),
//           fit: BoxFit.contain,
//         );
//         if (c.isRefreshState || c.isLoadingState) {
//           child = _wrap(
//             child,
//             Obx(() => Text('${(c.progress * 100).toStringAsFixed(0)} %')),
//           );
//         } else if (c.isErrorState) {
//           child = _wrap(
//             child,
//             Text('error: ${c.error.title}'),
//           );
//         }
//         return child;
//       },
//     );
//   }
//
//   Widget _wrap(Widget first, Widget second) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         first,
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.grey.withOpacity(0.3),
//           ),
//           child: second,
//         ),
//       ],
//     );
//   }
// }
