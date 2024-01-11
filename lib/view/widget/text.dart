import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  String text;
  int? maxLines;
  TextOverflow? overflow;
  double? scaleFactor;
  FontWeight? fontWeight;
  Color? color;
  TextAlign? align;
  double? letterSpacing;
  double? size;
  double? height;
  AppText(
      {Key? key,
      required this.text,
      this.maxLines,
      this.overflow,
      this.scaleFactor,
      this.fontWeight,
      this.align,
      this.letterSpacing,
      this.color,
      this.height,
      this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textScaleFactor: scaleFactor,
      overflow: overflow,
      textAlign: align,
      style: GoogleFonts.openSans(
          textStyle: TextStyle(
              fontWeight: fontWeight,
              color: color,
              height: height,
              decorationStyle: TextDecorationStyle.solid,
              fontSize: size)),
    );
  }
}
