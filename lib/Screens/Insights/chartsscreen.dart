// ignore_for_file: depend_on_referenced_packages, prefer_final_fields

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:miogra_seller/Controllers/InsightsController/chartscontroller.dart';
import 'package:miogra_seller/Widgets/custom_text.dart';
import 'package:miogra_seller/Widgets/custom_textstyle.dart';
import 'package:shimmer/shimmer.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  final ChartController chartController = ChartController();
  bool _showChart = false; // Added boolean for chart visibility

  final ToggleBtnController toggleController = Get.put(ToggleBtnController());

  List<Color> gradientColors = [
    Colors.blue,
    //  Colors.green,
    Color.fromARGB(255, 142, 162, 178),
  ];

  @override
  void initState() {
    // TODO: implement initState
    chartController.getCharts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          if (chartController.dataLoading.value) {
            return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1,
                        height: MediaQuery.of(context).size.height / 25,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 15,
                      )
                    ]));
          }
          final hasChart = chartController.chartList.isNotEmpty;

          if (!hasChart) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'Earning for this Week',
                 // style: CustomTextStyle.earningBlackText,
                ),
                Row(
                  children: [
                    GestureDetector(
                        onTap: _showChartDialog,
                        child: SizedBox(
                            height: 25,
                            width: 25,
                            child: _showChart
                                ? ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                    Color(0xFF623089),
                                      BlendMode.srcIn,
                                    ),
                                    child: Image.asset(
                                        'assets/images/charticon.png'),
                                  )
                                : Image.asset('assets/images/charticon.png'))),
                    SizedBox(
                      width: 10,
                    ),
                    CustomText(
                      text: '₹0.0',
                      style: CustomTextStyle.smallBlackText,
                    )
                  ],
                )
              ],
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Earning for this Week',
                    //  style: CustomTextStyle.earningWeek,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: _showChartDialog,
                            child: SizedBox(
                                height: 25,
                                width: 25,
                                child: _showChart
                                    ? ColorFiltered(
                                        colorFilter: ColorFilter.mode(
                                         Color(0xFF623089),
                                          BlendMode.srcIn,
                                        ),
                                        child: Image.asset(
                                            'assets/images/graph.png'),
                                      )
                                    : Image.asset(
                                        'assets/images/graph.png'))),
                        SizedBox( 
                          width: 10,
                        ),
                        CustomText(
                          text:
                              '₹${chartController.totalWeekIncome.value.toStringAsFixed(2)}',
                          style: CustomTextStyle.smallBlackText,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          );
        }),
      ],
    );
  }

  void _showChartDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.width * 0.8,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 18,
                      left: 8,
                      top: 5,
                      bottom: 12,
                    ),
                    child: LineChart(mainData()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );

    String text = '';
    if (value.toInt() < chartController.weekDates.length) {
      // Extract the date string
      String dateString = chartController.weekDates[value.toInt()];

      // Parse the date string into a DateTime object
      DateTime date = DateTime.parse(dateString);

      // Format the date as 'd MMM' (e.g., '9 Sep')
      text = DateFormat('MMM\nd').format(date);
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );

    // Handle dynamic intervals
    String text = '';
    if (value == 0) {
      text = '₹0';
    } else if (value == 100) {
      text = '₹100';
    } else if (value == 300) {
      text = '₹300';
    } else if (value == 500) {
      text = '₹500';
    } else if (value == 1000) {
      text = '₹1000'; // This should be checked first
    } else if (value > 1000 && value == meta.max) {
      // Round the final value and show it
      text = '₹${value.round()}';
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    // Calculate maxY based on your data
    double maxY = chartController.weekAmounts.isNotEmpty
        ? chartController.weekAmounts.reduce((a, b) => a > b ? a : b) * 1.1
        : 0; // Example: 10% more than the highest value

    return LineChartData(
      gridData: FlGridData(
        drawHorizontalLine: true,
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 50, // Adjust based on your maxY
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey.shade100,
            strokeWidth: 1,
            dashArray: [5, 5],
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40, // Adjust for space
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 100, // Adjust based on your data
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: (chartController.weekDates.length - 1).toDouble(),
      minY: 0,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(
            chartController.weekAmounts.length,
            (index) {
              // Ensure that the value is not negative, clamp it to 0 if it is
              double yValue = chartController.weekAmounts[index] < 0
                  ? 0
                  : chartController.weekAmounts[index];
              return FlSpot(index.toDouble(), yValue);
            },
          ),
          isCurved:
              false, // Disable the curve to draw straight lines between points
          gradient: LinearGradient(colors: gradientColors),
          barWidth: 5,
          curveSmoothness: 0.1, // Lower smoothness factor to reduce bending

          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class ToggleBtnController extends GetxController {
  var isClicked = false.obs;

  void toggle() {
    isClicked.value = !isClicked.value;
  }
}
