import 'package:flutter/material.dart';
import 'package:miogra_seller/Widgets/custom_colors.dart';

class BoxDecorationsFun {
  static BoxDecoration searchDecoraton({double radus = 10.0}) {
    return BoxDecoration(
      color: Colors.white70,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2), // Shadow color
          offset:
              const Offset(0, 4), // Horizontal offset: 0, Vertical offset: 4
          blurRadius: 1, // Blur radius
          spreadRadius: 0, // Spread radius
        ),
      ],
    );
  }

  static BoxDecoration whiteCircelRadiusDecoration({double radious = 10.0}) {
    return BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(radious));
  }

  static BoxDecoration greyBoderDecoraton({double radus = 10.0}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radus),
      border: Border.all(color: Colors.grey),
    );
  }

  static BoxDecoration bottomCurvedBoxBorder() {
    return BoxDecoration(
      color: Colors.transparent,
      border: Border(bottom: BorderSide(color: Customcolors.decorationWhite)),
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
    );
  }

  static BoxDecoration insightsDecorationCards() {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2), // Shadow color
          offset:
              const Offset(0, 4), // Horizontal offset: 0, Vertical offset: 4
          blurRadius: 1, // Blur radius
          spreadRadius: 0, // Spread radius
        ),
      ],
      borderRadius: BorderRadius.circular(10),
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
       
   Color(0xFFAE62E8),
 Color(0xFF623089)

        ],
      ),
    );
  }

  static BoxDecoration insightsDesign() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
        
   Color(0xFFAE62E8),
 Color(0xFF623089)

        ],
      ),
    );
  }
}
