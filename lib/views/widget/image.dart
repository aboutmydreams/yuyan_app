import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// [SmartImageWidget] handles multi-types of images,
/// including svg, local asset and common network image
/// designed for avatar with circular = true
class SmartImageWidget extends StatelessWidget {
  final String url;
  final bool circular;

  const SmartImageWidget({
    Key key,
    this.url,
    this.circular = false,
  }) : super(key: key);

  Widget _buildImage() {
    if (url.contains('assets/')) {
      return Image.asset(url);
    }
    if (url.endsWith('.svg')) {
      return SvgPicture.network(url);
    }
    final loading = const FlareActor(
      "assets/flares/progress.flr",
      animation: "active",
    );
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (_, __) => loading,
      errorWidget: (_, __, err) => Icon(Icons.error),
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget child = _buildImage();
    if (circular) {
      child = ClipOval(
        child: child,
      );
    }
    return child;
  }
}
