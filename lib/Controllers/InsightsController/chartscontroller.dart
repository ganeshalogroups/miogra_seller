// ignore_for_file: depend_on_referenced_packages

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:convert';
import 'package:miogra_seller/Constants/const_variables.dart';
import 'package:miogra_seller/UrlList/api.dart';

class ChartController extends GetxController {
  String userToken = getStorage.read("usertoken") ?? '';

  var dataLoading = false.obs;
  var chartList = <dynamic>[].obs;
  var weekDates = <String>[].obs;
  var weekAmounts = <double>[].obs;
  var totalWeekIncome = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    getCharts();
  }

  Future<void> getCharts() async {
    try {
      dataLoading.value = true;
      final response =
          await http.get(Uri.parse('${API.chartsApi}$userId'), headers: {
        'Authorization': 'Bearer $userToken',
        'Content-Type': 'application/json',
        'userId': userId,
      });
      print('CGCHBNK${response.statusCode}');
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        // Populate weekDates and weekAmounts
        var weeklyIncome = result['data']['weeklyIncome'] as List;

        weekDates.value =
            weeklyIncome.map((item) => item['date'].toString()).toList();
        weekAmounts.value = weeklyIncome
            .map((item) => (item['totalAmount'] as num).toDouble())
            .toList();
        totalWeekIncome.value =
            (result['data']['totalWeekIncome']['totalAmount'] as num)
                .toDouble();

        chartList.value = result['data']['weeklyIncome'] ?? [];
      } else {
        chartList.clear();
        throw Exception('Failed to load for Charts');
      }
    } catch (e) {
      // print('$error');
    } finally {
      dataLoading.value = false;
    }
  }
}
