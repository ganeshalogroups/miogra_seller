// ignore_for_file: file_names


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miogra_seller/Controllers/ProfileController/faqcontroller.dart';
import 'package:miogra_seller/Widgets/custom_colors.dart';
import 'package:miogra_seller/Widgets/custom_textstyle.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  FAQScreenState createState() => FAQScreenState();
}

class FAQScreenState extends State<FAQScreen> {
  final FAQController faqq = Get.put(FAQController());
  List<bool> _visibilityList = [];

  @override
  void initState() {
    super.initState();
    fetchFAQ();
  }

  void fetchFAQ() async {
    await faqq.getFAQ();

    final hits = faqq.faqdetails?["data"]["hits"];
    if (hits != null && hits is List) {
      setState(() {
        _visibilityList = List.filled(hits.length, false);
      });
    }
  }

  void _toggleVisibility(int index) {
    setState(() {
      _visibilityList[index] = !_visibilityList[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Customcolors.decorationWhite,
      appBar: AppBar(
        surfaceTintColor: Customcolors.decorationWhite,
        backgroundColor:  Customcolors.decorationWhite,
        title: Text('FAQs', style: CustomTextStyle.ingredientsText),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios_new_outlined,size: 20,),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (faqq.isLoading.isTrue) {
            return Center(
              child: CupertinoActivityIndicator(color: Customcolors.decorationWhite),
            );
          }

          final hits = faqq.faqdetails?["data"]["hits"];
          if (hits == null || hits.isEmpty) {
            return Center(child: Text("No FAQs available"));
          }

          // Ensure _visibilityList matches hit count
          if (_visibilityList.length != hits.length) {
            _visibilityList = List.filled(hits.length, false);
          }

          return ListView.builder(
            itemCount: hits.length,
            itemBuilder: (context, index) {
              final question = hits[index]["document"]["question"].toString();
              final answer = hits[index]["document"]["answer"].toString();

              return Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        question.capitalizeFirst.toString(),
                        style: CustomTextStyle.boldblack12,
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          _visibilityList[index]
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                        ),
                        onPressed: () => _toggleVisibility(index),
                      ),
                    ),
                    Visibility(
                      visible: _visibilityList[index],
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          answer.capitalizeFirst.toString(),
                          style: CustomTextStyle.chipgrey,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
