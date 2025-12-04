import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:miogra_seller/Constants/const_variables.dart';
import 'package:miogra_seller/Controllers/AuthController/regioncontroller.dart';
import 'package:miogra_seller/Model/getregionmodel.dart';
import 'package:miogra_seller/Widgets/custom_text.dart';
import 'package:miogra_seller/Widgets/custom_textstyle.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestReview extends StatefulWidget {
  final String? restpincode;
  const RequestReview({super.key,  this.restpincode});

  @override
  State<RequestReview> createState() => _RequestReviewState();
}

class _RequestReviewState extends State<RequestReview> {
  final RegionController regionController = Get.put(RegionController());
String requestPincode=getStorage.read("regPincode") ?? '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      if (widget.restpincode != null) {
      print('Request review pincode........$requestPincode');
      regionController.getRegion(requestPincode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (regionController.dataLoading.value) {
          // Display the shimmer while loading
          return const Center(child: CircularProgressIndicator());
        }

        // Check if the region data has been loaded
        if (regionController.getRegionModel == null) {
          return const Center(child: Text("Failed to load region data"));
        }

        List<Datum> regionData = regionController.regions; // Assuming you are storing the data in the `regions` list

        // Assuming you need the first vendor details for display
        var firstVendorDetails = regionData.isNotEmpty ? regionData[0].vendorDetails : null;

        String? mobileNumber = firstVendorDetails?.mobileNo ?? "Not available";
        String? email = firstVendorDetails?.email ?? "Not available";

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Image.asset('assets/images/checkgif.gif')),
              // CustomText(
              //   text:
              //       'Lorem ipsum dolor sit amet consectetur. Egestas sagittis duis nec sem suspendisse cras.',
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     color: Colors.grey.shade600,
              //     fontSize: 15,
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              CustomText(
                text: 'If you need any assistance please contact:',
                style: CustomTextStyle.smallBlackBoldText,
              ),
              const SizedBox(
                height: 20,
              ),
              // CustomText(
              //   text: '+91 $mobileNumber | $email',
              //   style: CustomTextStyle.smallBlueText,
              // ),
              GestureDetector(
               onTap: () async {
                          final Uri params = Uri(
                            scheme: 'mailto',
                            path:
                                '$email', //add subject and body here
                          );
                          var url = params.toString();
                          try {
                            // ignore: deprecated_member_use
                            await canLaunch(url);
                            // ignore: deprecated_member_use
                            await launch(url);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Something went wrong when launching URL"),
                              ),
                            );
                            // ignore: avoid_print
                            print("error");
                          }
                        },
                child: CustomText(text: '+91 $mobileNumber | $email',
                 style: CustomTextStyle.smallBlueText,),
              )
            ],
          ),
        );
      }),
    );
  }
}
