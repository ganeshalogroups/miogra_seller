import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miogra_seller/Screens/AuthScreen/loginscreen.dart';
import 'package:miogra_seller/Screens/AuthScreen/registerscreen.dart';
import 'package:miogra_seller/Widgets/custom_button.dart';
import 'package:miogra_seller/Widgets/custom_text.dart';
import 'package:miogra_seller/Widgets/custom_textstyle.dart';

class Categoryregister extends StatefulWidget {
  const Categoryregister({super.key});

  @override
  State<Categoryregister> createState() => _CategoryregisterState();
}

class _CategoryregisterState extends State<Categoryregister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              'assets/images/c02fb580e500637e95d9441b7bc989d55f44bfd6.png',
            ),
            fit: BoxFit.fill,
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.5,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 25,
                              child:
                                  Image.asset('assets/images/Kipgra (1).png'),
                            ),
                            const SizedBox(height: 8),
                            CustomText(
                              text: 'Restaurant Partner',
                              style: CustomTextStyle.smallWhiteText,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            CustomText(
                                text: 'Manage orders and Menu\nin a breeze',
                                style: CustomTextStyle.bigWhiteText),
                            SizedBox(
                              height: 15.h,
                            ),
                            CustomButton(
                              height: 50,
                                borderRadius: BorderRadius.circular(20),
                                width: double.infinity,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                          //  const LoginScreen(),
                                           const RegisterScreen(categoryRes: "restaurant",),

                                      ));
                                },
                                child: CustomText(
                                    text: 'Register as Restaurant',
                                    style: CustomTextStyle.buttonText)),
                            const SizedBox(
                              height: 20,
                            ),
                             CustomButton(
                              height: 50,
                                borderRadius: BorderRadius.circular(20),
                                width: double.infinity,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                         //   const LoginScreen(),
                                          const RegisterScreen(categoryRes:"shop" ,),
                                      ));
                                },
                                child: CustomText(
                                    text: 'Register as Shop',
                                    style: CustomTextStyle.buttonText)),
                            // Container(
                            //   height: 45,
                            //   decoration: BoxDecoration(
                            //       border: Border.all(
                            //         color: Color(0xFF623089),
                            //       ),
                            //       borderRadius: BorderRadius.circular(5)),
                            //   width: double.infinity,
                            //   child: ElevatedButton(
                            //       onPressed: () {
                            //         Navigator.push(
                            //             context,
                            //             MaterialPageRoute(
                            //               builder: (context) =>
                            //                   const RegisterScreen(),
                            //             ));
                            //       },
                            //       style: ElevatedButton.styleFrom(
                            //         backgroundColor: Colors.transparent,
                            //         shadowColor: Colors.transparent,
                            //         shape: RoundedRectangleBorder(
                            //             borderRadius:
                            //                 BorderRadius.circular(5)),
                            //       ),
                            //       child: CustomText(
                            //         text: 'Register as Shop',
                            //         style: CustomTextStyle.orangeButtonText,
                            //       )),
                            // )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}