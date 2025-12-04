// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:miogra_seller/Constants/const_variables.dart';
import 'package:miogra_seller/Controllers/AuthController/forgetpassword.dart';
import 'package:miogra_seller/UrlList/api.dart';
import 'package:miogra_seller/Widgets/custom_colors.dart';

class SignInController extends GetxController {
  String userToken = getStorage.read("userToken") ?? '';
  var isSignInDataLoading = false.obs;

  dynamic signInData;
  final ForgetPasswordController _forgetPasswordController = Get.put(ForgetPasswordController());


  void signInApi({dynamic email, dynamic password}) async {
    print('SIGN-IN API CALLED.........');
    print('pincode: $regPincode');
    try {
      isSignInDataLoading(true);
      var response = await http.post(
        Uri.parse(API.login),
        headers: {
          "Accept": "*/*",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $userToken',
        },
        body: jsonEncode(<String, dynamic>{
          "email": email,
          "password": password,
          "subAdminType": "restaurant"
        }),
      );

      var result = jsonDecode(response.body);
      print('email: $email');
      print('password: $password');
      print('sign-in status ${response.statusCode}');
      
      if (response.statusCode == 400 &&
          result['message'] == "Admin User Not Found") {
        Get.snackbar(
          'Sign-In Error',
          'User Not Found. Register to Continue...',
          backgroundColor: Customcolors.decorationBlueOrange,
          colorText: Customcolors.decorationBlack,
          snackPosition: SnackPosition.BOTTOM,
        );
           
      } else{
      _forgetPasswordController.requestOtp(email: email);
      }
    } catch (e) {
      // Handle the exception
      print('Exception during sign-in: $e');
    } finally {
      isSignInDataLoading(false);
    }
  }
}
