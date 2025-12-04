// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:miogra_seller/Constants/const_variables.dart';
import 'package:miogra_seller/Screens/Home/bottomnavigation.dart';
import 'package:miogra_seller/Screens/Profile/profilescreen.dart';
import 'package:miogra_seller/UrlList/api.dart';

class ProfilScreeenController extends GetxController {
  String userToken = getStorage.read("usertoken") ?? '';
  // String userId = getStorage.read("UserId") ?? '';

  var dataLoading = false.obs;
  var restProfile = <dynamic>[].obs; // Keep as an observable list
  var active =""; // Keep as an observable list
  var restaurantCommission ="";

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future<void> getProfile() async {
    print('PROFILE DATA........');
    try {
      dataLoading.value = true;
      final response =
          await http.get(Uri.parse("${API.profileGetApi}/$userId"), headers: {
        'Authorization': 'Bearer $userToken',
        'Content-Type': 'application/json',
        'userId': userId,
      });
      print('profile userid......$userId');
      print('profile usertoken......$userToken');

      print('prOfile response........${"${API.profileGetApi}/$userId"}');
      if (response.statusCode == 200) {
        print("profile response :${response.body}");
        var responseBody = jsonDecode(response.body);

 
        if (responseBody['data'] != null) {
          restProfile.value = [responseBody['data']];
          active = responseBody['data']["activeStatus"];
          restaurantCommission = responseBody['data']["servicesType"]["commissionRate"];
        
        } else {}
         print("ASASSAS $restaurantCommission");
      } else {}
    } catch (e) {
      // print('$e');
    } finally {
      dataLoading.value = false;
    }
  }

  var updateLoading = false.obs;

  Future<void> updateProfile(
      {String? username,
      String? imgUrl,
      String? bankName,
      String? accountNo,
      String? accountType,
      String? ifscCode,
      String? thumbUrl,
      String? mediumUrl,
      String? panNo,
      String? gstNo,
      dynamic profileData}) async {
    try {
      updateLoading.value = true;
      final response = await http.post(
        Uri.parse("${API.profileGetApi}/update"),
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
          'userId': userId,
        },
        body: jsonEncode(<String, dynamic>{
          "subAdminId": userId,
          "name": username,
          "mediumImgUrl": mediumUrl,
          "thumbImgUrl": thumbUrl,
          "imgUrl": imgUrl,
          "adminUserKYC": {
            "idProofNumber": panNo.toString(),
            "gstInNumber": gstNo.toString(),
            "isUserKYCVerified": profileData["adminUserKYC"]
                ["isUserKYCVerified"],
            // "DOB": profileData["adminUserKYC"]["DOB"].toString(),
            "idProofType": profileData["adminUserKYC"]["idProofType"],
            "idProofFrontPicUrl": profileData["adminUserKYC"]
                ["idProofFrontPicUrl"],
            "idProofBackPicUrl": profileData["adminUserKYC"]
                ["idProofBackPicUrl"],
            "gstProofFrontPicUrl": profileData["adminUserKYC"]
                ["gstProofFrontPicUrl"],
            "gstProofBackPicUrl": profileData["adminUserKYC"]
                ["gstProofBackPicUrl"],
            "profilePicUrl": profileData["adminUserKYC"]["profilePicUrl"],
          },
          "BankDetails": {
            "bankName": bankName,
            "acType": accountType,
            "accountNumber": accountNo,
            "ifscCode": ifscCode,
            "branchName": null,
          },
        }),
      );
      print('profile userid......$userId');
      print('prOfile response........${response.body}');
      var responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("response200");
        print({
          "subAdminId": userId,
          "name": username,
          "imgUrl": imgUrl,
          "mediumImgUrl": mediumUrl,
          "thumbImgUrl": thumbUrl,
          "adminUserKYC": {
            "idProofNumber": panNo.toString(),
            "gstInNumber": gstNo.toString(),
            "isUserKYCVerified": profileData["adminUserKYC"]
                ["isUserKYCVerified"],
            // "DOB": profileData["adminUserKYC"]["DOB"].toString(),
            "idProofType": profileData["adminUserKYC"]["idProofType"],
            "idProofFrontPicUrl": profileData["adminUserKYC"]
                ["idProofFrontPicUrl"],
            "idProofBackPicUrl": profileData["adminUserKYC"]
                ["idProofBackPicUrl"],
            "gstProofFrontPicUrl": profileData["adminUserKYC"]
                ["gstProofFrontPicUrl"],
            "gstProofBackPicUrl": profileData["adminUserKYC"]
                ["gstProofBackPicUrl"],
            "profilePicUrl": profileData["adminUserKYC"]["profilePicUrl"],
          },
          "BankDetails": {
            "bankName": bankName,
            "acType": accountType,
            "accountNumber": accountNo,
            "ifscCode": ifscCode,
            "branchName": null,
          },
        });
        Get.to(
          () => const RestaurentBottomNavigation(
            initialIndex: 3,
          ),
        );

        if (responseBody['data'] != null) {
          restProfile.value = [responseBody['data']];
        } else {}
      } else {
        print("2uy ${responseBody['message'].toString()}");
        Get.snackbar(
          "Failed to update user",
          responseBody['message'].toString(),
        );
      }
    } catch (e) {
      print("3");
      Get.snackbar(
        "Failed",
        e.toString(),
      );
      // print('$e');
    } finally {
      updateLoading.value = false;
    }
  }

  var passLoading = false.obs;
  Future<void> updatePassword({
    String? oldPassword,
    String? newPassword,
  }) async {
    try {
      passLoading.value = true;
      final response = await http.post(
        Uri.parse("${API.profileGetApi}/changePassword"),
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
          'userId': userId,
        },
        body: jsonEncode(<String, dynamic>{
          "subAdminId": userId,
          "oldPassword": oldPassword,
          "newPassword": newPassword
        }),
      );
      print('profile userid......$userId');
      print("name ***************************** $username");
      print('prOfile response........${response.body}');
      if (response.statusCode == 200) {
        // updateLastSeen();
        //  var responseBody = jsonDecode(response.body);
        Get.to(
          () => const ProfileScreen(),
        );
      } else {
        print("2");
        Get.snackbar(
          "Failed to update password",
          "",
        );
      }
    } catch (e) {
      print("3");
      Get.snackbar(
        "Failed to update password",
        e.toString(),
      );
      // print('$e');
    } finally {
      passLoading.value = false;
    }
  }

  void logout() {
    passLoading.value = false;
    restProfile.clear();
  }
}
