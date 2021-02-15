// import 'dart:convert';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';
// import 'package:http/http.dart' as http;
// import 'package:async/async.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:zefyr/zefyr.dart';

// class EditImagePicker extends StatefulWidget {
//   EditImagePicker({
//     Key key,
//     @required this.controller,
//     @required this.icon,
//   }) : super(key: key);
//   final ZefyrController controller;
//   final IconData icon;

//   @override
//   _EditImagePickerState createState() =>
//       _EditImagePickerState(icon: icon, controller: controller);
// }

// class _EditImagePickerState extends State<EditImagePicker> {
//   _EditImagePickerState({
//     @required this.controller,
//     @required this.icon,
//   });

//   final ZefyrController controller;
//   final IconData icon;
//   final ImagePicker picker = ImagePicker();

//   final String server =
//       "https://www.yuque.com/api/upload/attach?attachable_type=Doclet&attachable_id=11284189&type=image&ctoken=F4Qpbp5qRqctxlDs9uee9gvM";

//   Future<String> upload(File imageFile) async {
//     // open a bytestream
//     var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
//     // get file length
//     var length = await imageFile.length();

//     // string to uri
//     var uri = Uri.parse(server + "/upload");

//     // create multipart request
//     var request = http.MultipartRequest("POST", uri);

//     // multipart that takes file
//     var multipartFile = http.MultipartFile('note', stream, length,
//         filename: basename(imageFile.path));

//     // add file to multipart
//     request.files.add(multipartFile);

//     // send
//     var response = await request.send();
//     // listen for response.join()
//     return response.stream.transform(utf8.decoder).join();
//   }

//   Future<String> pickImage(ImageSource source) async {
//     final file = await picker.getImage(source: source, imageQuality: 65);

//     // final file = await ImagePicker.pickImage(source: source, imageQuality: 65);
//     // if (file == null) return null;
//     // String value = await upload(File(file.path));
//     // var v = jsonDecode(value);
//     // var url = server + "/" + v["data"]["filepath"];
//     // print(url);
//     // return url;
//     return "http://img.alicdn.com/imgextra/i1/6000000003634/O1CN01XkL17h1ciPvkUalkW_!!6000000003634-2-octopus.png";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ZIconButton(
//       highlightElevation: 0,
//       hoverElevation: 0,
//       size: 32,
//       icon: Icon(
//         icon,
//         size: 18,
//         color: Theme.of(context).iconTheme.color,
//       ),
//       fillColor: Theme.of(context).canvasColor,
//       onPressed: () async {
//         final index = controller.selection.baseOffset;
//         final length = controller.selection.extentOffset - index;
//         // ImageSource gallerySource = ImageSource.gallery;
//         // controller.replaceText(
//         //   index,
//         //   length,
//         //   BlockEmbed.image(
//         //     "https://img.alicdn.com/imgextra/i1/6000000003634/O1CN01XkL17h1ciPvkUalkW_!!6000000003634-2-octopus.png",
//         //   ),
//         // );
//         print("index========$index");
//         print("length======$length");

//         final image = pickImage(ImageSource.gallery);
//         await image.then((value) {
//           controller.document.insert(index, BlockEmbed(value));
//           controller.document.insert(index, BlockEmbed('\n'));
//         });
//         setState(() {});
//       },
//     );
//   }
// }
