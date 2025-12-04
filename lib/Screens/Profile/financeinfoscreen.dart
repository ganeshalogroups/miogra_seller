import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miogra_seller/Screens/Home/bottomnavigation.dart';
import 'package:miogra_seller/Widgets/custom_button.dart';
import 'package:miogra_seller/Widgets/custom_container.dart';
import 'package:miogra_seller/Widgets/custom_text.dart';
import 'package:miogra_seller/Widgets/custom_textstyle.dart';

class FinanceInfoScreen extends StatefulWidget {
  const FinanceInfoScreen({super.key});

  @override
  State<FinanceInfoScreen> createState() => _FinanceInfoScreenState();
}

class _FinanceInfoScreenState extends State<FinanceInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
     canPop: false,
      onPopInvoked: (bool didPop) async {
       Navigator.push(context, MaterialPageRoute(builder: (context) =>const RestaurentBottomNavigation(initialIndex: 3,)));
      },
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.grey.shade600),
              onPressed: () {       Navigator.push(context, MaterialPageRoute(builder: (context) =>const RestaurentBottomNavigation(initialIndex: 3,)));
},
            ),
            title: Center(
                child: CustomText(
              text: ' Finance Information    ',
              style: CustomTextStyle.mediumGreyText,
            ))),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: 'Settlement History',style: CustomTextStyle.settleHistoryText,),
              Expanded(
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                    contentPadding:const EdgeInsets.only(top: 0, left: 24, right: 24, bottom: 24),
      
                                title: Stack(
                                  children: [
                                   Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(); // Close the dialog when tapped
                },
                child: SizedBox(
                  height: 25,
                  width: 25,
                  child: Image.asset('assets/images/close.png'),
                ),
              ),
            ),
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: 'Settlement',
                                          style: CustomTextStyle.settleText,
                                        ),
                                      const  SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                              text: 'Settlement ID : 0447 277 725',
                                              style: CustomTextStyle.blackSettleText,
                                            ),
                                            CustomText(
                                              text: 'Processing',
                                              style: CustomTextStyle.blueText,
                                            ),
                                          ],
                                        ),
                                       const SizedBox(height: 3),
                                        CustomText(
                                          text: 'Invoice Number : 0447 277 725',
                                          style:
                                              CustomTextStyle.smallMediumGreyText,
                                        ),
                                       const SizedBox(height: 3),
                                        CustomText(
                                          text: 'Download Invoice',
                                          style: CustomTextStyle.blueText,
                                        ),
                                       const SizedBox(height: 15),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                CustomText(
                                                  text: 'No. of. Orders',
                                                  style: CustomTextStyle.financeText,
                                                ),
                                              const  SizedBox(height: 3),
                                                CustomText(
                                                  text: '150',
                                                  style: CustomTextStyle
                                                      .alertblackText,
                                                ),
                                              ],
                                            ),
                                           const SizedBox(width: 5),
                                            Column(
                                              children: [
                                                CustomText(
                                                  text: 'Total Revenue',
                                                  style: CustomTextStyle.financeText,
                                                ),
                                              const  SizedBox(height: 3),
                                                CustomText(
                                                  text: '₹25,000.00',
                                                  style: CustomTextStyle
                                                      .alertblackText,
                                                ),
                                              ],
                                            ),
                                          const  SizedBox(width: 5),
                                            Column(
                                              children: [
                                                CustomText(
                                                  text: 'Settlement Amount',
                                                  style: CustomTextStyle.financeText,
                                                ),
                                              const  SizedBox(height: 3),
                                                CustomText(
                                                  text: '₹15,000.00',
                                                  style: CustomTextStyle
                                                      .alertblackText,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                       const SizedBox(height: 20),
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  text: 'Payment Type',
                                                  style: CustomTextStyle
                                                      .blackSettleText,
                                                ),
                                              const  SizedBox(height: 5),
                                                CustomText(
                                                  text: 'Bank Transfer',
                                                  style:
                                                      CustomTextStyle.darkGreyText,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 25.h,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  text: 'Proof',
                                                  style: CustomTextStyle.blackText,
                                                ),
                                             const   SizedBox(height: 5),
                                                CustomContainer(
                                                backgroundColor: Colors.blue,
                                                borderRadius:
                                                  BorderRadius.circular(20),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  32.h,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3.1,
                                                  child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                    CustomContainer(
                                                    height: 17,
                                                    width: 17,
                                                    child: Image.asset('assets/images/download.png')),
                                                  const  SizedBox(width: 3,),
                                                      CustomText(
                                                        text: 'Doc.image.pdf',
                                                        style: CustomTextStyle
                                                            .smallWhiteText,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      const  SizedBox(height: 20),
                                        Row(
                                          children: [
                                            CustomButton(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  28,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3.6,
                                              onPressed: () {},
                                              child: CustomText(
                                                text: 'Accept',
                                                style:
                                                    CustomTextStyle.smallWhiteText,
                                              ),
                                            ),
                                         const   SizedBox(width: 7),
                                            CustomText(
                                              text: 'Raise Complaint',
                                              style: CustomTextStyle.orangeText,
                                            ),
                                          ],
                                        ),
                                      ]),]
                                ),
                              );
                            },
                          );
                        },
                        child: CustomContainer(
                         
                          borderRadius: BorderRadius.circular(15),
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                        text: 'Settlement ID : #1234567',
                                        style: CustomTextStyle.mediumBlueText),
                                    CustomText(
                                      text: 'Pending',
                                      style: CustomTextStyle.redText,
                                    ),
                                  ],
                                ),
                              const  SizedBox(
                                  height: 3,
                                ),
                                CustomText(
                                  text: 'Invoice Number : 0447 277 725',
                                  style: CustomTextStyle.smallMediumGreyText,
                                ),
                                CustomText(
                                  text: '₹08 June, 2024 | 11:50 AM',
                                  style: CustomTextStyle.smallGreyText,
                                ),
                              const  SizedBox(
                                  height: 3,
                                ),
                                CustomText(
                                  text: '₹15,000.00',
                                  style: CustomTextStyle.bigGreyText,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
