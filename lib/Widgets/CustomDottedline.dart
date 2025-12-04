
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:miogra_seller/Widgets/custom_colors.dart';

class CustomDottedContainer extends StatelessWidget {
  const CustomDottedContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DottedLine(
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          lineLength: double.infinity,
          lineThickness: 1.0,
          dashLength: 4.0,
          dashColor: Colors.black,
          dashGradient: const [
            Color.fromARGB(255, 169, 169, 169),
            Color.fromARGB(255, 185, 187, 188),
          ],
          
          dashRadius: 4,
          dashGapLength: 6,
          dashGapColor: Customcolors.decorationWhite,
          dashGapRadius: 5,
        ),
      ),
    );
  }
}




class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Color(0xff6C6C6C)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    var max = size.width;
    var dashWidth = 5.0;
    var dashSpace = 5.0;
    double startX = 0;

    while (startX < max) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}







// ignore: must_be_immutable
class DotLine extends StatelessWidget {

  double height ;
 DotLine({super.key,this.height =20.0});

  @override
  Widget build(BuildContext context) {
    return   CustomPaint(
            size: Size( MediaQuery.of(context).size.width / 1, height), // Adjust size here
            painter: DottedLinePainter(),
          );

  }
}