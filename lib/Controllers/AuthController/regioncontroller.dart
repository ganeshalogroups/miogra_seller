// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:miogra_seller/Constants/const_variables.dart';
import 'package:miogra_seller/Model/getregionmodel.dart';
import 'package:miogra_seller/UrlList/api.dart';
import 'package:miogra_seller/Widgets/custom_colors.dart';

class RegionController extends GetxController {
  String usertoken = getStorage.read("usertoken") ?? '';
  Getregion? getRegionModel;
  List<Datum> regions = [];
  var dataLoading = false.obs;
  Future<bool> getRegion(dynamic pincode) async {
    print('region api..............');
    try {
      dataLoading.value = true;
      final response = await http.get(
          Uri.parse('${API.getRegionApi}?pincode=$pincode&status=true'),
          headers: {
            'Authorization': 'Bearer $usertoken',
          });
      print('${API.getRegionApi}?pincode=$pincode&status=true');
      print('region response ${response.statusCode}');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        getRegionModel = Getregion.fromJson(data);
        regions = getRegionModel?.data.data ?? [];
       
        return true; // Return true when the status code is 200
      } else {
        Get.snackbar(
          'Pincode Not Available',
          'The pincode you entered is not available in our records. Please try another one.',
          backgroundColor: Customcolors.decorationBlueOrange,
          colorText: Customcolors.decorationBlack,
          snackPosition: SnackPosition.BOTTOM,
        );
        throw Exception('Failed to load regions');
      }
    } catch (e) {
      // Handle the error
      return false; // Return false in case of an error
    } finally {
      dataLoading.value = false;
    }
  }
}
