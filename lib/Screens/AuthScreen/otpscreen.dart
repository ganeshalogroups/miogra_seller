// ignore_for_file: prefer_final_fields, avoid_print

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:miogra_seller/Controllers/AuthController/forgetpassword.dart';
import 'package:miogra_seller/Screens/AuthScreen/newpasswordscreen.dart';
import 'package:miogra_seller/Widgets/custom_button.dart';
import 'package:miogra_seller/Widgets/custom_text.dart';
import 'package:miogra_seller/Widgets/custom_textstyle.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:get/get.dart';

class OTPScreen extends StatefulWidget {
  final String email;
  const OTPScreen({super.key, required this.email});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final CountdownController _controller = CountdownController(autoStart: true);

  bool _isLoading = false;
  String? _errorMessage;
  bool _showResendText = false;
  bool _isCountdownFinished = false;
  bool isLoading = false;

  final TextEditingController _otpNum = TextEditingController();
  final ForgetPasswordController otpcontroller =
      Get.put(ForgetPasswordController());
  final formkey = GlobalKey<FormState>();

  void onFinished() {
    setState(() {
      _showResendText = true;
      _otpNum.clear();
      _errorMessage = null;
      _isCountdownFinished = true; // Set flag when countdown is finished
    });
  }

  @override
  void dispose() {
    _otpNum.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              'assets/images/loginauth.png',
            ),
            fit: BoxFit.fill,
          )),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: _errorMessage == null
                      ? MediaQuery.of(context).size.height / 2.2
                      : MediaQuery.of(context).size.height / 2.1,
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
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 25.h,
                                child:
                                    Image.asset('assets/images/fastximage.png'),
                              ),
                              SizedBox(height: 6.h),
                              CustomText(
                                text: 'Restaurant Partner',
                                style: CustomTextStyle.smallWhiteText,
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              CustomText(
                                  text: 'Forgot Password',
                                  style: CustomTextStyle.welcomeText),
                              SizedBox(
                                height: 6.h,
                              ),
                              CustomText(
                                text: 'We have sent a verification code to',
                                style: CustomTextStyle.smallWhiteText,
                              ),
                              CustomText(
                                  text: widget.email,
                                  style: CustomTextStyle.medWhiteText),
                              SizedBox(height: 15.h),
                              Center(
                                child: SizedBox(
                                  height: 49.5,
                                  width:
                                      MediaQuery.of(context).size.width / 1.6,
                                  child: PinCodeTextField(
                                    pinTheme: PinTheme(
                                      activeColor: Colors.white,
                                      inactiveColor:
                                          Colors.white.withOpacity(0.5),
                                      selectedColor: Colors.white,
                                      shape: PinCodeFieldShape.box,
                                      borderRadius: BorderRadius.circular(10),
                                      borderWidth: 2,
                                      fieldHeight: 50,
                                      fieldWidth: 50,
                                      activeFillColor: Colors.white,
                                      selectedFillColor: Colors.white,
                                      inactiveFillColor: Colors.white,
                                    ),
                                    length: 4,
                                    keyboardType: TextInputType.number,
                                    enableActiveFill: true,
                                    autoFocus: true,
                                    controller: _otpNum,
                                    appContext: context,
                                    onChanged: (value) {
                                      // Clear error message when OTP field is updated
                                      if (_errorMessage != null) {
                                        setState(() {
                                          _errorMessage = null;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              if (_errorMessage != null)
                                Center(
                                  child: Text(
                                    _errorMessage!,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                              SizedBox(height: 8.h),
                              _showResendText
                                  ? Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            text: "Didn't receive the OTP? ",
                                            style:
                                                CustomTextStyle.smallWhiteText,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _showResendText = false;
                                                _controller.restart();
                                                _isCountdownFinished = false;
                                                otpcontroller.requestOtp(
                                                    email: widget.email);
                                              });
                                            },
                                            child: CustomText(
                                                text: 'Resend OTP',
                                                style: CustomTextStyle
                                                    .medWhiteText),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Countdown(
                                      controller: _controller,
                                      seconds: 59,
                                      build: (_, double time) {
                                        String formattedTime =
                                            time.toInt().toString();
                                        if (formattedTime.length == 1) {
                                          formattedTime = '0$formattedTime';
                                        }
                                        return Center(
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Didn't receive the OTP? ",
                                                    style: CustomTextStyle
                                                        .smallWhiteText,
                                                  ),
                                                  CustomText(
                                                      text:
                                                          'Retry in 00.$formattedTime',
                                                      style: CustomTextStyle
                                                          .medWhiteText)
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      onFinished: onFinished,
                                    ),
                              SizedBox(height: 14.h),
                              CustomButton(
                                borderRadius: BorderRadius.circular(20),
                                width: double.infinity,
                                onPressed: () async {
                                  if (_otpNum.text.isEmpty) {
                                    setState(() {
                                      _errorMessage = "Please enter the OTP.";
                                    });
                                    return;
                                  }

                                  if (_isCountdownFinished) {
                                    setState(() {
                                      _errorMessage =
                                          "OTP has expired. Please resend OTP.";
                                      _otpNum.clear();
                                    });
                                    return;
                                  }

                                  setState(() {
                                    isLoading = true;
                                    _errorMessage = null;
                                  });
                                  bool success = await otpcontroller.verifyotp(
                                      otpId: otpcontroller.logindata["data"]
                                          ["otpId"],
                                      otp: _otpNum.text,
                                      email: widget.email);
                                  print('OTP.....${_otpNum.text}');
                                  print(
                                      'OTPID....${otpcontroller.logindata["data"]}');
                                  if (success) {
                                    print(
                                        "OTP verification successful, navigating to NewPasswordScreen");
                                    Get.offAll(() =>
                                        NewPasswordScreen(email: widget.email));
                                  } else {
                                    print(
                                        "OTP verification failed, showing error message");
                                    setState(() {
                                      _errorMessage = otpcontroller
                                          .successMessage
                                          .value; // Display specific error message
                                    });
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
                                },
                                child: _isLoading
                                    ? const CircularProgressIndicator(
                                        color: Color(0xFF623089),
                                      )
                                    : CustomText(
                                        text: 'Verify',
                                        style: CustomTextStyle.buttonText,
                                      ),
                              ),
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
      ),
    );
  }
}
