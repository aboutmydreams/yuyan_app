import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_extend/share_extend.dart';
import 'package:yuyan_app/config/storage_manager.dart';
import 'package:yuyan_app/util/util.dart';

class ImageViewerPage extends StatefulWidget {
  final List<String> imageUrls;
  final String initUrl;

  const ImageViewerPage({
    Key key,
    @required this.imageUrls,
    @required this.initUrl,
  })  : assert(imageUrls != null),
        assert(initUrl != null),
        super(key: key);

  @override
  _ImageViewerPageState createState() => _ImageViewerPageState();
}

class _ImageViewerPageState extends State<ImageViewerPage> {
  PageController _controller;

  var _index = 0.obs;
  var imgLength = 1;

  @override
  void initState() {
    super.initState();
    var index = widget.imageUrls?.indexOf(widget.initUrl);
    if (index != -1) {
      _index.value = index;
      imgLength = widget.imageUrls.length;
    }
    _controller = PageController(initialPage: index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: ExtendedImageGesturePageView.builder(
              onPageChanged: (i) => _index.value = i,
              controller: _controller,
              itemCount: imgLength,
              itemBuilder: (context, index) {
                debugPrint('index: $index => ${widget.imageUrls[index]}');
                return Container(
                  color: Colors.black,
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: ExtendedImage.network(
                      widget.imageUrls[index],
                      width: double.infinity,
                      height: double.infinity,
                      mode: ExtendedImageMode.gesture,
                      filterQuality: FilterQuality.high,
                      onDoubleTap: (state) {
                        var scale = state.gestureDetails.totalScale;
                        if (scale == 1) {
                          state.handleDoubleTap(scale: 2);
                        } else {
                          state.handleDoubleTap(scale: 1);
                        }
                      },
                      initGestureConfigHandler: (state) {
                        return GestureConfig(
                          minScale: 0.7,
                          animationMinScale: 0.5,
                          maxScale: 3,
                          animationMaxScale: 3.5,
                          speed: 1.0,
                          inPageView: true,
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Obx(
                    () => Text(
                      '${_index.value + 1}/$imgLength',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.share),
                  onPressed: () {
                    var url = widget.imageUrls[_index.value];
                    var name = Util.getUrlBaseNameWithSplash(url);
                    var filepath =
                        StorageManager.temporaryDirectory.path + name;
                    debugPrint(filepath);
                    Dio().download(url, filepath).then((value) {
                      debugPrint('$value');
                      ShareExtend.share(filepath, "image");
                    }).catchError((e) {
                      debugPrint('error: $e');
                    });
                  },
                ),
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.file_download),
                  onPressed: () async {
                    // var url = widget.imageUrls[_index.value];
                    // var name = Util.getUrlBaseNameWithSplash(url);
                    BotToast.showText(text: 'not implement');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
