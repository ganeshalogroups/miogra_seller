// ignore_for_file: avoid_unnecessary_containers

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miogra_seller/Controllers/AuthController/forgetpassword.dart';
import 'package:miogra_seller/Screens/AuthScreen/loginscreen.dart';
import 'package:miogra_seller/Validators/validator.dart';
import 'package:miogra_seller/Widgets/custom_button.dart';
import 'package:miogra_seller/Widgets/custom_text.dart';
import 'package:miogra_seller/Widgets/custom_textformfield.dart';
import 'package:miogra_seller/Widgets/custom_textstyle.dart';
import 'package:get/get.dart';


class NewPasswordScreen extends StatefulWidget {
  final String email;
  const NewPasswordScreen({super.key, required this.email});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
 final TextEditingController _passwordController = TextEditingController();
final  TextEditingController _reEnterPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _reEnterPasswordVisible = false;
  bool _isLoading = false;
  bool _showValidationError = false; 
  final ForgetPasswordController _forgetPasswordController =
      Get.put(ForgetPasswordController()); 

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration:const BoxDecoration(
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
                  height: _showValidationError
                      ? MediaQuery.of(context).size.height / 1.5.h
                      : MediaQuery.of(context).size.height / 1.65.h,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius:const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            color: Colors.black.withOpacity(0.4),
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                height: 25.h,
                                 child: Image.asset(
                                      'assets/images/fastximage.png'),
                                ),
                                SizedBox(height: 8.h),
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
                                  height: 12.h,
                                ),
                                CustomText(
                                  text: 'We have sent a verification code to',
                                  style: CustomTextStyle.smallWhiteText,
                                ),
                                CustomText(
                                    text: widget.email,
                                    style: CustomTextStyle.medWhiteText),
                                SizedBox(height: 12.h),
                                CustomTextFormField(
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                  controller: _passwordController,
                                  validator: validatePassword,
                                                    
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
                                  label: CustomText(
                                      text: 'Enter new password',
                                      style: CustomTextStyle.textFormText),
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                CustomTextFormField(
                                autovalidateMode: AutovalidateMode.onUserInteraction,

                                  controller: _reEnterPasswordController,
                                  validator: (value) {
                                    String? passwordValidation =
                                        validatePassword(value);
                                    if (passwordValidation != null) {
                                      return passwordValidation;
                                    }
                                    return validatePasswordMatch(
                                        value, _passwordController.text);
                                  },
                                                    
                                  label: CustomText(
                                    text: 'Re-enter new password ',
                                    style: CustomTextStyle
                                        .textFormText, // Use your custom text style
                                  ),
                                  mask:
                                      !_reEnterPasswordVisible, // Set obscureText based on visibility
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _reEnterPasswordVisible
                                          ? Icons.visibility_outlined
                                          : Icons
                                              .visibility_off_outlined, // Toggle between visibility icons
                                      color: Colors.white70,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _reEnterPasswordVisible =
                                            !_reEnterPasswordVisible; // Toggle visibility
                                      });
                                    },
                                  ),
                                ),
                               const SizedBox(
                                  height: 8,
                                ),
                                SizedBox(height: 18.h),
                                CustomButton(
                                    borderRadius: BorderRadius.circular(20),
                                    width: double.infinity,
                                     onPressed: () async {
                                      if (formkey.currentState!.validate()) {
                                        setState(() {
                                          _showValidationError = false;
                                          _isLoading = true;
                                        });
                                   bool success= await 
                                   _forgetPasswordController.updateNewpassword(
                                   email: widget.email,
                                   newPassword: _reEnterPasswordController.text); 
                                   if(success) {
                                        Future.delayed(const Duration(seconds: 2),
                                            () {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                const  LoginScreen(
                                                message:
                                                'Your Password was changed successfully!',
                                              ),
                                            ),
                                          );
                                        });}
                                        else{
                                        print('not navigated');
                                        }
                                      } else {
                                        setState(() {
                                          _showValidationError = true;
                                        });
                                      }
                                    },
                                    child: _isLoading
                                        ? SizedBox(
                                        height: 20,
                                        width: 20,
                                          child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                        )
                                        : CustomText(
                                            text: 'Confirm',
                                            style: CustomTextStyle.buttonText))
                              ],
                            ),
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
