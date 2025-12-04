// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:miogra_seller/Constants/const_variables.dart';
import 'package:miogra_seller/Screens/AuthScreen/requestunderreview.dart';
import 'package:miogra_seller/UrlList/api.dart';
import 'package:miogra_seller/Widgets/custom_colors.dart';
class RegisterController extends GetxController {
 String usertoken = getStorage.read("Usertoken") ?? '';

  var isRegisterdataLoading = false.obs;
  dynamic registerdata;

  void registerApi({dynamic restName,dynamic restEmail,dynamic restMob,dynamic restRegion,dynamic restpincode, dynamic categoryRes}) async {
  print('register api called');
    try {
      isRegisterdataLoading(true);
          print('Preparing to send request...');
      print(' api........${API.register}');

      var response = await http.post(
        Uri.parse(API.register),
        headers: {
          "Accept": "*/*",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $usertoken',
        },        
        body: jsonEncode(<String, dynamic>{   
    "name":restName,
    "email": restEmail,
    "mobileNo": restMob,
    "adminProfile": null,
    "instructions":null,
    "gstNo": null,
    "uuid": null,
    "productTypeToFilter":categoryRes,
    "subAdminType": "restaurant",
    "fcmToken": null,
    "noOfOrdersPerMonth": null,
    "imgUrl": null,
    "secretKey": null,
    "role": [
        "Restaurant"
    ],
    "aditionalContactNumber": null,
    "address": {
        "companyName": null,
        "fullAddress": null,
        "street": null,
        "city": restRegion,
        "state": null,
        "country": null,
        "postalCode": restpincode,
        "landMark": null,
        "contactPerson": null,
        "contactPersonNumber": null,
        "addressType": "",
        "latitude": null,
        "longitude": null
    },
    "adminUserKYC": {
        "aadharNo": null,
        "DOB": null,
        "idProofName": null,
        "idProofFrontPicUrl": null,
        "idProofBackPicUrl": null,
        "profilePicUrl": null,
        "isUserKYCVerified": false
    }
}),
      );

      print("  'Authorization': 'Bearer $usertoken',");
      print('reg api........${API.register}');
      print('register response ${response.statusCode}');
      print('Response body: ${response.body}');
      print("product type $categoryRes");
       var result = jsonDecode(response.body);
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
       
        registerdata = result;
              print('Registration successful. Navigating to RequestReview screen.');
          
        //  getStorage.write('catres', categoryRes);
          getStorage.write('username', restName);
          getStorage.write("mobilenumb", restMob);
          getStorage.write("useremail", restEmail);
          getStorage.write("regPincode", restpincode);

        //  catres = categoryRes;
          username = restName;
          useremail = restEmail;
          mobilenumb = restMob;
          regPincode=restpincode;
                  Get.offAll(()=>  RequestReview(restpincode: restpincode));

        
        
      }else if(response.statusCode == 400 &&
          result['message'] =="Email Already Exists"){
                  var message = result['message'] ?? 'Registration successful';

          Get.snackbar(
          'Registration Failed',
          message,
          backgroundColor: Customcolors.decorationBlueOrange,
          colorText: Customcolors.decorationBlack,
          snackPosition: SnackPosition.BOTTOM,
        );
          } else if(response.statusCode == 400 &&
          result['message'] =="MobileNo Already Exists"){
                  var message = result['message'] ?? 'Registration successful';

          Get.snackbar(
          'Registration Failed',
          message,
          backgroundColor: Customcolors.decorationBlueOrange,
          colorText: Customcolors.decorationBlack,
          snackPosition: SnackPosition.BOTTOM,
        );
          } 
          else {
            print('Registration failed. Status code: ${response.statusCode}');

        registerdata = null;
      }
    } catch (e) {
    print('Error during registration: $e');

    } finally {
      isRegisterdataLoading(false);
          print('API call finished');

    }
  }
}



