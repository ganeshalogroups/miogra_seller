import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miogra_seller/Widgets/custom_colors.dart';
import 'package:miogra_seller/Widgets/custom_textstyle.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const DeleteConfirmationDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Theme(
    data: ThemeData(
  //    dialogTheme: DialogTheme(backgroundColor: Colors.white)
   ),
      child: AlertDialog(
      surfaceTintColor: Colors.white,
        title: Text("Confirm Delete", style: CustomTextStyle.addonText,),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 25,vertical: 8),
        content: Text("Are you sure you want to delete this item?",style: CustomTextStyle.blackText,),
         actionsAlignment: MainAxisAlignment.spaceAround,
        actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), // Close dialog
          style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 35.w),
            backgroundColor: Colors.white, // White background
            side: BorderSide(color: Colors.black,width: 0.5), // Black border
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          child: Text("No", style: CustomTextStyle.boldblack12), // Black text
        ),
        TextButton(
          onPressed: () {
            // onConfirm(); // Execute delete function
            // Navigator.pop(context); // Close dialog after deletion
                Navigator.pop(context); // First, close the dialog
    Future.delayed(Duration(milliseconds: 100), () {
      onConfirm(); // Then perform the delete & possible navigation
    });

          },
          style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 35.w),
            backgroundColor: Color(0xFF623089), // Orange background
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          child: Text("Yes", style: CustomTextStyle.insText), // White text
        ),
      ],
      ),
    );
  }
}
