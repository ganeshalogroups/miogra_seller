// ignore_for_file: depend_on_referenced_packages, avoid_print
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:miogra_seller/Constants/const_variables.dart';
import 'package:miogra_seller/Screens/AuthScreen/loginscreen.dart';
import 'package:miogra_seller/Screens/AuthScreen/welcomescreen.dart';
import 'package:miogra_seller/Screens/Home/bottomnavigation.dart';
import 'package:miogra_seller/UrlList/api.dart';
import 'package:miogra_seller/Widgets/custom_colors.dart';

class LoginController extends GetxController {
  // String usertoken = getStorage.read("usertoken") ?? '';
  var islogindataLoading = false.obs;

  dynamic logindata;

  void loginApi({dynamic email, dynamic loginpassword, bool? errorBox}) async {
    // print('LOGIN API CALLEDD.........');
    //   print('pincodeee....$regPincode');
    try {
      islogindataLoading(true);
      var response = await http.post(
        Uri.parse(API.login),
        headers: {
          "Accept": "*/*",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $usertoken',
        },
        body: jsonEncode(<String, dynamic>{
          "email": email,
          "password": loginpassword,
          "subAdminType": "restaurant"
        }),
      );

      var result = jsonDecode(response.body);
print(" Authorization': 'Bearer $usertoken',");
      print("QQQQQ $result");

      print("${{
          "email": email,
          "password": loginpassword,
          "subAdminType": "restaurant"
        }}");
      // print('email....$email');
      // print('password....$loginpassword');

      print('login status ${response.statusCode}');
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        logindata = result;
        if (logindata['status'] == true) {

           getStorage.write('catres', logindata["data"]["productTypeToFilter"]);
          getStorage.write('username', logindata['data']['name']);
          getStorage.write("mobilenumb", logindata['data']['mobileNo']);
          getStorage.write("usertoken", logindata['data']['token']);
          getStorage.write("userId", logindata['data']['_id']);
          getStorage.write("useremail", logindata['data']['email']);


          catres =  logindata["data"]["productTypeToFilter"];
          userId = logindata['data']['_id'];
          usertoken = logindata['data']['token'];
          username = logindata['data']['name'];
          useremail = logindata['data']['email'];
          mobilenumb = logindata['data']['mobileNo'];
          print(
              'KYC STATUS : ${logindata['data']['adminUserKYC']['isUserKYCVerified']}');
          if (logindata['data']['adminUserKYC']['isUserKYCVerified'] == true) {
            updateLastSeen();
            // Navigate to RestaurentBottomNavigation if KYC is verified
            Get.offAll(() => const RestaurentBottomNavigation(initialIndex: 0));
          } else {
            // Show an error message if KYC is not verified
            Get.snackbar(
              'Your KYC is not verified',
              'You will be verified once your credentials have been updated.',
              backgroundColor: Customcolors.decorationBlueOrange,
              colorText: Customcolors.decorationBlack,
              snackPosition: SnackPosition.TOP,
            );
          }
        }
      } else if (response.statusCode == 400 &&
          result['message'] == "Admin User Not Verified From Admin") {
        if (errorBox == true) {
          Get.snackbar(
            'Account Not Verified',
            'Your account is awaiting admin approval. Please check back soon!',
            backgroundColor: Customcolors.decorationBlueOrange,
            colorText: Customcolors.decorationBlack,
            snackPosition: SnackPosition.TOP,
          );
          Get.offAll(() => const LoginScreen());
        } else {
          Get.offAll(() => const LoginScreen());
        }
      } else if (response.statusCode == 400 &&
          result['message'] == "Password mismatched") {
        Get.snackbar(
          'Wrong Password',
          'The password you entered is incorrect. Please try again.',
          backgroundColor: Customcolors.decorationBlueOrange,
          colorText: Customcolors.decorationBlack,
          snackPosition: SnackPosition.TOP,
        );
        Get.offAll(() => const WelcomeScreen());
      } else if (response.statusCode == 400 &&
          result['message'] == "Admin User Not Found") {
        Get.snackbar(
          'Login Error',
          'User Not Found. Register to Continue...',
          backgroundColor: Customcolors.decorationBlueOrange,
          colorText: Customcolors.decorationBlack,
          snackPosition: SnackPosition.TOP,
        );
        Get.offAll(() => const WelcomeScreen());
      } else if (response.statusCode == 500) {
        Get.offAll(() => const WelcomeScreen());
      } else {
        logindata = null;
        print('ERROR IN LOGIN');
      }
    } catch (e) {
      // print('$e');
    } finally {
      islogindataLoading(false);
    }
  }

  Future<void> updateLastSeen() async {
    DateTime now = DateTime.now();

    // Format the date and time as needed (e.g., ISO 8601 format)
    String formattedDateTime = now.toIso8601String();
    try {
      var response = await http.post(Uri.parse("${API.profileGetApi}/update"),
          headers: API().headers,
          body: jsonEncode(<String, dynamic>{
            "lastSeen": formattedDateTime,
            "fcmToken": tokenFCM,
            "subAdminId": userId,
          }));
      print("sucess 400");
      print(formattedDateTime);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("sucess 200");
        print(DateTime.now().toString());
        print(" tokenfcm from updateLastSeensucess:${tokenFCM}");
      } else {}
    } catch (e) {
      print('The Error is $e');
    }
  }
}
