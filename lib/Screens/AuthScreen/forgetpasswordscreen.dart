// ignore_for_file: prefer_final_fields

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miogra_seller/Controllers/AuthController/forgetpassword.dart';
import 'package:miogra_seller/Controllers/AuthController/signincontroller.dart';
import 'package:miogra_seller/Validators/validator.dart';
import 'package:miogra_seller/Widgets/custom_button.dart';
import 'package:miogra_seller/Widgets/custom_text.dart';
import 'package:miogra_seller/Widgets/custom_textformfield.dart';
import 'package:miogra_seller/Widgets/custom_textstyle.dart';
import 'package:get/get.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _emailController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  double containerHeight = 0.0;
  bool _isExpanded = false;
  final ForgetPasswordController _forgetPasswordController =
      Get.put(ForgetPasswordController());
  final SignInController signinController = Get.put(SignInController());

  bool _isSignIn = true;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        containerHeight = MediaQuery.of(context).size.height / 2.2.h;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/fpauthimage.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedContainer(
                  height: containerHeight,
                  duration: const Duration(milliseconds: 300),
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
                      Padding(
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
                            const SizedBox(height: 15),
                            CustomText(
                              text: 'Forgot Password',
                              style: CustomTextStyle.welcomeText,
                            ),
                            const SizedBox(height: 10),
                            CustomTextFormField(
                              controller: _emailController,
                              validator: validateEmail,
                              label: CustomText(
                                text: 'E-mail',
                                style: CustomTextStyle.textFormFieldText,
                              ),
                            ),
                            const SizedBox(height: 30),
                            CustomButton(
                          //    height: 50,
                              borderRadius: BorderRadius.circular(20),
                              width: double.infinity,
                              onPressed: () async {
                                if (formkey.currentState!.validate()) {
                                  // Trigger OTP request if the form is valid
                                  if (_isSignIn) {
                                    print('signin.........');
                                    // Trigger the sign-in process
                                    signinController.signInApi(
                                      email: _emailController.text,
                                    );
                                  } else {
                                    print('request otp.........');
                                    // Trigger OTP request
                                    _forgetPasswordController.requestOtp(
                                      email: _emailController.text,
                                    );
                                  }
                                } else {
                                  // Expand the container if the form is invalid
                                  if (!_isExpanded) {
                                    setState(() {
                                      containerHeight =
                                          MediaQuery.of(context).size.height /
                                              2.h;
                                      _isExpanded = true;
                                    });
                                  }
                                }
                              },
                              child: _forgetPasswordController
                                      .isRequestotpLoading.value
                                  ? const CircularProgressIndicator(
                                      color:Color(0xFF623089))
                                  : CustomText(
                                      text: 'Get OTP',
                                      style: CustomTextStyle.buttonText,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
