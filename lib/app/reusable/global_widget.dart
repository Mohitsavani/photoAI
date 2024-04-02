import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Empty extends StatelessWidget {
  const Empty({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

//==============================================================================
// ** App Text Widget **
//==============================================================================

class AppText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabe;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColo;

  const AppText(this.data,
      {super.key,
      this.style,
      this.textAlign,
      this.textDirection,
      this.locale,
      this.softWrap,
      this.overflow,
      this.textScaleFactor,
      this.maxLines,
      this.semanticsLabe,
      this.textWidthBasis,
      this.textHeightBehavior,
      this.selectionColo,
      this.strutStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      data.tr,
      locale: locale,
      style: style,
      key: key,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      selectionColor: selectionColo,
      semanticsLabel: semanticsLabe,
      softWrap: softWrap,
      strutStyle: strutStyle,
      textDirection: textDirection,
      textHeightBehavior: textHeightBehavior,
      textScaleFactor: textScaleFactor,
      textWidthBasis: textWidthBasis,
    );
  }
}
