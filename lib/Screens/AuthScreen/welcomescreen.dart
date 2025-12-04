import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:miogra_seller/Screens/AuthScreen/categoryRegister.dart';
import 'package:miogra_seller/Screens/AuthScreen/loginscreen.dart';
import 'package:miogra_seller/Screens/AuthScreen/registerscreen.dart';
import 'package:miogra_seller/Widgets/custom_button.dart';
import 'package:miogra_seller/Widgets/custom_text.dart';
import 'package:miogra_seller/Widgets/custom_textstyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              'assets/images/welcomeauth.png',
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
                              height: MediaQuery.of(context).size.height / 20,
                              // child:
                              //     Image.asset('assets/images/fastximage.png'),
                               child: Text("Miogra",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25.h),),
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
                              height: 35.h,
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
                                            const LoginScreen(),
                                      ));
                                },
                                child: CustomText(
                                    text: 'Login',
                                    style: CustomTextStyle.buttonText)),
                            // const SizedBox(
                            //   height: 20,
                            // ),
                            // Container(
                            //   height: 50,
                            //   decoration: BoxDecoration(
                            //       border: Border.all(
                            //         color: Color(0xFF623089),
                            //       ),
                            //       borderRadius: BorderRadius.circular(20)),
                            //   width: double.infinity,
                            //   child: ElevatedButton(
                            //       onPressed: () {
                            //         Navigator.push(
                            //             context,
                            //             MaterialPageRoute(
                            //               builder: (context) =>
                            //                 //  const RegisterScreen(),
                            //                 const Categoryregister()
                            //             ));
                            //       },
                            //       style: ElevatedButton.styleFrom(
                            //         backgroundColor: Colors.transparent,
                            //         shadowColor: Colors.transparent,
                            //         shape: RoundedRectangleBorder(
                            //             borderRadius:
                            //                 BorderRadius.circular(20)),
                            //       ),
                            //       child: CustomText(
                            //         text: 'Register',
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
