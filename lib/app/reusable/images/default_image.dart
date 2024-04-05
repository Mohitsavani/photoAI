import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:posteriya/app/core/assets.dart';

import '../../core/local_string.dart';
import '../global_widget.dart';

class DefaultImage extends StatelessWidget {
  final EdgeInsets margin;
  final double? width;
  final double? height;
  final String? imageUrl;
  final BoxFit fit;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;
  final BlendMode? blendMode;
  final String? placeholderAsset;
  final Alignment alignment;

  const DefaultImage(
    this.imageUrl, {
    Key? key,
    this.margin = EdgeInsets.zero,
    this.width = double.infinity,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.color,
    this.blendMode,
    this.placeholderAsset,
    this.alignment = Alignment.center,
  }) : super(key: key);

//============================================================
// ** Properties **
//============================================================

//============================================================
// ** Flutter Build Cycle **
//============================================================

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: _getImageType(),
      ),
    );
  }

//============================================================
// ** Widgets **
//============================================================

  Widget _networkImage() {
    return CachedNetworkImage(
      alignment: alignment,
      color: color,
      colorBlendMode: blendMode,
      width: width,
      height: height,
      imageUrl: imageUrl!,
      fit: fit,
      placeholder: (context, _) => const SimmerLoader(),
      errorWidget: (context, url, error) => _placeholderImage(),
    );
  }

  Widget _placeholderImage() {
    return Image.asset(
      placeholderAsset!,
      width: width,
      height: height,
      fit: fit,
      color: color,
      colorBlendMode: blendMode,
      alignment: alignment,
    );
  }

  Widget _assetImage() {
    return Image.asset(
      imageUrl ?? emptyString,
      width: width,
      height: height,
      fit: fit,
      color: color,
      colorBlendMode: blendMode,
      alignment: alignment,
    );
  }

  Widget _svgAssetImage() {
    return SvgPicture.asset(
      imageUrl ?? emptyString,
      width: width,
      height: height,
      fit: fit,
      color: color,
      alignment: alignment,
    );
  }

  Widget _svgNetworkImage() {
    return SvgPicture.network(
      imageUrl ?? emptyString,
      width: width,
      height: height,
      fit: fit,
      color: color,
      alignment: alignment,
    );
  }

  Widget _fileImage() {
    return Image.file(
      File(imageUrl ?? emptyString),
      width: width,
      height: height,
      fit: fit,
      color: color,
      colorBlendMode: blendMode,
      alignment: alignment,
    );
  }

//============================================================
// ** Helper Functions **
//============================================================

  Widget _getImageType() {
    if (imageUrl!.startsWith('assets') && imageUrl!.endsWith('svg')) {
      return _svgAssetImage();
    }
    if (imageUrl!.startsWith('http') && imageUrl!.endsWith('svg')) {
      return _svgNetworkImage();
    }
    if (imageUrl == null || imageUrl == emptyString) {
      return _placeholderImage();
    }

    if (imageUrl!.startsWith('http')) {
      return _networkImage();
    }

    if (imageUrl!.startsWith('assets')) {
      return _assetImage();
    }

    return _fileImage();
  }
}

class NetWorkImage extends StatelessWidget {
  final Color? color;
  final BlendMode? blendMode;
  final double? width;
  final double? height;
  final String imageUrl;
  final BoxFit? fit;
  const NetWorkImage(this.imageUrl,
      {super.key,
      this.color,
      this.blendMode,
      this.width,
      this.height,
      this.fit});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      color: color,
      colorBlendMode: blendMode,
      width: width,
      height: height,
      imageUrl: imageUrl,
      fit: fit ?? BoxFit.cover,
      placeholder: (context, _) => const SimmerLoader(),
      errorWidget: (context, url, error) => _placeholderImage(),
    );
  }

  Widget _placeholderImage() {
    return Image.asset(
      AppImages.appBg,
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
      color: color,
      colorBlendMode: blendMode,
    );
  }
}
