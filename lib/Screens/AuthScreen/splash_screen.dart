import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:miogra_seller/Constants/const_variables.dart';
import 'package:miogra_seller/Controllers/AuthController/logincontroller.dart';
import 'package:miogra_seller/Controllers/service_controller/app_config.dart';
import 'package:miogra_seller/Screens/AuthScreen/welcomescreen.dart';
import 'package:miogra_seller/Widgets/custom_container.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final LoginController loginController = Get.put(LoginController());
  AppConfigController redirect = Get.put(AppConfigController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await GetStorage.init(); // Ensure storage is initialized
      mobilenumb = getStorage.read("mobilenumb");
      usertoken = getStorage.read("usertoken");
      userId = getStorage.read("userId");
      useremail = getStorage.read("useremail");
      password=getStorage.read("password");

      // print("Usertokennn: $usertoken");
      // print("useremail: $useremail");
      // print("UserId: $userId");
      // print("passworddd $password");

    _initializeSplash();
      Timer(Duration(seconds: 1), () {
        // print("Usertokennn...........: $usertoken");
        // print("useremail.........: $useremail");
        // print("UserId.........: $userId");
        // print("passwordd $password");


        if (useremail != null) {
          loginController.loginApi(email: useremail,loginpassword: password,errorBox: false);
        } else {
          Get.off(() => WelcomeScreen());
        }
      });
    });
  }
  void _initializeSplash() async {
    await redirect.getredirectDetails();

    var data = redirect.redirectLoadingDetails["data"];
    if (data != null && data is List) {
      for (var item in data) {
        if (item["key"] == "imageUrlLink" && item["value"] != null) {
          baseImageUrl = item["value"];
          print("Loaded globalImageUrlLink: $baseImageUrl");
          break;
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomContainer(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/welcomeauth.png'),
                fit: BoxFit.fill,
              ),
            ),
          )
        ],
      ),
    );
  }
}
