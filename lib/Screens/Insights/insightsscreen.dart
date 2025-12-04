// ignore_for_file: depend_on_referenced_packages, unnecessary_string_interpolations

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:miogra_seller/Controllers/InsightsController/OrdersController.dart';
import 'package:miogra_seller/Controllers/ProfileController/activestatuscontroller.dart';
import 'package:miogra_seller/Screens/Home/bottomnavigation.dart';
import 'package:miogra_seller/Screens/Insights/OrderinInsight.dart';
import 'package:miogra_seller/Screens/Insights/chartsscreen.dart';
import 'package:miogra_seller/Screens/OrdersScreen/empty_order_class.dart';
import 'package:miogra_seller/Shimmer/ordersshimmer.dart';
import 'package:miogra_seller/Widgets/container_decoration.dart';
import 'package:miogra_seller/Widgets/custom_calendor.dart';
import 'package:miogra_seller/Widgets/custom_colors.dart';
import 'package:miogra_seller/Widgets/custom_container.dart';
import 'package:miogra_seller/Widgets/custom_text.dart';
import 'package:miogra_seller/Widgets/custom_textstyle.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({super.key});

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  final DashboardController ordersController = Get.put(DashboardController());
  final ActiveStatusController _activeStatusUpdatecontroller = Get.put(ActiveStatusController());

  List<bool> _isExpanded = [];
  List<bool> _isFurtherExpanded = [];
  late DateTime _selectedMonth = DateTime.now();
  late DateTime _selectedDate = DateTime.now();
  late DateTime _selectedWeekStartDate = DateTime.now();
  late DateTime _selectedWeekEndDate = DateTime.now();
  bool _isMonthView = true;
  bool _isMonth = false;

  List<Color> gradientColors = [
    Colors.blue,
    const Color.fromARGB(255, 142, 162, 178),
  ];

  bool showAvg = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        i = 0;
      });

      ordersController.clearSelectedDate();

      Provider.of<OrderviewPaginations>(context, listen: false)
          .clearData()
          .then((value) {
        Provider.of<OrderviewPaginations>(context, listen: false)
            .fetchviewallorders();
      });
    });

    _isExpanded = List<bool>.filled(3, false);
    _isFurtherExpanded = List<bool>.filled(3, false);
  }

  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 300,
            height: 420,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.white,
                          ),
                          child: const TabBar(
                            indicatorColor: Color(0xFF623089),
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.grey,
                            tabs: [
                              Tab(text: 'Select Date'),
                              Tab(text: 'Customize'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              NormalCalendar(
                                initialDate: _isMonthView
                                    ? _selectedDate
                                    : _selectedWeekStartDate,
                                onDateSelected: (selectedDate) async {
                                  setState(() {
                                    _selectedDate = selectedDate;
                                    _selectedMonth = selectedDate;
                                    _isMonthView = true;
                                    _isMonth = false;
                                  });

                                  Get.find<DashboardController>().updateSelectedDate(selectedDate);
                                  ordersController.fetchOrderData();

                                  Provider.of<OrderviewPaginations>(context, listen: false)
                                      .clearData()
                                      .then((value) {
                                    Provider.of<OrderviewPaginations>(context, listen: false)
                                        .fetchviewallorders();
                                  });

                                  Navigator.of(context).pop();
                                },
                              ),
                              CustomCalendar(
                                initialWeekStartDate: _selectedWeekStartDate,
                                initialWeekEndDate: _selectedWeekEndDate,
                                onMonthSelected: (selectedMonth) {
  setState(() {
    _selectedMonth = selectedMonth;
    _isMonth = true;
  });

  /// ✅ You may want to calculate start & end of the month:
  final firstDay = DateTime(selectedMonth.year, selectedMonth.month, 1);
  final lastDay = DateTime(selectedMonth.year, selectedMonth.month + 1, 0);

  /// ✅ Call range update
  Get.find<DashboardController>().updateSelectedRange(firstDay, lastDay);

  Navigator.of(context).pop();

  Provider.of<OrderviewPaginations>(context, listen: false)
      .clearData()
      .then((_) {
    Provider.of<OrderviewPaginations>(context, listen: false)
        .fetchviewallorders();
  });
},

                                onWeekSelected: (startDate, endDate) async {
  setState(() {
    _selectedWeekStartDate = startDate;
    _selectedWeekEndDate = endDate;
    _isMonthView = false;
    _isMonth = false;
  });

  /// ✅ Call range update
  Get.find<DashboardController>().updateSelectedRange(startDate, endDate);

  ordersController.fetchOrderData(); // optional; already triggered in controller

  Navigator.of(context).pop();

  await Provider.of<OrderviewPaginations>(context, listen: false)
      .clearData()
      .then((_) {
    Provider.of<OrderviewPaginations>(context, listen: false)
        .fetchviewallorders();
  });
},

                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getFormattedMonth(DateTime dateTime) =>
      DateFormat('MMMM yyyy').format(dateTime);

  String _getFormattedDate(DateTime dateTime) =>
      DateFormat('dd MMMM, yyyy').format(dateTime);

  String _getFormattedWeek(DateTime dateTime) =>
      DateFormat('dd MMMM').format(dateTime);

  @override
  Widget build(BuildContext context) {
    var orderviewprovider = Provider.of<OrderviewPaginations>(context);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        Get.find<DashboardController>().clearSelectedDate();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const RestaurentBottomNavigation(initialIndex: 0),
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.grey.shade600),
            onPressed: () {
              Get.find<DashboardController>().clearSelectedDate();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const RestaurentBottomNavigation(initialIndex: 0),
                ),
              );
            },
          ),
          title: Center(
            child: CustomText(
              text: 'Insights          ',
              style: CustomTextStyle.mediumGreyText,
            ),
          ),
        ),
        body: SingleChildScrollView(
          // physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                calenderDeignMethod(context),

                // Uncomment this block if you want dynamic rendering based on data
                // Obx(() {
                //   if (ordersController.isLoading.value) {
                //     return Column(
                //       children: [
                //         emptyInsightsDesign(context),
                //         const SizedBox(height: 20),
                //         const OrderShimmer(),
                //       ],
                //     );
                //   }
                //   if (ordersController.orderData.isEmpty) {
                //     return Column(
                //       children: [
                //         emptyInsightsDesign(context),
                //         const ChartScreen(),
                //         const SizedBox(height: 20),
                //         Obx(() => EmptyOrderClass(
                //               title: _activeStatusUpdatecontroller
                //                           .activeStatus.value ==
                //                       'online'
                //                   ? 'You are Online'
                //                   : 'You are Offline',
                //               content: 'Waiting for orders',
                //               image: 'assets/images/noorders.png',
                //             )),
                //       ],
                //     );
                //   }
                //   return insightLIstCard(context, orderviewprovider);
                // }),

                // Static usage:
                insightLIstCard(context, orderviewprovider),
              ],
            ),
          ),
        ),
      ),
    );
  }

Column insightLIstCard(BuildContext context, orderviewprovider) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    CustomContainer(
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          offset: const Offset(0, 4),
          blurRadius: 1,
        ),
      ],
      width: MediaQuery.of(context).size.width / 2.3,
      decoration: BoxDecorationsFun.insightsDecorationCards(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomContainer(
              height: 25,
              width: 25,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(
                MdiIcons.shoppingOutline,
                color:  Color(0xFF623089),
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: '${ordersController.totalOrders ?? 0}', // ✅ null safe
                  style: CustomTextStyle.insNum,
                ),
                CustomText(
                  text: 'Total Orders',
                  style: CustomTextStyle.insText,
                ),
              ],
            )
          ],
        ),
      ),
    ),
    SizedBox(width: 2.h),
    CustomContainer(
      borderRadius: BorderRadius.circular(15),
      width: MediaQuery.of(context).size.width / 2.3,
      decoration: BoxDecorationsFun.insightsDesign(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CustomContainer(
              height: 25,
              width: 25,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(
                MdiIcons.clockTimeThreeOutline,
                color: Color(0xFF623089),
                size: 25,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: '${(ordersController.totalOrderAmount ?? 0).toStringAsFixed(2)}', // ✅ safe format
                  style: CustomTextStyle.insNum,
                ),
                CustomText(
                  text: 'Revenue',
                  style: CustomTextStyle.insText,
                ),
              ],
            )
          ],
        ),
      ),
    ),
  ],
),

      // Top summary row
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     CustomContainer(
      //       borderRadius: BorderRadius.circular(15),
      //       boxShadow: [
      //         BoxShadow(
      //           color: Colors.grey.withOpacity(0.2),
      //           offset: const Offset(0, 4),
      //           blurRadius: 1,
      //         ),
      //       ],
      //       width: MediaQuery.of(context).size.width / 2.3,
      //       decoration: BoxDecorationsFun.insightsDecorationCards(),
      //       child: Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Row(
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           children: [
      //             CustomContainer(
      //               height: 25,
      //               width: 25,
      //               decoration: const BoxDecoration(
      //                 shape: BoxShape.circle,
      //                 color: Colors.white,
      //               ),
      //               child: Icon(
      //                 MdiIcons.shoppingOutline,
      //                 color: Colors.orange,
      //                 size: 20,
      //               ),
      //             ),
      //             const SizedBox(width: 10),
      //             Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 CustomText(
      //                   text: '${ordersController.totalOrders}',
      //                   style: CustomTextStyle.insNum,
      //                 ),
      //                 CustomText(
      //                   text: 'Total Orders',
      //                   style: CustomTextStyle.insText,
      //                 ),
      //               ],
      //             )
      //           ],
      //         ),
      //       ),
      //     ),
      //     SizedBox(width: 2.h),
      //     CustomContainer(
      //       borderRadius: BorderRadius.circular(15),
      //       width: MediaQuery.of(context).size.width / 2.3,
      //       decoration: BoxDecorationsFun.insightsDesign(),
      //       child: Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Row(
      //           children: [
      //             CustomContainer(
      //               height: 25,
      //               width: 25,
      //               decoration: const BoxDecoration(
      //                 shape: BoxShape.circle,
      //                 color: Colors.white,
      //               ),
      //               child: Icon(
      //                 MdiIcons.clockTimeThreeOutline,
      //                 color: Colors.orange,
      //                 size: 25,
      //               ),
      //             ),
      //             const SizedBox(width: 10),
      //             Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 CustomText(
      //                   text: '${ordersController.totalOrderAmount.toStringAsFixed(2)}',
      //                   style: CustomTextStyle.insNum,
      //                 ),
      //                 CustomText(
      //                   text: 'Revenue',
      //                   style: CustomTextStyle.insText,
      //                 ),
      //               ],
      //             )
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),

      const SizedBox(height: 10),
      ChartScreen(),
      const SizedBox(height: 5),
      CustomText(text: 'Orders', style: CustomTextStyle.addOnsBlackText),
      const SizedBox(height: 15),

      // Order List with Scroll Pagination
      NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollEndNotification &&
              orderviewprovider.totalCount != null &&
              orderviewprovider.fetchCount != null &&
              orderviewprovider.fetchedDatas.length != orderviewprovider.totalCount) {
            setState(() {
              i = i + 1;
            });

            Provider.of<OrderviewPaginations>(context, listen: false)
                .fetchviewallorders(offset: i);
          }
          return true;
        },
        child: Consumer<OrderviewPaginations>(
          builder: (context, value, child) {
            if (_isExpanded.length != value.fetchedDatas.length) {
              _isExpanded = List.generate(value.fetchedDatas.length, (_) => false);
            }
            if (_isFurtherExpanded.length != value.fetchedDatas.length) {
              _isFurtherExpanded = List.generate(value.fetchedDatas.length, (_) => false);
            }

            if (value.isLoading && value.fetchedDatas.isEmpty) {
              return Center(
                child: EmptyOrderClass(
                  title: 'No Orders Found',
                  content: '',
                  image: 'assets/images/noorders.png',
                ),
              );
            } else if (value.isLoading && value.fetchedDatas.isNotEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else if (!value.isLoading && value.fetchedDatas.isEmpty) {
              return Center(
                child: EmptyOrderClass(
                  title: 'No Orders Found',
                  content: ' ',
                  image: 'assets/images/noorders.png',
                ),
              );
            } else {
              return MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ListView.builder(
                 //  physics: NeverScrollableScrollPhysics(),
                    itemCount: value.moreDataLoading
                        ? value.fetchedDatas.length + 1
                        : value.fetchedDatas.length,
                    itemBuilder: (context, index) {
                      if (index >= value.fetchedDatas.length) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CupertinoActivityIndicator(),
                        );
                      }

                      final order = value.fetchedDatas[index];
                      // ... your logic for parsing and building each order card ...
                      // For readability, break it into a method if needed:
                      return buildOrderCard(context, order, index);
                    },
                  ),
                ),
              );
            }
          },
        ),
      ),
    ],
  );
}

int i = 0; // Do not change this
Widget buildOrderCard(BuildContext context, Map<String, dynamic> order, int index) {
  final orderCode = order['orderCode'] ?? '';
  final orderDetails = order['ordersDetails'] ?? [];
  final dropAddressList = order['dropAddress'] as List<dynamic>?;
  final orderedBy = (dropAddressList != null &&
          dropAddressList.isNotEmpty &&
          dropAddressList[0] is Map &&
          dropAddressList[0].containsKey('name'))
      ? dropAddressList[0]['name']
      : 'Unknown';

  final couponAmount = order["amountDetails"]?["couponsAmount"] ?? '';
  // final gst = order['amountDetails']['tax']??0.0 + order['amountDetails']['otherCharges'] ?? 0.0;
  final gst = (order['amountDetails']['tax'] ?? 0.0) 
          + (order['amountDetails']['otherCharges'] ?? 0.0);

 
  final totalAmount = order['amountDetails']['finalAmount'] ?? 0.0;
  final tips = order['amountDetails']['tips'];
  final orderStatus = order["orderStatus"] ?? '';

  // final orderStatusMap = {
  //   'orderAssigned': 'Progress',
  //   'orderPickedUped': 'Picked Up',
  //   'deliverymanReachedDoor': 'Out for Delivery',
  //   'delivered': 'Delivered',
  //   'rejected': 'Rejected',
  //   'cancelled': 'Cancelled',
  //   'roundTripStarted': 'RoundTripStarted',
  // };

  // final statusText = orderStatusMap[orderStatus] ?? 'Unknown';

  // Color statusColor;
  // switch (orderStatus) {
  //   case 'orderAssigned':
  //   case 'orderPickedUped':
  //   case 'deliverymanReachedDoor':
  //     statusColor = Colors.blue;
  //     break;
  //   case 'delivered':
  //     statusColor = Colors.green;
  //     break;
  //   case 'rejected':
  //   case 'cancelled':
  //     statusColor = Colors.red;
  //     break;
  //   default:
  //     statusColor = Colors.grey;
  // }
final orderStatusMap = {
  'new': 'Pending',
  'created': 'Failed',
  'orderAssigned': 'Progress',
  'orderPickedUped': 'Picked Up',
  'deliverymanReachedDoor': 'Out for Delivery',
  'delivered': 'Delivered',
  'rejected': 'Rejected',
  'cancelled': 'Cancelled',
  'roundTripStarted': 'RoundTripStarted',
};

final statusText = orderStatusMap[orderStatus] ?? 'New';

Color statusColor;
switch (orderStatus) {
  case 'new':
    statusColor = Color(0xFF623089);
    break;
  case 'created':
  case 'rejected':
  case 'cancelled':
    statusColor = Colors.red;
    break;
  case 'orderAssigned':
  case 'orderPickedUped':
  case 'deliverymanReachedDoor':
    statusColor = Colors.blue;
    break;
  case 'delivered':
    statusColor = Colors.green;
    break;
  default:
    statusColor = Color(0xFF623089);
}

  String formatDate(String dateStr) {
    DateTime dateTime = DateTime.parse(dateStr).add(const Duration(hours: 5, minutes: 30));
    return DateFormat("d MMM yyyy 'at' h:mma").format(dateTime).toLowerCase();
  }

  return Padding(
    padding:  EdgeInsets.all(8.r),
    child: CustomContainer(
      borderRadius: BorderRadius.circular(15),
      backgroundColor: Colors.white,
      width: MediaQuery.of(context).size.width / 1.1,
        decoration: BoxDecoration(
         border: Border.all(color: Customcolors.decorationLightGrey,width:0.8),
         borderRadius: BorderRadius.circular(20),),
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.all(8.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order ID and status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Order ID: #$orderCode',
                      style: TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.normal,
      color: Customcolors.decorationBlue,
      fontFamily: 'Poppins-Regular')
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            statusText,
                            textAlign: TextAlign.center,
                            style:  TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                             // fontSize: 12,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _isExpanded[index] = !_isExpanded[index];
                            });
                          },
                          child: Icon(
                            _isExpanded[index] ? MdiIcons.chevronUp : MdiIcons.chevronDown,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
    
                CustomText(
                  text: formatDate(order["createdAt"].toString()),
                  style: CustomTextStyle.smallGreyText,
                ),
    
                const SizedBox(height: 10),
                CustomText(
                  text: 'Ordered by: $orderedBy',
                  style: CustomTextStyle.mediumGreyText,
                ),
    
                if (_isExpanded[index]) ...[
                  const SizedBox(height: 10),
                  ...orderDetails.asMap().entries.map((entry) {
                    final i = entry.key;
                    final item = entry.value;
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Image.asset('assets/images/nonveg.png'),
                                  ),
                                  const SizedBox(width: 15),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width / 1.6,
                                        child: Text(
                                          '${item['foodName'] ?? ''} x${item['quantity'] ?? ''}',
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '₹${item['foodPrice'] ?? ''}',
                                        style: CustomTextStyle.smallGreyText,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (i < orderDetails.length - 1) ...[
                          const SizedBox(height: 10),
                          const DottedLine(dashColor: Colors.grey),
                          const SizedBox(height: 10),
                        ],
                      ],
                    );
                  }).toList(),
    
                  const SizedBox(height: 20),
                  DottedLine(dashColor: Colors.grey),
                  const SizedBox(height: 20),
    
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(text: 'Total Bill', style: CustomTextStyle.mediumGreyText),
                      Row(
                        children: [
                          CustomText(
                            text: '₹${totalAmount.toStringAsFixed(2)}',
                            style: CustomTextStyle.mediumGreyText,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _isFurtherExpanded[index] = !_isFurtherExpanded[index];
                              });
                            },
                            child: Icon(
                              _isFurtherExpanded[index] ? MdiIcons.chevronUp : MdiIcons.chevronDown,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
    
                  if (_isFurtherExpanded[index])
                    buildOrderBillingDetails(order, tips, gst, couponAmount),
                ],
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
Widget buildOrderBillingDetails(Map<String, dynamic> order, dynamic tips, dynamic gst, dynamic couponAmount) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: Column(
      children: [
        buildBillingRow('Item Total', order['amountDetails']['cartFoodAmountWithoutCoupon']),
        buildBillingRow('GST and Other Charges', gst),
        buildBillingRow('Packaging Charge', order['amountDetails']['packingCharges']),
        order['amountDetails']['commissionAmount'] !=0?
        buildBillingRow('Commission', order['amountDetails']['commissionAmount']):SizedBox.shrink(),
        buildBillingRow('Delivery Fee (up to ${order['totalKms']} km)', order['amountDetails']['deliveryCharges']),
        buildBillingRow('Platform Fee', order['amountDetails']['platformFee']),
        tips!=0?
        buildBillingRow('Delivery Tip', tips ?? 0.0):SizedBox.shrink(),
        couponAmount!=0?
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(text: 'Coupon Discount', style: CustomTextStyle.mediumGreyText),
            CustomText(
              text: '${order['amountDetails']['couponType'] == 'percentage' ? '%' : '₹'} $couponAmount',
              style: CustomTextStyle.greencolorText,
            ),
          ],
        ):SizedBox.shrink(),
        const SizedBox(height: 20),
      ],
    ),
  );
}

Widget buildBillingRow(String label, dynamic value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 7),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(text: label, style: CustomTextStyle.mediumGreyText),
        CustomText(text: '₹${(value ?? 0).toStringAsFixed(2)}', style: CustomTextStyle.mediumGreyText),
      ],
    ),
  );
}

  SizedBox calenderDeignMethod(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  _showCustomDialog(context);
                },
                child: CustomText(
                  text: _isMonth
                      ? _getFormattedMonth(_selectedMonth)
                      : _isMonthView
                          ? _getFormattedDate(_selectedMonth)
                          : '${_getFormattedWeek(_selectedWeekStartDate)} - ${_getFormattedWeek(_selectedWeekEndDate)}',
                  style: CustomTextStyle.dateBlackText,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          CustomText(
            text: _isMonth
                ? 'Performance For Month'
                : _isMonthView
                    ? 'Performance for a day'
                    : 'Performance For Week',
            style: CustomTextStyle.performanceBlackText,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Row emptyInsightsDesign(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomContainer(
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // Shadow color
              offset: const Offset(
                  0, 4), // Horizontal offset: 0, Vertical offset: 4
              blurRadius: 1, // Blur radius
              spreadRadius: 0, // Spread radius
            ),
          ],
          width: MediaQuery.of(context).size.width / 2.3,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2), // Shadow color
                offset: const Offset(
                    0, 4), // Horizontal offset: 0, Vertical offset: 4
                blurRadius: 1, // Blur radius
                spreadRadius: 0, // Spread radius
              ),
            ],
            borderRadius: BorderRadius.circular(5),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
              
   Color(0xFFAE62E8),
 Color(0xFF623089)

              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  CustomContainer(
                    height: 25,
                    width: 25,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Icon(
                      MdiIcons.shoppingOutline,
                      color: 
   
 Color(0xFF623089)
,
                      size: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: '${ordersController.totalOrders}',
                        style: CustomTextStyle.insNum,
                      ),
                      CustomText(
                          text: 'Total Orders', style: CustomTextStyle.insText),
                    ],
                  )
                ]),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 2.h,
        ),
        CustomContainer(
          borderRadius: BorderRadius.circular(5),
          width: MediaQuery.of(context).size.width / 2.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
               
   Color(0xFFAE62E8),
 Color(0xFF623089)

              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomContainer(
                      height: 25,
                      width: 25,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(
                        MdiIcons.clockTimeThreeOutline,
                        color: 
 
 Color(0xFF623089)
,
                        size: 25,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: '${ordersController.totalOrderAmount}',
                          style: CustomTextStyle.insNum,
                        ),
                        CustomText(
                            text: 'Revenue', style: CustomTextStyle.insText),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('Jun2', style: style);
        break;
      case 4:
        text = const Text('Jun3', style: style);
        break;
      case 6:
        text = const Text('Jun4', style: style);
      case 8:
        text = const Text('Jun5', style: style);
      case 10:
        text = const Text('Jun6', style: style);

        break;

      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );

    String text;
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 2:
        text = '30k';
        break;
      case 3:
        text = '50k';
      case 4:
        text = '70k';
      case 5:
        text = '90k';
        break;
      default:
        return const Text('0k');
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        drawHorizontalLine: true,
        show: true,
        drawVerticalLine:
            false, // Set to false if you don't want vertical lines
        horizontalInterval: 1,
        getDrawingHorizontalLine: (value) {
          // Show a line only at values 1, 3, and 5
          if (value == 1 || value == 2 || value == 3) {
            return const FlLine(
              color: Colors.grey,
              strokeWidth: 1, // Adjust the stroke width as needed
              dashArray: [5, 5], //5 Optional: Make it dashed
            );
          }
          // No line for other values
          return const FlLine(
            color: Colors.transparent,
            strokeWidth: 0,
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
            reservedSize: 60,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 30,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 5,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
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
