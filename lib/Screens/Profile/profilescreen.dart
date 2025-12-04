// ignore_for_file: depend_on_referenced_packages, unused_element

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:miogra_seller/Constants/const_variables.dart';
import 'package:miogra_seller/Controllers/FileuploadController/FileUploader.dart';
import 'package:miogra_seller/Controllers/ProfileController/profileget.dart';
import 'package:miogra_seller/Controllers/service_controller/app_config.dart';
import 'package:miogra_seller/Screens/AuthScreen/welcomescreen.dart';
import 'package:miogra_seller/Screens/Home/bottomnavigation.dart';
import 'package:miogra_seller/Screens/Profile/changepasswordscreen.dart';
import 'package:miogra_seller/Screens/Profile/editprofilescreen.dart';
import 'package:miogra_seller/Screens/Profile/faq_screen.dart';
import 'package:miogra_seller/Shimmer/profilescreenshimmer.dart';
import 'package:miogra_seller/Widgets/custom_button.dart';
import 'package:miogra_seller/Widgets/custom_container.dart';
import 'package:miogra_seller/Widgets/custom_text.dart';
import 'package:miogra_seller/Widgets/custom_textstyle.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfilScreeenController profilScreeenController =
      Get.put(ProfilScreeenController());
  ImageUploader fileuploader = Get.put(ImageUploader());
  final AppConfigController appCOnfig = Get.put(AppConfigController());

  @override
  void initState() {
    super.initState();
    profilScreeenController.getProfile();
    appCOnfig.getredirectDetails();
  }

  File? _pickedImage; // State to hold the picked image file
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        // aspectRatioPresets: [
        //   CropAspectRatioPreset.square,
        //   CropAspectRatioPreset.ratio3x2,
        //   CropAspectRatioPreset.original,
        //   CropAspectRatioPreset.ratio4x3,
        //   CropAspectRatioPreset.ratio16x9,
        // ],
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),

        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            minimumAspectRatio: 1.0,
          ),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          _image = File(croppedFile.path);
//            isTyping = true;
        });

        await fileuploader.uploadImage(file: _image).then((value) {
          // setState(() {
          //   isUploading = false;
          // });
        });
      } else {}
    }
  }

  final List<String> items = [
    "Edit profile",
    "Change password",
    // "Finance Information",
    "FAQ",
    "Privacy Policy",
    "About",
    "Logout",
  ];

  final List<String> imagePaths = [
    'assets/images/icon.png',
    'assets/images/icon.png',
    // 'assets/images/icon.png',
    'assets/images/faq.png',
    'assets/images/icon.png',
    'assets/images/about.png',
    'assets/images/signout.png'
  ];

  @override
  Widget build(BuildContext context) {
    return
    PopScope(
     canPop: false,
     onPopInvoked: (bool didPop) async {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>
        //             const RestaurentBottomNavigation(initialIndex: 0)));
      },
     child:
       Scaffold(
        appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            // leading: IconButton(
            //   icon: Icon(Icons.arrow_back, color: Colors.grey.shade600),
            //   onPressed: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) =>
            //                 const RestaurentBottomNavigation(initialIndex: 0)));
            //   },
            // ),
            title: CustomText(
              text: 'Profile        ',
              style: CustomTextStyle.mediumGreyText,
            )),
        body: Obx(() {
          if (profilScreeenController.dataLoading.value) {
            return const EditScreeenShimmer();
          }
          if (profilScreeenController.restProfile.isEmpty) {
            return const Center(child: Text('No Data Found'));
          }
          var profileData = profilScreeenController.restProfile.first;
          var restId = profileData['uuid'] ?? '';
          var restName = profileData['name'] ?? '';
          var restMob = profileData['mobileNo'] ?? '';
          var restEmail = profileData['email'] ?? '';
          var restRating = (profileData['ratingAverage']?.toDouble() ?? 0.0);
          var profileDatawithindex = profilScreeenController.restProfile;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomContainer(
                    borderRadius: BorderRadius.circular(15),
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                              text: 'Restaurant ID: $restId',
                              style: CustomTextStyle.mediumBlueText),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  12), // Set the border radius here

                              image: profileData['imgUrl'] != null
                                  ? DecorationImage(
                                      image: NetworkImage(
                                          '$baseImageUrl${profileData['imgUrl']}'),
                                      fit: BoxFit.cover,
                                    )
                                  : const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/restProf.png'),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomText(
                              text: restName,
                              style: CustomTextStyle.profileBoldBlackText),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                  text: '+91 $restMob',
                                  style: CustomTextStyle.timeText),
                              CustomText(
                                  text: ' | ', style: CustomTextStyle.timeText),
                              CustomText(
                                  text: restEmail,
                                  style: CustomTextStyle.timeText)
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                  text: '${restRating.toStringAsFixed(1)}',
                                  style: CustomTextStyle.mediumBoldBlackText),
                              const SizedBox(width: 5),
                              RatingBar.builder(
                                initialRating: restRating,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 20.0,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 1.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                ignoreGestures: true,
                                onRatingUpdate: (rating) {
                                  return;
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: CustomContainer(
                      backgroundColor: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      height: MediaQuery.of(context).size.height / 1.7.h,
                      width: MediaQuery.of(context).size.width / 1.05,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              if (index == 1) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ChangePasswordScreen(),
                                    ));
                              } else if (index == 0) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditProfileScreen(
                                          profileData: profileData,
                                          profileDatawithindex:
                                              profileDatawithindex),
                                    ));
                              } else if (index == 2) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FAQScreen(),
                                    ));
                              } else if (index == 3) {
                                for (var item in appCOnfig
                                    .redirectLoadingDetails["data"]) {
                                   if (item["key"] == "privacyLink") {
                                 //  if (item["key"] == "termsandservice") {
                                    launchwebUrl(context, item["value"]);

                                    break; // Exit loop once the "whatsappLink" is found and launched
                                  }
                                }

                                // launchwebUrl(context,
                                //     "https://www.freeprivacypolicy.com/live/6492021b-22dd-4ba3-b648-4ad1e6d3533c");
                              } else if (index == 4) {
                                for (var item in appCOnfig.redirectLoadingDetails["data"]) {
                            if (item["key"] == "termsandservice") {
                              launchwebUrl(context, item["value"]);

                              break; // Exit loop once the "whatsappLink" is found and launched
                            }
                          }
                                // launchwebUrl(context,
                                //     "https://fastxtermsofservices.blogspot.com/?m=1");
                              }

                              // else if (index == 2) {
                              //   Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) =>
                              //             const FinanceInfoScreen(),
                              //       ));
                              // }
                              else if (index == 5) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Theme(
                                      data: ThemeData(
                                        //  dialogTheme: DialogTheme(
                                          //    backgroundColor: Colors.white)
                                              ),
                                      child: AlertDialog(
                                        surfaceTintColor: Colors.white,
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              "Logout?",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            const SizedBox(
                                                height:
                                                    16.0), // Add some spacing between the text and buttons
                                            const Text(
                                              "Are you sure you want to logout?",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                            const SizedBox(
                                                height:
                                                    24.0), // Add some spacing before the buttons
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.black),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25)),
                                                    child: const Center(
                                                        child: Text('No')),
                                                  ),
                                                ),
                                                CustomButton(
                                                    height: 40,
                                                    width: 100,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    onPressed: () {
                                                      //  Perform logout
                                                      getStorage
                                                          .remove("mobilenumb");
                                                      getStorage
                                                          .remove("usertoken");
                                                      getStorage
                                                          .remove("userId");
                                                      getStorage
                                                          .remove("useremail");
                                                      getStorage
                                                          .remove("password");
                                                      getStorage
                                                          .remove("regPincode");

                                                          getStorage.remove("catres");
                                                      userId = '';
                                                      usertoken = '';
                                                      mobilenumb = '';
                                                      useremail = '';
                                                      password = '';
                                                      regPincode = '';
                                                      catres = '';

                                                      Get.offAll(() =>
                                                          WelcomeScreen());
                                                    },
                                                    child: const Text(
                                                      'Yes',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                            child: ListTile(
                              leading: Image.asset(
                                imagePaths[index],
                                width: 30,
                                height: 30,
                              ),
                              title: Row(
                                children: [
                                  Text(items[index],
                                      style: CustomTextStyle.addOnsBlackText),
                                  const Spacer(),
                                  if (index != items.length - 1)
                                    SizedBox(
                                      height: 28,
                                      width: 28,
                                      child: Image.asset(
                                          'assets/images/rightchevron.png'),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      )
    );
  }

  void launchwebUrl(BuildContext context, String url) async {
    try {
      await canLaunch(url);
      await launch(url);
      print("urllll${url}");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Something went wrong when launching URL"),
        ),
      );
      print("error");
    }
  }
}
