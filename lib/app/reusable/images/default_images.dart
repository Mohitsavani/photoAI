import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: imageUrl != null
            ? Image.asset(
                imageUrl!,
                width: width,
                height: height,
                fit: fit,
                color: color,
                alignment: alignment,
              )
            : placeholderAsset != null
                ? Image.asset(
                    placeholderAsset!,
                    width: width,
                    height: height,
                    fit: fit,
                    color: color,
                    alignment: alignment,
                  )
                : Container(
                    width: width,
                    height: height,
                    color: color,
                  ), // Placeholder image or color
      ),
    );
  }
}
