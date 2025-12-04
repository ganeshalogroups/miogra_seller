import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:miogra_seller/Widgets/custom_colors.dart';


class AppUtils {
  static void showToast(String? text, {String? webColor}) {
    if (text == null) return;

    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Customcolors.decorationBlack,
      textColor: Colors.white,
      webBgColor: webColor,
      webShowClose: true,
      timeInSecForIosWeb: 3,
      webPosition: "center",
      fontSize: 14.0,
    );
  }

  static void showToastTop(String? text, {String? webColor}) {
    if (text == null) return;

    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Customcolors.decorationBlack,
      textColor: Colors.white,
      webBgColor: webColor,
      webShowClose: true,
      timeInSecForIosWeb: 3,
      webPosition: "center",
      gravity: ToastGravity.TOP,
      fontSize: 14.0,
    );
  }
}
