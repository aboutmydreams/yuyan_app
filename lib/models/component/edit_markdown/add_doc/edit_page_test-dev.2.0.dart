// // https://juejin.cn/post/6883682688784564231#comment
// // import 'package:flutter/material.dart';
// // import 'package:quill_delta/quill_delta.dart';
// // import 'package:zefyr/zefyr.dart';
// // import 'package:notus/convert.dart';
// // import 'dart:convert';
// // import 'package:image_picker/image_picker.dart';
// // import 'dart:io';

// // class EditorPage extends StatefulWidget {
// //   @override
// //   EditorPageState createState() => EditorPageState();
// // }

// // class EditorPageState extends State<EditorPage> {
// //   /// Allows to control the editor and the document.
// //   ZefyrController _controller;

// //   /// Zefyr editor like any other input field requires a focus node.
// //   FocusNode _focusNode;

// //   @override
// //   void initState() {
// //     super.initState();
// //     // Here we must load the document and pass it to Zefyr controller.
// //     final document = _loadDocument();
// //     _controller = ZefyrController(document);
// //     _focusNode = FocusNode();
// //   }

// //   void _saveDocument(BuildContext context) {
// //     // Notus documents can be easily serialized to JSON by passing to
// //     // `jsonEncode` directly
// //     final contents = jsonEncode(_controller.document);
// //     // For this example we save our document to a temporary file.
// //     // final file = File(Directory.systemTemp.path + "/quick_start.json");
// //     // // And show a snack bar on success.
// //     // file.writeAsString(contents).then((_) {
// //     //   Scaffold.of(context).showSnackBar(SnackBar(content: Text("Saved.")));
// //     // });
// //     String markdown = notusMarkdown.encode(_controller.document.toDelta());
// //     print(markdown);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     // Note that the editor requires special `ZefyrScaffold` widget to be
// //     // one of its parents.
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Editor page"),
// //         actions: [
// //           FlatButton.icon(
// //             onPressed: () {
// //               _saveDocument(context);
// //             },
// //             icon: Icon(
// //               Icons.add_comment,
// //               color: Colors.white,
// //             ),
// //             label: Text("点我反馈"),
// //             // color: AppColors.primary,
// //             textColor: Colors.white,
// //             shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(20.0)),
// //           ),
// //         ],
// //       ),
// //       body: SingleChildScrollView(
// //         child: Column(
// //           children: [
// //             Container(
// //               height: 200,
// //               child: ZefyrScaffold(
// //                 child: ZefyrEditor(
// //                   padding: EdgeInsets.all(16),
// //                   controller: _controller,
// //                   focusNode: _focusNode,
// //                   imageDelegate: MyImageDelegate(),
// //                 ),
// //               ),
// //             ),

// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   /// Loads the document to be edited in Zefyr.
// //   NotusDocument _loadDocument() {
// //     // For simplicity we hardcode a simple document with one line of text
// //     // saying "Zefyr Quick Start".
// //     // (Note that delta must always end with newline.)
// //     final Delta delta = Delta()..insert("Zefyr Quick Start\n");
// //     return NotusDocument.fromDelta(delta);
// //   }
// // }

// // class MyImageDelegate implements ZefyrImageDelegate<ImageSource> {
// //   final storage;
// //   MyImageDelegate(this.storage);

// //   @override
// //   Future<String> pickImage(ImageSource source) async {
// //     final picker = ImagePicker();
// //     final file = await picker.getImage(source: source);

// //     // Future getImage() async {
// //     //   final pickedFile = await picker.getImage(source: ImageSource.camera);

// //     //   setState(() {
// //     //     if (pickedFile != null) {
// //     //       _image = File(pickedFile.path);
// //     //     } else {
// //     //       print('No image selected.');
// //     //     }
// //     //   });
// //     // }
// //     if (file == null) return null;
// //     // Use my storage service to upload selected file. The uploadImage method
// //     // returns unique ID of newly uploaded image on my server.
// //     // final String imageId = await storage.uploadImage(file);
// //     return "3";
// //   }

// //   @override
// //   Widget buildImage(BuildContext context, String key) {
// //     final file = File.fromUri(Uri.parse(key));

// //     /// Create standard [FileImage] provider. If [key] was an HTTP link
// //     /// we could use [NetworkImage] instead.
// //     final image = FileImage(file);
// //     return Image(image: image);
// //   }

// //   @override
// //   ImageSource get cameraSource => ImageSource.camera;

// //   @override
// //   ImageSource get gallerySource => ImageSource.gallery;
// // }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:quill_delta/quill_delta.dart';
// import 'package:yuyan_app/models/component/edit_markdown/view/image_picker.dart';
// import 'package:zefyr/zefyr.dart';
// import 'package:notus/convert.dart';
// import 'package:path/path.dart';
// import 'package:http/http.dart' as http;
// import 'package:async/async.dart';

// class EditorPage extends StatefulWidget {
//   @override
//   EditorPageState createState() => EditorPageState();
// }

// class EditorPageState extends State<EditorPage> {
//   ZefyrController _controller = ZefyrController();

//   FocusNode _focusNode;
//   bool _editing = false;

//   // EditorPageState(this._controller, this._editing);

//   @override
//   void initState() {
//     super.initState();

//     Delta()
//       ..insert('Karl', {'bold': true})
//       ..insert(' the ')
//       ..insert('Fog', {'italic': true});

//     if (_controller == null) {
//       final document = _loadDocument();
//       _controller = ZefyrController(document);
//       _controller.addListener(() {
//         final contents = jsonEncode(_controller.document);
//         print(_controller.selection.baseOffset);
//       });
//     }
//     _focusNode = FocusNode();
//   }

//   void _saveDocument(BuildContext context) {
//     // Notus documents can be easily serialized to JSON by passing to
//     // `jsonEncode` directly
//     final contents = jsonEncode(_controller.document);
//     // For this example we save our document to a temporary file.
//     // final file = File(Directory.systemTemp.path + "/quick_start.json");
//     // // And show a snack bar on success.
//     // file.writeAsString(contents).then((_) {
//     //   Scaffold.of(context).showSnackBar(SnackBar(content: Text("Saved.")));
//     // });
//     String markdown = notusMarkdown.encode(_controller.document.toDelta());
//     print(markdown);
//   }

//   Widget _buildWelcomeEditor(BuildContext context) {
//     var toolbar = ZefyrToolbar(children: [
//       SelectHeadingStyleButton(controller: _controller),
//       VerticalDivider(indent: 16, endIndent: 16, color: Colors.grey.shade400),
//       ToggleStyleButton(
//         attribute: NotusAttribute.bold,
//         icon: Icons.format_bold,
//         controller: _controller,
//       ),
//       SizedBox(width: 1),
//       ToggleStyleButton(
//         attribute: NotusAttribute.italic,
//         icon: Icons.format_italic,
//         controller: _controller,
//       ),
//       VerticalDivider(indent: 16, endIndent: 16, color: Colors.grey.shade400),
//       ToggleStyleButton(
//         attribute: NotusAttribute.block.numberList,
//         controller: _controller,
//         icon: Icons.format_list_numbered,
//       ),
//       ToggleStyleButton(
//         attribute: NotusAttribute.block.bulletList,
//         controller: _controller,
//         icon: Icons.format_list_bulleted,
//       ),
//       VerticalDivider(indent: 16, endIndent: 16, color: Colors.grey.shade400),
//       ToggleStyleButton(
//         attribute: NotusAttribute.block.quote,
//         controller: _controller,
//         icon: Icons.format_quote,
//       ),
//       EditImagePicker(
//         controller: _controller,
//         icon: Icons.image,
//       ),
//       LinkStyleButton(controller: _controller),
//       InsertEmbedButton(
//         controller: _controller,
//         icon: Icons.horizontal_rule,
//       ),
//     ]);
//     return Scaffold(
//       appBar: AppBar(
//         title: FlatButton.icon(
//           onPressed: () {
//             // _saveDocument(context);
//             final index = _controller.selection.baseOffset;
//             final length = _controller.selection.extentOffset - index;
//             print("index===$index, length===$length");
//             print(_controller.selection.affinity.index);
//           },
//           icon: Icon(
//             Icons.add_comment,
//             color: Colors.white,
//           ),
//           label: Text("点我反馈"),
//           // color: AppColors.primary,
//           textColor: Colors.white,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//         ),
//       ),
//       body: Column(
//         children: [
//           Divider(height: 1, thickness: 1, color: Colors.grey.shade200),
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.only(left: 16.0, right: 16.0),
//               child: ZefyrEditor(
//                 controller: _controller,
//                 focusNode: _focusNode,
//                 autofocus: true,
//                 embedBuilder: customZefyrEmbedBuilder,
//                 // readOnly: true,
//                 // padding: EdgeInsets.only(left: 16, right: 16),
//                 // onLaunchUrl: _launchUrl,
//               ),
//             ),
//           ),
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: toolbar,
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(child: _buildWelcomeEditor(context));
//   }

//   NotusDocument _loadDocument() {
//     final Delta delta = Delta()..insert("\n");
//     return NotusDocument.fromJson(delta.toJson());
//   }
// }

// Widget customZefyrEmbedBuilder(BuildContext context, EmbedNode node) {
//   if (node.value.type.contains('http')) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       child: GestureDetector(
//         child: Image.network(node.value.type, fit: BoxFit.fill),
//         onTap: () {
//           Navigator.push(context, MaterialPageRoute(builder: (_) {
//             return DetailScreen(node.value.type);
//           }));
//         },
//       ),
//     );
//   }

//   return Container();
// }

// class DetailScreen extends StatelessWidget {
//   String _image = "";
//   DetailScreen(this._image);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         child: Center(
//           child: Hero(
//               tag: 'imageHero',
//               child: Image.network(_image, fit: BoxFit.contain)),
//         ),
//         onTap: () {
//           Navigator.pop(context);
//         },
//       ),
//     );
//   }
// }
