// Copyright (c) 2018, the Zefyr project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yuyan_app/models/net/requests/dio_requests.dart';
import 'package:yuyan_app/state_manage/toppest.dart';
import 'package:zefyr/zefyr.dart';

/// Custom image delegate used by this example to load image from application
/// assets.
class CustomImageDelegate implements ZefyrImageDelegate<ImageSource> {
  @override
  ImageSource get cameraSource => ImageSource.camera;

  @override
  ImageSource get gallerySource => ImageSource.gallery;

  @override
  Future<String> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final file = await picker.getImage(source: source);
    if (file == null) return null;
    var imgUrl = await DioReq.uploadImage(
      file.path,
      'Doclet',
      topModel.noteManage.noteData.meta.mirror.id,
    );
    return imgUrl;
  }

  @override
  Widget buildImage(BuildContext context, String imgUrl) {
    // We use custom "asset" scheme to distinguish asset images from other files.
    // print(imgUrl);

    if (imgUrl.startsWith('http')) {
      // Otherwise assume this is a file stored locally on user's device.
      return CachedNetworkImage(
        imageUrl: imgUrl,
        placeholder: (context, url) => FlareActor(
          "assets/flares/progress.flr",
          animation: "active",
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.cover,
      );
    } else if (imgUrl.startsWith('asset')) {
      return Image.asset(imgUrl);
    } else {
      final file = File.fromUri(Uri.parse(imgUrl));

      final image = FileImage(file);
      return Image(image: image);
    }
  }
}
