import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final Color? color;
  final double? letterSpacing;
  final double? wordSpacing;
  final TextDecoration? decoration;

  const CustomText({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.color,
    this.letterSpacing,
    this.wordSpacing,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style?.copyWith(
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            color: color,
            letterSpacing: letterSpacing,
            wordSpacing: wordSpacing,
            decoration: decoration,
          ) ??
          TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            color: color,
            letterSpacing: letterSpacing,
            wordSpacing: wordSpacing,
            decoration: decoration,
          ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}


