import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  final String message;

  const CustomSnackBar({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 16.0, // Adjust top margin
      left: 15.0,
      right: 15.0,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding:const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}




class GradientUnderlineTabIndicator extends Decoration {
  final double borderSideWidth;
  final Gradient gradient;
  final EdgeInsets insets;

  const GradientUnderlineTabIndicator({
    required this.gradient,
    this.borderSideWidth = 2.0,
    this.insets = EdgeInsets.zero,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _GradientUnderlinePainter(this, onChanged);
  }
}

class _GradientUnderlinePainter extends BoxPainter {
  final GradientUnderlineTabIndicator decoration;

  _GradientUnderlinePainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final double width = configuration.size!.width;
    final double height = configuration.size!.height;
    final Rect rect = offset & Size(width, height);

    final Paint paint = Paint()
      ..shader = decoration.gradient.createShader(
        Rect.fromLTWH(rect.left, rect.bottom - decoration.borderSideWidth, width, decoration.borderSideWidth),
      )
      ..style = PaintingStyle.fill;

    final Rect indicatorRect = Rect.fromLTWH(
      rect.left + decoration.insets.left,
      rect.bottom - decoration.borderSideWidth,
      rect.width - decoration.insets.horizontal,
      decoration.borderSideWidth,
    );

    canvas.drawRect(indicatorRect, paint);
  }
}
