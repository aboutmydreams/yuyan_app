part of 'note_editor.dart';

Widget _customZefyrBuilder(BuildContext _, EmbedNode node) {
  debugPrint('custom handler: ${node.value.toJson()}');
  if (node.value is BlockEmbed) {
    var block = node.value;
    switch (block.type) {
      case 'image':
        var url = block.data['source'];
        debugPrint('build image => $url');
        NotusMarkdownCodec();
        return Container(
          width: Get.width * 0.9,
          // constraints: BoxConstraints(
          //   maxWidth: Get.width * 0.9,
          // ),
          child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.contain,
          ),
        );
    }
  }
  return SizedBox.shrink();
}

class CustomInsertImageButton extends StatelessWidget {
  final ZefyrController controller;
  final IconData icon;

  const CustomInsertImageButton({
    Key key,
    @required this.controller,
    @required this.icon,
  }) : super(key: key);

  Future<String> pickImage(ImageSource source) async {
    // final file = await ImagePicker().getImage(source: source, imageQuality: 65);
    // if (file == null) return null;
    // String value = await upload(file);
    // var v = jsonDecode(value);
    // var url = server + "/" + v["data"]["filepath"];
    // print(url);
    // return url;
    final picker = ImagePicker();
    final file = await picker.getImage(source: source);
    if (file == null) return null;
    var controller = Get.find<NoteStatusController>();
    var res = await ApiRepository.postNoteImage(
      path: file.path,
      attachableType: 'Doclet',
      attachableId: controller.value.mirror.docletId,
    );

    // Get.lazyPut(() => ImageUploadController(file.path, attachId),
    //     tag: '${file.path}');
    // return file.path;
    return res.url;
  }

  @override
  Widget build(BuildContext context) {
    return ZIconButton(
      highlightElevation: 0,
      hoverElevation: 0,
      size: 32,
      icon: Icon(
        icon,
        size: 18,
        color: Theme.of(context).iconTheme.color,
      ),
      fillColor: Theme.of(context).canvasColor,
      onPressed: () async {
        final index = controller.selection.baseOffset;
        final length = controller.selection.extentOffset - index;
        ImageSource gallerySource = ImageSource.gallery;
        // controller.replaceText(index, length, BlockEmbed.image("https://img.alicdn.com/imgextra/i1/6000000003634/O1CN01XkL17h1ciPvkUalkW_!!6000000003634-2-octopus.png",));
        final image = await pickImage(gallerySource);
        controller.replaceText(index, length, BlockEmbed.image(image));
      },
    );
  }
}
