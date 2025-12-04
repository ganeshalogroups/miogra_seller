// ignore_for_file: file_names, avoid_print

import 'dart:convert';
import 'package:get/get.dart';
import 'package:miogra_seller/Constants/const_variables.dart';
import 'package:miogra_seller/UrlList/api.dart';
import 'package:http/http.dart' as http;
class Orderfetchcontroller extends GetxController{

dynamic orderfetchmodel;
var orderfetchloading = false.obs;

Future<void> orderFetch() async {
  try {
    orderfetchloading(true);
    
    // Create the basic body
    Map<String, dynamic> body = {
      "subAdminId": userId,
    };
  
    
    var response = await http.post(
      Uri.parse(API.orderfetch),
      headers: API().headers,
      body: jsonEncode(body),
    );
    
    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      var result = jsonDecode(response.body);
 print("Order fetch:${API.orderfetch}");
      
      orderfetchmodel = result;




    } else {


      orderfetchmodel = null;

    }
  } catch (e) {
    print("error: $e");
  } finally {
     orderfetchloading(false);
  }
}
}