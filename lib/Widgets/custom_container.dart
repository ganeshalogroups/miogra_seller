import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Color? backgroundColor;
  final Decoration? decoration;
  final Widget? child;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Border? border;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Alignment? alignment;
  
  const CustomContainer({
    super.key,
    this.backgroundColor,
    this.decoration,
    this.child,
    this.width,
    this.height,
    this.borderRadius,
    this.boxShadow,
    this.border,
    this.padding,
    this.margin,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: decoration ??
          BoxDecoration(
            color: backgroundColor,
            borderRadius: borderRadius,
            boxShadow: boxShadow,
            border: border,
          ),
      child: child,
    );
  }
}
