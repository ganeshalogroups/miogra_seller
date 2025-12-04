import 'package:flutter/material.dart';
import 'package:miogra_seller/Controllers/ProfileController/profileget.dart';
import 'package:miogra_seller/Screens/Home/bottomnavigation.dart';
import 'package:miogra_seller/Validators/validator.dart';
import 'package:miogra_seller/Widgets/custom_button.dart';
import 'package:miogra_seller/Widgets/custom_text.dart';
import 'package:miogra_seller/Widgets/custom_textformfield.dart';
import 'package:miogra_seller/Widgets/custom_textstyle.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final ProfilScreeenController profilScreeenController =
      Get.put(ProfilScreeenController());
  final TextEditingController _currentPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _reEnterNewPassword = TextEditingController();
  bool _isNewPasswordVisible = false;
  bool _reEnterPasswordVisible = false;
  final formkey = GlobalKey<FormState>();

  String? validateReEnterPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please re-enter the password';
    }
    if (value != _newPassword.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => const RestaurentBottomNavigation(
        //               initialIndex: 3,
        //             )));
      },
      child: Scaffold(
        appBar: AppBar(
        centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.grey.shade600),
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const RestaurentBottomNavigation(
                //               initialIndex: 3,
                //             )));
                Navigator.pop(context);
              },
            ),
            title: CustomText(
                          text: 'Change Password     ',
                          style: CustomTextStyle.mediumGreyText,
                        )),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                CustomPriceTextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    mask: true,
                    obscuringCharacter: '*',
                    label: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'Enter Current Password',
                              style: CustomTextStyle.greyTextFormFieldText),
                          const TextSpan(
                              text: ' ⁕',
                              style:
                                  TextStyle(color: Colors.red, fontSize: 17)),
                        ],
                      ),
                    ),
                    controller: _currentPassword,
                    onChanged: (text) {
                      setState(() {});
                    },
                    validator: validatePassword),
                const SizedBox(
                  height: 20,
                ),
                CustomPriceTextFormField(
                  mask:
                      !_isNewPasswordVisible, // Set obscureText based on visibility
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isNewPasswordVisible
                          ? Icons.visibility_outlined
                          : Icons
                              .visibility_off_outlined, // Toggle between visibility icons
                      color: Colors.grey,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _isNewPasswordVisible =
                            !_isNewPasswordVisible; // Toggle visibility
                      });
                    },
                  ),
                  obscuringCharacter: '*',
                  controller: _newPassword,
                  validator: validatePassword,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  label: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Enter New password',
                            style: CustomTextStyle.greyTextFormFieldText),
                        const TextSpan(
                            text: ' ⁕',
                            style: TextStyle(color: Colors.red, fontSize: 17)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomPriceTextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscuringCharacter: '*',
                  style: const TextStyle(color: Colors.black),
                  controller: _reEnterNewPassword,
                  validator: (value) {
                    String? passwordValidation = validatePassword(value);
                    if (passwordValidation != null) {
                      return passwordValidation;
                    }
                    return validatePasswordMatch(value, _newPassword.text);
                  },
                  mask: !_reEnterPasswordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _reEnterPasswordVisible
                          ? Icons.visibility_outlined
                          : Icons
                              .visibility_off_outlined, // Toggle between visibility icons
                      color: Colors.grey,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _reEnterPasswordVisible =
                            !_reEnterPasswordVisible; // Toggle visibility
                      });
                    },
                  ),
                  label: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Re- Enter New password',
                            style: CustomTextStyle.greyTextFormFieldText),
                        const TextSpan(
                            text: ' ⁕',
                            style: TextStyle(color: Colors.red, fontSize: 17)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Obx(() {
                  if (profilScreeenController.passLoading.isTrue) {
                    return CustomButton(
                        onPressed: () {},
                          height: 50,
                        borderRadius: BorderRadius.circular(25),
                      //  height: MediaQuery.of(context).size.height / 24,
                        width: MediaQuery.of(context).size.width / 1.6,
                        child: CustomText(
                          text: 'Loading',
                          style: CustomTextStyle.mediumWhiteText,
                        ));
                  } else {
                    return CustomButton(
                        borderRadius: BorderRadius.circular(25),
                      //  height: MediaQuery.of(context).size.height / 24,
                      height: 50,
                        width: MediaQuery.of(context).size.width / 1.6,
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                          if (_currentPassword.text == _newPassword.text) {
                 Get.snackbar(
                  "Password Error",
                  "New password must be different from the current password.",
                  backgroundColor: Colors.redAccent,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  borderRadius: 10,
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  duration: const Duration(seconds: 2),
                  icon: const Icon(Icons.error, color: Colors.white),
                );
              }else{    profilScreeenController.updatePassword(
                                oldPassword: _currentPassword.text,
                                newPassword: _newPassword.text);}
                        
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => const ProfileScreen(),
                            //     ));
                          }
                        },
                        child: CustomText(
                          text: 'Change Password',
                          style: CustomTextStyle.mediumWhiteText,
                        ));
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
