// ignore_for_file: prefer_final_fields

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miogra_seller/Controllers/AuthController/regioncontroller.dart';
import 'package:miogra_seller/Controllers/AuthController/registercontroller.dart';
import 'package:miogra_seller/Validators/validator.dart';
import 'package:miogra_seller/Widgets/custom_button.dart';
import 'package:miogra_seller/Widgets/custom_text.dart';
import 'package:miogra_seller/Widgets/custom_textformfield.dart';
import 'package:miogra_seller/Widgets/custom_textstyle.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  final String categoryRes;
  const RegisterScreen({super.key,required this.categoryRes});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _restNameController = TextEditingController();
  late TextEditingController _countryController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final registerKormkey = GlobalKey<FormState>();
  String? _validationMessage;
  bool isButtonEnabled = false;
  bool _isLoading = false;
  final RegisterController registerController = Get.put(RegisterController());
  final RegionController regionController = Get.put(RegionController());

  double containerHeight = 0.0;
  @override
  void initState() {
    super.initState();
    _countryController = TextEditingController(text: "+91");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        containerHeight = MediaQuery.of(context).size.height / 1.1.h;
      });
    });
  }

  void _expandContainer() {
    setState(() {
      containerHeight = MediaQuery.of(context).size.height / 0.96.h;
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
            image: AssetImage(
              'assets/images/restaurentauth.png',
            ),
            fit: BoxFit.fill,
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: containerHeight == 0
                    ? MediaQuery.of(context).size.height /
                        1.1.h // Default height using ScreenUtil
                    : containerHeight,
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
                      padding: const EdgeInsets.all(12.0),
                      child: Form(
                        key: registerKormkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                              child: SizedBox(
                                height: 25.h,
                                child:
                                    Image.asset('assets/images/fastximage.png'),
                              ),
                            ),
                            SizedBox(height: 4.h),
                            CustomText(
                              text: 'Restaurant Partner',
                              style: CustomTextStyle.smallWhiteText,
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            CustomText(
                                text: 'Let’s Register your\nRestaurant!',
                                style: CustomTextStyle.bigWhiteText),
                            SizedBox(
                              height: 3.h,
                            ),
                            CustomTextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                label: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: '${widget.categoryRes.capitalizeFirst} Name',
                                          style: CustomTextStyle.textFormText),
                                      const TextSpan(
                                          text: ' ⁕',
                                          style: TextStyle(color: Colors.red)),
                                    ],
                                  ),
                                ),
                                controller: _restNameController,
                                onChanged: (text) {
                                  setState(() {});
                                },
                                validator: validateName),
                            SizedBox(
                              height: 4.h,
                            ),
                            CustomTextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: _emailController,
                              validator: validateEmail,
                              label: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: 'E-mail',
                                        style: CustomTextStyle.textFormText),
                                    const TextSpan(
                                        text: ' ⁕',
                                        style: TextStyle(color: Colors.red)),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Column(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 14,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey.shade400,
                                        width: 1.5,
                                      ),
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Image.asset(
                                            'assets/images/India.png'),
                                      ),
                                      const SizedBox(width: 12),
                                      SizedBox(
                                        width: 35,
                                        child: TextFormField(
                                          controller: _countryController,
                                          readOnly: true,
                                          keyboardType: TextInputType.number,
                                          style:
                                              CustomTextStyle.textFormFieldText,
                                          decoration: InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                                color: Colors.grey.shade400),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        width: 1.5,
                                        color: Colors.grey.shade400,
                                      ),
                                      const SizedBox(width: 10),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.6,
                                        child: TextFormField(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          style: const TextStyle(
                                              color: Colors.white),
                                          controller: _phoneController,
                                          maxLength: 10,
                                          buildCounter: (BuildContext context,
                                              {int? currentLength,
                                              bool? isFocused,
                                              int? maxLength}) {
                                            return null;
                                          },
                                          onChanged: (text) {
                                            setState(() {
                                              _validationMessage =
                                                  validatePhone(text);
                                            });
                                          },
                                          validator: (value) {
                                            final validationMessage =
                                                validatePhone(value);

                                            _validationMessage =
                                                validationMessage;

                                            return null;
                                          },
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                            label: RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: 'Mobile Number',
                                                      style: CustomTextStyle
                                                          .textFormText),
                                                  const TextSpan(
                                                      text: ' ⁕',
                                                      style: TextStyle(
                                                          color: Colors.red)),
                                                ],
                                              ),
                                            ),
                                            // labelText: 'Mobile Number',
                                            // labelStyle: CustomTextStyle
                                            //     .textFormFieldText,
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.auto,
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                                color: Colors.grey.shade400),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            if (_validationMessage != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Text(
                                  _validationMessage!,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 158, 15, 5),
                                      fontSize: 10,
                                      fontFamily: 'Poppins-Regular'),
                                ),
                              ),
                            SizedBox(
                              height: 6.h,
                            ),
                            CustomTextFormField(
                                keyboardType: TextInputType.number,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                label: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Pincode',
                                          style: CustomTextStyle.textFormText),
                                      const TextSpan(
                                          text: ' ⁕',
                                          style: TextStyle(color: Colors.red)),
                                    ],
                                  ),
                                ),
                                controller: _pincodeController,
                                onChanged: (text) {
                                  setState(() {});
                                },
                                validator: validatePinCode),
                            SizedBox(
                              height: 20.h,
                            ),
                            CustomButton(
                              height: 50,
                                borderRadius: BorderRadius.circular(20),
                                width: double.infinity,
                                onPressed: () async {
                                  if (registerKormkey.currentState!
                                      .validate()) {
                                    _validationMessage =
                                        validatePhone(_phoneController.text);
                                    isButtonEnabled =
                                        _validationMessage == null;

                                    if (isButtonEnabled) {
                                      // Call getRegion and wait for the result
                                      bool isRegionLoaded =
                                          await regionController.getRegion(
                                              _pincodeController.text);

                                      // Only call registerApi if region is loaded successfully
                                      if (isRegionLoaded) {
                                        registerController.registerApi(
                                          restName: _restNameController.text,
                                          restEmail: _emailController.text,
                                          restMob: _phoneController.text,
                                          restRegion: _regionController.text,
                                          restpincode: _pincodeController.text,
                                          categoryRes: widget.categoryRes
                                        );
                                      } else {
                                        // Handle region loading failure (e.g., show an error message)
                                        print('Failed to load region');
                                      }
                                    }
                                  } else {
                                    _expandContainer();
                                  }
                                },
                                child: _isLoading
                                    ? const CircularProgressIndicator()
                                    : CustomText(
                                        text: 'Raise Request',
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
    );
  }
}
