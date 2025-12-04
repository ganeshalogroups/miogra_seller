
import 'package:flutter/widgets.dart';
import 'package:miogra_seller/Widgets/custom_text.dart';
import 'package:miogra_seller/Widgets/custom_textstyle.dart';

class EmptyOrderClass extends StatelessWidget {
  final String title;
  final String content;
  final String image;
  const EmptyOrderClass(
      {super.key,
      required this.title,
      required this.content,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: Image.asset(image),
          ),
          const SizedBox(height: 20),
          CustomText(
            text: title,
            style: CustomTextStyle.mediumBlackText,
          ),
          CustomText(
            text: content,
            style: CustomTextStyle.mediumGreyText,
          ),
        ],
      ),
    );
  }
}
