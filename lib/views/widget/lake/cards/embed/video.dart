import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:yuyan_app/controller/organization/card/card_controller.dart';
import 'package:yuyan_app/model/document/card/card_video_seri.dart';

class LakeVideoPlayWidget extends StatefulWidget {
  final CardVideoSeri item;

  const LakeVideoPlayWidget({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  _LakeVideoPlayWidgetState createState() => _LakeVideoPlayWidgetState();
}

class _LakeVideoPlayWidgetState extends State<LakeVideoPlayWidget> {
  ChewieController controller;

  @override
  void initState() {
    super.initState();

    Get.put(CardVideoController(widget.item.videoId));
  }

  @override
  void dispose() {
    super.dispose();

    if (controller != null) {
      controller.videoPlayerController.dispose();
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CardVideoController>(
      builder: (c) => c.stateBuilder(
        onIdle: () {
          var data = c.value.info;
          var player = VideoPlayerController.network(
            data.video,
          );
          if (controller == null) {
            controller = ChewieController(
              autoInitialize: true,
              videoPlayerController: player,
            );
          }
          return Container(
            height: Get.width * 0.75,
            width: Get.width,
            child: Chewie(
              controller: controller,
            ),
          );
        },
      ),
    );
  }
}
