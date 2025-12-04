// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:miogra_seller/Constants/const_variables.dart';
import 'package:miogra_seller/Model/otpmodel.dart';
import 'package:miogra_seller/Screens/AuthScreen/otpscreen.dart';
import 'package:miogra_seller/UrlList/api.dart';

class ForgetPasswordController extends GetxController {
  String usertokenn = getStorage.read("usertoken") ?? '';

  var isRequestotpLoading = false.obs;
  dynamic logindata;

  void requestOtp({dynamic email}) async {
    try {
      isRequestotpLoading(true);
      var response = await http.post(
        Uri.parse(API.requestOtp),
        headers: {
          "Accept": "*/*",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $usertokenn',
        },
        body: jsonEncode(<String, dynamic>{
          "email": email,
        }),
      );
    
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        var result = jsonDecode(response.body);
        logindata = result;
         Get.offAll(() => OTPScreen(email: email));
      } else {
        logindata = null;
      }
    } catch (e) {
       // print('$error');

    } finally {
      isRequestotpLoading(false);
    }
  }


  var isLoading = false.obs;
  Otpmodel? otpmodel;
  var successMessage = ''.obs;
  var showSmsCallMethod = false.obs;
 // var isOtpFilled = false.obs;

 Future<bool> verifyotp({required dynamic otpId, required dynamic otp, required String email}) async {
  try {
    isLoading(true);
    var response = await http.post(
      Uri.parse(API.verifyotp),
      headers: {
        "Accept": "*/*",
        "Content-Type": "application/json",
        'Authorization': 'Bearer $usertokenn',
      },
      body: jsonEncode(<String, dynamic>{
        "otpId": otpId,
        "otp": otp,
      }),
    );
    print('usertoken $usertokenn');
    print('otpid $otpId');
    print('otp $otp');
 print('OTP Response status: ${response.statusCode}');
print('OTP Response body: ${response.body}'); 

    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      var result = jsonDecode(response.body);
      otpmodel = Otpmodel.fromJson(result);
      print("Parsed OTP response: $result");

      getStorage.write("useremail", email);
      return true;
    } else {
      successMessage.value = "OTP you entered is invalid. Retry";
      showSmsCallMethod.value = true;
      otpmodel = null;
      return false;
    }
  } catch (error) {
  print('OTP ERROR $error');
    // Handle any errors that occur during the HTTP request
    return false;
  } finally {
    isLoading(false);
  }
}

  var isUpdateNewLoading = false.obs;
  dynamic newpassworddata;

Future<bool> updateNewpassword({required dynamic email,required dynamic newPassword}) async {
    try {
      isUpdateNewLoading(true);
      var response = await http.post(
        Uri.parse(API.newPasswordapi),
        headers: {
          "Accept": "*/*",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $usertokenn',
        },
        body: jsonEncode(<String, dynamic>{
          "subAdminType": "restaurant",
    "email":email,
    "newPassword": newPassword
         
        }),
      );
    print('newpassword response ${response.statusCode}');
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        var result = jsonDecode(response.body);
        newpassworddata = result;
        
         return true;
      } else {
        newpassworddata = null;
        return false;
      }
    } catch (e) {
       // print('$error');
       return false;

    } finally {
      isUpdateNewLoading(false);
    }
  }

}
