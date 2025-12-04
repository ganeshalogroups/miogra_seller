// ignore_for_file: avoid_print

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:miogra_seller/Constants/const_variables.dart';
import 'package:miogra_seller/Controllers/AuthController/logincontroller.dart';
import 'package:miogra_seller/Screens/AuthScreen/forgetpasswordscreen.dart';
import 'package:miogra_seller/Validators/validator.dart';
import 'package:miogra_seller/Widgets/custom_button.dart';
import 'package:miogra_seller/Widgets/custom_text.dart';
import 'package:miogra_seller/Widgets/custom_textformfield.dart';
import 'package:miogra_seller/Widgets/custom_textstyle.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  final String? message;
  const LoginScreen({super.key, this.message});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isPasswordVisible = false;
  // bool _isLoading = false;
  final LoginController loginController = Get.put(LoginController());

  //final ForgetPassword ForgetpassController = Get.put(ForgetPassword());

  final formkey = GlobalKey<FormState>();
  double containerHeight = 0.0;

  @override
  void initState() {
    super.initState();
    if (widget.message != null && widget.message!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showNotification(widget.message!);
        containerHeight = 360.h; // Adjust as needed
      });
    }
  }

  void _expandContainer() {
    setState(() {
      containerHeight = 380.h; // Adjust as needed
    });
  }

  void _showNotification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height / 1.1,
            left: 15,
            right: 15),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime timeBackPressed = DateTime.now();

    return PopScope(
      onPopInvoked: (didPop) {
        final difference = DateTime.now().difference(timeBackPressed);
        timeBackPressed = DateTime.now();

        Fluttertoast.cancel();
        SystemNavigator.pop();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height:
                MediaQuery.of(context).size.height, // Use ScreenUtil for height
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
                    height: containerHeight == 0
                        ? 360.h // Default height using ScreenUtil
                        : containerHeight,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25)),
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
                                  height: 35.h,
                                  // child: Image.asset(
                                  //     'assets/images/fastximage.png'),
                                  child: Text("Miogra",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25.h),),
                                ),
                                SizedBox(height: 6.h),
                                CustomText(
                                  text: 'Restaurant Partner',
                                  style: CustomTextStyle.smallWhiteText,
                                ),
                                SizedBox(height: 10.h),
                                CustomText(
                                    text: 'Welcome!',
                                    style: CustomTextStyle.welcomeText),
                                SizedBox(height: 10.h),
                                CustomTextFormField(
                                  controller: _emailController,
                                  validator: validateEmail,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  label: CustomText(
                                      text: 'E-mail',
                                      style: CustomTextStyle.textFormFieldText),
                                ),
                                SizedBox(height: 15.h),
                                CustomTextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: _passwordController,
                                  validator: loginvalidatePassword,
                                  label: CustomText(
                                    text: 'Password',
                                    style: CustomTextStyle
                                        .textFormFieldText, // Use your custom text style
                                  ),
                                  mask:
                                      !_isPasswordVisible, // Set obscureText based on visibility
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isPasswordVisible
                                          ? Icons.visibility_outlined
                                          : Icons
                                              .visibility_off_outlined, // Toggle between visibility icons
                                      color: Colors.white70,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible =
                                            !_isPasswordVisible; // Toggle visibility
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ForgetPassword(),
                                            ));
                                      },
                                      child: CustomText(
                                          text: 'Forgot Password?',
                                          style: CustomTextStyle
                                              .textFormFieldText),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 25.h),
                                CustomButton(
                                  height: 50,
                                    borderRadius: BorderRadius.circular(20),
                                    width: double.infinity,
                                    onPressed: () {

                                      if (formkey.currentState!.validate()) {
                                        getStorage.write("password",
                                            _passwordController.text);
                                        password = _passwordController.text;
                                        print(
                                            'onchanged password.....$password');
                                        print(
                                            'email...${_emailController.text}');
                                        print(
                                            'password....${_passwordController.text}');

                                            print("TOKEN AAA $usertoken");
                                        loginController.loginApi(
                                            email: _emailController.text,
                                            loginpassword:
                                                _passwordController.text,
                                            errorBox: true);
                                      } else {
                                        _expandContainer();
                                      }
                                    },
                                    child: loginController
                                            .islogindataLoading.value
                                        ? SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          )
                                        : CustomText(
                                            text: 'Login',
                                            style: CustomTextStyle.buttonText))
                              ],
                            ),
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
      ),
    );
  }
}
