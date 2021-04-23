library flutter_svg_provider;

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui show Image, Picture;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Fetches an HTTP resource from the specified [url] using the specified [headers].
Future<Uint8List> _httpGet(String url, {Map<String, String> headers}) async {
  final HttpClient httpClient = HttpClient();
  final Uri uri = Uri.base.resolve(url);
  final HttpClientRequest request = await httpClient.getUrl(uri);
  if (headers != null) {
    headers.forEach((String key, String value) {
      request.headers.add(key, value);
    });
  }
  final HttpClientResponse response = await request.close();

  if (response.statusCode != HttpStatus.ok) {
    throw HttpException('Could not get network asset', uri: uri);
  }
  return consolidateHttpClientResponseBytes(response);
}

/// Rasterizes given svg picture for displaying in [Image] widget:
class SvgNetworkProvider extends ImageProvider<SvgImageKey> {
  final String url;

  /// Size in logical pixels to render.
  /// Useful for [DecorationImage].
  /// If not specified, will use size from [Image].
  /// If [Image] not specifies size too, will use default size 100x100.
  final Size size; // nullable

  /// Color to tint the SVG
  final Color color;

  /// Width and height can also be specified from [Image] constrictor.
  /// Default size is 100x100 logical pixels.
  /// Different size can be specified in [Image] parameters
  const SvgNetworkProvider(this.url, {this.size, this.color})
      : assert(url != null);

  @override
  Future<SvgImageKey> obtainKey(ImageConfiguration configuration) {
    final double logicWidth = size?.width ?? configuration.size?.width ?? 100;
    final double logicHeight = size?.height ?? configuration.size?.width ?? 100;
    final double scale = configuration.devicePixelRatio ?? 1.0;
    final Color color = this.color ?? Colors.transparent;

    // String svgString = data;
    // if (data.contains('currentColor')) {
    //   svgString = data.replaceAll('currentColor', 'black');
    // }

    return SynchronousFuture<SvgImageKey>(
      SvgImageKey(
        data: url,
        pixelWidth: (logicWidth * scale).round(),
        pixelHeight: (logicHeight * scale).round(),
        scale: scale,
        color: color,
      ),
    );
  }

  @override
  ImageStreamCompleter load(SvgImageKey key, nil) {
    return OneFrameImageStreamCompleter(
      _loadAsync(key),
    );
  }

  static Future<ImageInfo> _loadAsync(SvgImageKey key) async {
    // final String rawSvg = await rootBundle.loadString(key.data);
    // debugPrint('fetch svg: ${key.data}');
    final Uint8List bytes = await _httpGet(key.data);
    // debugPrint('fetch result: $bytes');
    final DrawableRoot svgRoot = await svg.fromSvgBytes(bytes, key.data);
    final ui.Picture picture = svgRoot.toPicture(
      size: Size(
        key.pixelWidth.toDouble(),
        key.pixelHeight.toDouble(),
      ),
      clipToViewBox: false,
      colorFilter: ColorFilter.mode(key.color, BlendMode.srcATop),
    );
    final ui.Image image = await picture.toImage(
      key.pixelWidth,
      key.pixelHeight,
    );
    return ImageInfo(
      image: image,
      scale: key.scale,
    );
  }

  // Note: == and hashCode not overrided as changes in properties
  // (width, height and scale) are not observable from the here.
  // [SvgImageKey] instances will be compared instead.

  @override
  String toString() => '$runtimeType(${describeIdentity(url)})';
}

/// Rasterizes given svg picture for displaying in [Image] widget:
class SvgStringProvider extends ImageProvider<SvgImageKey> {
  final String data;

  /// Size in logical pixels to render.
  /// Useful for [DecorationImage].
  /// If not specified, will use size from [Image].
  /// If [Image] not specifies size too, will use default size 100x100.
  final Size size; // nullable

  /// Color to tint the SVG
  final Color color;

  /// Width and height can also be specified from [Image] constrictor.
  /// Default size is 100x100 logical pixels.
  /// Different size can be specified in [Image] parameters
  const SvgStringProvider(this.data, {this.size, this.color})
      : assert(data != null);

  @override
  Future<SvgImageKey> obtainKey(ImageConfiguration configuration) {
    final double logicWidth = size?.width ?? configuration.size?.width ?? 100;
    final double logicHeight = size?.height ?? configuration.size?.width ?? 100;
    final double scale = configuration.devicePixelRatio ?? 1.0;
    final Color color = this.color ?? Colors.transparent;

    // String svgString = data;
    // if (data.contains('currentColor')) {
    //   svgString = data.replaceAll('currentColor', 'black');
    // }

    return SynchronousFuture<SvgImageKey>(
      SvgImageKey(
        data: data,
        pixelWidth: (logicWidth * scale).round(),
        pixelHeight: (logicHeight * scale).round(),
        scale: scale,
        color: color,
      ),
    );
  }

  @override
  ImageStreamCompleter load(SvgImageKey key, nil) {
    return OneFrameImageStreamCompleter(
      _loadAsync(key),
    );
  }

  static Future<ImageInfo> _loadAsync(SvgImageKey key) async {
    // final String rawSvg = await rootBundle.loadString(key.data);
    final DrawableRoot svgRoot = await svg.fromSvgString(key.data, key.data);
    final ui.Picture picture = svgRoot.toPicture(
      size: Size(
        key.pixelWidth.toDouble(),
        key.pixelHeight.toDouble(),
      ),
      clipToViewBox: false,
      colorFilter: ColorFilter.mode(key.color, BlendMode.srcATop),
    );
    final ui.Image image = await picture.toImage(
      key.pixelWidth,
      key.pixelHeight,
    );
    return ImageInfo(
      image: image,
      scale: key.scale,
    );
  }

  // Note: == and hashCode not overrided as changes in properties
  // (width, height and scale) are not observable from the here.
  // [SvgImageKey] instances will be compared instead.

  @override
  String toString() => '$runtimeType(${describeIdentity(data)})';
}

@immutable
class SvgImageKey {
  const SvgImageKey({
    @required this.data,
    @required this.pixelWidth,
    @required this.pixelHeight,
    @required this.scale,
    this.color,
  })  : assert(data != null),
        assert(pixelWidth != null),
        assert(pixelHeight != null),
        assert(scale != null);

  final String data;

  /// Width in physical pixels.
  /// Used when raterizing.
  final int pixelWidth;

  /// Height in physical pixels.
  /// Used when raterizing.
  final int pixelHeight;

  /// Color to tint the SVG
  final Color color;

  /// Used to calculate logical size from physical, i.e.
  /// logicalWidth = [pixelWidth] / [scale],
  /// logicalHeight = [pixelHeight] / [scale].
  /// Should be equal to [MediaQueryData.devicePixelRatio].
  final double scale;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is SvgImageKey &&
        other.data == data &&
        other.pixelWidth == pixelWidth &&
        other.pixelHeight == pixelHeight &&
        other.scale == scale;
  }

  @override
  int get hashCode => hashValues(data, pixelWidth, pixelHeight, scale);

  @override
  String toString() => '${objectRuntimeType(this, 'SvgImageKey')}'
      '(assetName: "$data", pixelWidth: $pixelWidth, pixelHeight: $pixelHeight, scale: $scale)';
}
