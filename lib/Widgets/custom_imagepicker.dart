import 'package:flutter/material.dart';
import 'dart:io';
import 'package:miogra_seller/Widgets/custom_container.dart';

// class CustomImagePicker extends StatelessWidget {
//   final File? image;
//   final String? imageUrl;
//   final VoidCallback onTap;
//   final double height;
//   final double width;

//   const CustomImagePicker({
//     super.key,
//     required this.image,
//     required this.imageUrl,
//     required this.onTap,
//     required this.height,
//     required this.width,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: CustomContainer(
//         borderRadius: BorderRadius.circular(5),
//         height: height,
//         width: width,
//         backgroundColor: Colors.grey.shade300,
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: image != null
//               ? Image.file(
//                   image!,
//                   fit: BoxFit.cover,
//                   width: width,
//                   height: height,
//                 )
//               : (imageUrl?.isNotEmpty == true
//                   ? Image.network(
//                       imageUrl!,
//                       fit: BoxFit.cover,
//                       width: width,
//                       height: height,
//                     )
//                   : Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: Image.asset(
//                         'assets/images/imagefetch.png',
//                         fit: BoxFit.cover,
//                       ),
//                     )),
//         ),
//       ),
//     );
//   }
// }



class CustomImagePicker extends StatelessWidget {
  final File? image;
  final String? imageUrl;
  final VoidCallback onTap;
  final double height;
  final double width;

  const CustomImagePicker({
    super.key,
    required this.image,
    required this.imageUrl,
    required this.onTap,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomContainer(
        borderRadius: BorderRadius.circular(5),
        height: height,
        width: width,
        backgroundColor: Colors.grey.shade300,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: image != null
              ? Image.file(
                  image!,
                  fit: BoxFit.cover,
                  width: width,
                  height: height,
                )
              : (imageUrl != null && imageUrl!.isNotEmpty && imageUrl != "null" // ✅ Fix Here
                  ? Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      width: width,
                      height: height,
                      errorBuilder: (context, error, stackTrace) => _buildPlaceholder(), // ✅ Handle Errors Gracefully
                    )
                  : _buildPlaceholder()),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Image.asset(
        'assets/images/imagefetch.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
