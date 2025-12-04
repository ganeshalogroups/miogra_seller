// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:miogra_seller/Constants/const_variables.dart';
import 'package:miogra_seller/Controllers/FileuploadController/FileUploader.dart';
import 'package:miogra_seller/Controllers/ProfileController/profileget.dart';
import 'package:miogra_seller/Screens/Home/bottomnavigation.dart';
import 'package:miogra_seller/Validators/validator.dart';
import 'package:miogra_seller/Widgets/custom_button.dart';
import 'package:miogra_seller/Widgets/custom_container.dart';
import 'package:miogra_seller/Widgets/custom_disabledbutton.dart';
import 'package:miogra_seller/Widgets/custom_text.dart';
import 'package:miogra_seller/Widgets/custom_textformfield.dart';
import 'package:miogra_seller/Widgets/custom_textstyle.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  final dynamic profileData;
  dynamic profileDatawithindex;
  EditProfileScreen({super.key, this.profileData, this.profileDatawithindex});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  ProfilScreeenController profileController =
      Get.put(ProfilScreeenController());
  bool _isBasicExpanded = false;
  bool _isBankExpanded = false;
  bool _isAddressExpanded = false;
  TextEditingController _restNameCont = TextEditingController();
  TextEditingController _cuisinetypeCont = TextEditingController();
  TextEditingController _emailidCont = TextEditingController();
  TextEditingController _mobNumbCont = TextEditingController();
  TextEditingController _panNumbCont = TextEditingController();
  TextEditingController _gstCont = TextEditingController();
  TextEditingController _bankNameCont = TextEditingController();
  TextEditingController _accTypeCont = TextEditingController();
  TextEditingController _accNumbCont = TextEditingController();
  TextEditingController _ifscCont = TextEditingController();
  TextEditingController _pincodeCont = TextEditingController();
  TextEditingController _regionCont = TextEditingController();
  TextEditingController _cityCont = TextEditingController();
  TextEditingController _countrytypeCont = TextEditingController();
  ImageUploader fileuploader = Get.put(ImageUploader());
  bool _isFormComplete = false; // Track form completeness
  File? _pickedImage; // State to hold the picked image file
  File? _image;

  final ImagePicker _picker = ImagePicker();

  // Function to handle image selection
  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // setState(() {
      //   _pickedImage = File(pickedFile.path);
      // });
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
          _pickedImage = _image;
//            isTyping = true;
        });

        await fileuploader.uploadImage(file: _image).then((value) {
          //  _updateFormState();
          setState(() {
            _isFormComplete = true;
            // isUploading = false;
          });
        });
      } else {}
    }
  }

  @override
  void initState() {
    _restNameCont = TextEditingController(
        text: widget.profileData['name']?.toString() ?? '');
    // _cuisinetypeCont = TextEditingController(
    //     text: widget.profileData["cusineList"]?[0]['foodCusineName']
    //             ?.toString() ??
    //         '');
    _cuisinetypeCont = TextEditingController(
      text: (widget.profileData["cusineList"] != null &&
              widget.profileData["cusineList"].isNotEmpty)
          ? widget.profileData["cusineList"]
              .map((cuisine) => cuisine['foodCusineName'].toString())
              .join(', ') // Join multiple cuisines with a comma
          : 'No Cuisine Selected',
    );
    print("_cuisinetypeCont${_cuisinetypeCont}");
    _emailidCont = TextEditingController(
        text: widget.profileData['email']?.toString() ?? '');
    _panNumbCont = TextEditingController(
        text:
            widget.profileData['adminUserKYC']?['idProofNumber']?.toString() ??
                '');
    _gstCont = TextEditingController(
        text: widget.profileData['adminUserKYC']?['gstInNumber']?.toString() ??
            '');
    _mobNumbCont = TextEditingController(
        text: widget.profileData['mobileNo']?.toString() ?? '');
    _bankNameCont = TextEditingController(
        text: widget.profileData['BankDetails']?["bankName"]?.toString() ?? '');
    _accTypeCont = TextEditingController(
        text: widget.profileData['BankDetails']?["acType"]?.toString() ?? '');
    _ifscCont = TextEditingController(
        text: widget.profileData['BankDetails']?["ifscCode"]?.toString() ?? '');

    _pincodeCont = TextEditingController(
        text: widget.profileData['address']?["postalCode"]?.toString() ?? '');
    _regionCont = TextEditingController(
        text: widget.profileData['address']?["region"]?.toString() ?? '');
    _countrytypeCont = TextEditingController(
        text: widget.profileData['address']?["country"]?.toString() ?? '');
    _accNumbCont = TextEditingController(
        text: widget.profileData['BankDetails']?['accountNumber'].toString() ??
            '');
    _cityCont = TextEditingController(
        text: widget.profileData['address']?["city"]?.toString() ?? '');

    fileuploader.imageURL.value = "null";
    super.initState();
  }

  final formkey = GlobalKey<FormState>();

  bool isFormComplete() {
    return _restNameCont.text.isNotEmpty &&
        _cuisinetypeCont.text.isNotEmpty &&
        _emailidCont.text.isNotEmpty &&
        _mobNumbCont.text.isNotEmpty &&
        _panNumbCont.text.isNotEmpty &&
        _gstCont.text.isNotEmpty &&
        _bankNameCont.text.isNotEmpty &&
        _accTypeCont.text.isNotEmpty &&
        _accNumbCont.text.isNotEmpty &&
        _ifscCont.text.isNotEmpty &&
        _pincodeCont.text.isNotEmpty &&
        _regionCont.text.isNotEmpty &&
        _cityCont.text.isNotEmpty &&
        _countrytypeCont.text.isNotEmpty;
  }

  void _updateFormState() {
    setState(() {
      _isFormComplete = isFormComplete();
    });
  }

  // void _showTypeSelectionDialog(
  //     BuildContext iconContext, TextEditingController controller) {
  //   final RenderBox renderBox = iconContext.findRenderObject() as RenderBox;
  //   final Offset offset = renderBox.localToGlobal(Offset.zero);
  //   final Size size = renderBox.size;

  //   showMenu(
  //     context: context,
  //     position: RelativeRect.fromLTRB(
  //       offset.dx + size.width, // X position: right side of the field
  //       offset.dy,
  //       offset.dx + size.width + 200, // Width of the menu
  //       offset.dy + size.height,
  //     ),
  //     items: [
  //       const PopupMenuItem(
  //         value: 'Savings',
  //         child: Text('Savings'),
  //       ),
  //       const PopupMenuItem(
  //         value: 'Current',
  //         child: Text('Current'),
  //       ),
  //     ],
  //   ).then((value) {
  //     if (value != null) {
  //       setState(() {
  //         controller.text = value;
  //       });
  //     }
  //   });
  // }

  void _showTypeSelectionDialog(
      BuildContext iconContext, TextEditingController controller) {
    final RenderBox renderBox = iconContext.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx + size.width,
        offset.dy,
        offset.dx + size.width + 200,
        offset.dy + size.height,
      ),
      items: const [
        PopupMenuItem(
          value: 'Savings',
          child: Text('Savings'),
        ),
        PopupMenuItem(
          value: 'Current',
          child: Text('Current'),
        ),
      ],
    ).then((value) {
      if (value != null) {
        setState(() {
          controller.text = value;
          _updateFormState(); // <-- ✅ IMPORTANT: Mark form as updated
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
    PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => const RestaurentBottomNavigation(
        //               initialIndex: 3,
        //             )));
     
      },
     child:
       Scaffold(
        appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
             leading: IconButton(
               icon: Icon(Icons.arrow_back, color: Colors.grey.shade600),
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const RestaurentBottomNavigation(
                //               initialIndex: 3,
                //             )));
                 Navigator.pop(context);
               },
             ),
            title: CustomText(
              text: ' Edit Profile  ',
              style: CustomTextStyle.mediumGreyText,
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      print("image:${widget.profileData["adminUserKYC"]}");
                    },
                    child: CustomText(
                        text: 'Restaurant Image',
                        style: CustomTextStyle.mediumBoldBlackText),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Stack(
                      clipBehavior:
                          Clip.none, // Allow the edit container to overflow
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: _pickedImage != null
                                ? DecorationImage(
                                    image: FileImage(_pickedImage!),
                                    fit: BoxFit.cover,
                                  )
                                : widget.profileData['imgUrl'] != null
                                    ? DecorationImage(
                                        image: NetworkImage(
                                            '$baseImageUrl${widget.profileData['imgUrl'].toString()}'),
                                        fit: BoxFit.cover,
                                      )
                                    : const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/restProf.png'),
                                        fit: BoxFit.cover,
                                      ),
                          ),
                        ),
                        Positioned(
                          right:
                              -5, // Negative value to make it overlap the right edge
                          bottom:
                              -5, // Negative value to make it overlap the bottom edge
                          child: GestureDetector(
                            onTap: () {
                              _pickImage();
                            },
                            // onTap: _pickImage,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                   
   Color(0xFFAE62E8),
 Color(0xFF623089)

                                  ],
                                ),
                              ),
                              child: Center(
                                child:
                                    Image.asset('assets/images/whiteEdit.png'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isBasicExpanded = !_isBasicExpanded;
                      });
                    },
                    child: CustomContainer(
                      backgroundColor: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      width: MediaQuery.of(context).size.width / 1,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 10, left: 10, right: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                      text: 'Basic Details',
                                      style:
                                          CustomTextStyle.mediumBoldBlackText),
                                  Icon(
                                    _isBasicExpanded
                                        ? MdiIcons.chevronUp
                                        : MdiIcons.chevronDown,
                                    color: Colors.grey.shade600,
                                  ),
                                ],
                              ),
                            ),
                            if (_isBasicExpanded)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  CustomPriceTextFormField(
                                      label: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                                text: 'Restaurant Name',
                                                style: CustomTextStyle
                                                    .greyTextFormFieldText),
                                            const TextSpan(
                                                text: ' ⁕',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 17)),
                                          ],
                                        ),
                                      ),
                                      controller: _restNameCont,
                                      onChanged: (text) {
                                        _updateFormState();
                                      },
                                      validator: validateRestaurantName),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  CustomPriceTextFormField(
                                    enabled: false,
                                    controller: _cuisinetypeCont,
                                    validator: validateName,
                                    onChanged: (text) {
                                      _updateFormState();
                                    },
                                    suffixIcon: Icon(
                                      MdiIcons.chevronDown,
                                      color: Colors.grey,
                                    ),
                                    label: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: 'Cuisine Type',
                                              style: CustomTextStyle
                                                  .greyTextFormFieldText),
                                          const TextSpan(
                                              text: ' ⁕',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 17)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  CustomPriceTextFormField(
                                    style: const TextStyle(color: Colors.black),
                                    controller: _emailidCont,
                                    validator: validateEmail,
                                    enabled: false,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    onChanged: (text) {
                                      _updateFormState();
                                    },
                                    label: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: 'Email ID',
                                              style: CustomTextStyle
                                                  .greyTextFormFieldText),
                                          const TextSpan(
                                              text: ' ⁕',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 17)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  CustomPriceTextFormField(
                                    style: const TextStyle(color: Colors.black),
                                    controller: _mobNumbCont,
                                    onChanged: (text) {
                                      _updateFormState();
                                    },
                                    enabled: false,
                                    validator: validatePhone,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    label: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: 'Mobile Number',
                                              style: CustomTextStyle
                                                  .greyTextFormFieldText),
                                          const TextSpan(
                                              text: ' ⁕',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 17)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isBankExpanded = !_isBankExpanded;
                      });
                    },
                    child: CustomContainer(
                      backgroundColor: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      width: MediaQuery.of(context).size.width / 1,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 10, left: 10, right: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                      text: 'Bank Details',
                                      style:
                                          CustomTextStyle.mediumBoldBlackText),
                                  Icon(
                                    _isBankExpanded
                                        ? MdiIcons.chevronUp
                                        : MdiIcons.chevronDown,
                                    color: Colors.grey.shade600,
                                  ),
                                ],
                              ),
                            ),
                            if (_isBankExpanded)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  CustomPriceTextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    suffixIcon: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 30.0),
                                      child: SizedBox(
                                        height: 10,
                                        width: 10,
                                        child: Image.asset(
                                            'assets/images/stepsuccess.png'),
                                      ),
                                    ),
                                    label: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: 'PAN Number',
                                              style: CustomTextStyle
                                                  .greyTextFormFieldText),
                                          const TextSpan(
                                              text: ' ⁕',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 17)),
                                        ],
                                      ),
                                    ),
                                    controller: _panNumbCont,
                                    onChanged: (text) {
                                      _updateFormState();
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter PAN number';
                                      }
                                      return validatePAN(value);
                                    },
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  CustomPriceTextFormField(
                                    style: const TextStyle(color: Colors.black),
                                    controller: _gstCont,
                                    onChanged: (text) {
                                      _updateFormState();
                                    },
                                    suffixIcon: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 30.0),
                                      child: SizedBox(
                                        height: 10,
                                        width: 10,
                                        child: Image.asset(
                                            'assets/images/stepsuccess.png'),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter GST number';
                                      }
                                      return validateGST(value);
                                    },
                                    label: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: 'GST',
                                              style: CustomTextStyle
                                                  .greyTextFormFieldText),
                                          const TextSpan(
                                              text: ' ⁕',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 17)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  CustomPriceTextFormField(
                                    style: const TextStyle(color: Colors.black),
                                    controller: _bankNameCont,
                                    validator: validateBankName,
                                    onChanged: (text) {
                                      _updateFormState();
                                    },
                                    label: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: 'Bank Name',
                                              style: CustomTextStyle
                                                  .greyTextFormFieldText),
                                          const TextSpan(
                                              text: ' ⁕',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 17)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Builder(
                                    builder: (iconContext) {
                                      return CustomTypeTextFormField(
                                      readOnly: true,
                                        controller: _accTypeCont,
                                        onChanged: (text) {
                                          _updateFormState();
                                        },
                                        onTap: () => _showTypeSelectionDialog(
                                            iconContext, _accTypeCont),
                                        validator: validateName,
                                        suffixIcon: Icon(
                                          MdiIcons.chevronDown,
                                          color: Colors.grey,
                                        ),
                                        label: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: 'Account Type',
                                                  style: CustomTextStyle
                                                      .greyTextFormFieldText),
                                              const TextSpan(
                                                  text: ' ⁕',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 17)),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  CustomPriceTextFormField(
                                    style: const TextStyle(color: Colors.black),
                                    controller: _accNumbCont,
                                    validator: validateAccountNumber,
                                    onChanged: (text) {
                                      _updateFormState();
                                    },
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    label: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: 'Account Number',
                                              style: CustomTextStyle
                                                  .greyTextFormFieldText),
                                          const TextSpan(
                                              text: ' ⁕',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 17)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  CustomPriceTextFormField(
                                    style: const TextStyle(color: Colors.black),
                                    controller: _ifscCont,
                                    validator: validateIFSC,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    onChanged: (text) {
                                      _updateFormState();
                                    },
                                    label: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: 'Ifsc Code',
                                              style: CustomTextStyle
                                                  .greyTextFormFieldText),
                                          const TextSpan(
                                              text: ' ⁕',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 17)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isAddressExpanded = !_isAddressExpanded;
                      });
                    },
                    child: CustomContainer(
                      backgroundColor: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      width: MediaQuery.of(context).size.width / 1,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 10, left: 10, right: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                      text: 'Address Details',
                                      style:
                                          CustomTextStyle.mediumBoldBlackText),
                                  Icon(
                                    _isAddressExpanded
                                        ? MdiIcons.chevronUp
                                        : MdiIcons.chevronDown,
                                    color: Colors.grey.shade600,
                                  ),
                                ],
                              ),
                            ),
                            if (_isAddressExpanded)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  CustomPriceTextFormField(
                                    controller: _pincodeCont,
                                    validator: validatePinCode,
                                    enabled: false,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    onChanged: (text) {
                                      _updateFormState();
                                    },
                                    suffixIcon: Icon(
                                      MdiIcons.chevronDown,
                                      color: Colors.grey,
                                    ),
                                    label: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: 'Pincode',
                                              style: CustomTextStyle
                                                  .greyTextFormFieldText),
                                          const TextSpan(
                                              text: ' ⁕',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 17)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  CustomPriceTextFormField(
                                    controller: _regionCont,
                                    validator: validateRegion,
                                    enabled: false,
                                    onChanged: (text) {
                                      _updateFormState();
                                    },
                                    suffixIcon: Icon(
                                      MdiIcons.chevronDown,
                                      color: Colors.grey,
                                    ),
                                    label: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: 'Region',
                                              style: CustomTextStyle
                                                  .greyTextFormFieldText),
                                          const TextSpan(
                                              text: ' ⁕',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 17)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  CustomPriceTextFormField(
                                    style: const TextStyle(color: Colors.black),
                                    controller: _cityCont,
                                    enabled: false,
                                    validator: validateCity,
                                    onChanged: (text) {
                                      _updateFormState();
                                    },
                                    label: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: 'City',
                                              style: CustomTextStyle
                                                  .greyTextFormFieldText),
                                          const TextSpan(
                                              text: ' ⁕',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 17)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  CustomPriceTextFormField(
                                    style: const TextStyle(color: Colors.black),
                                    enabled: false,
                                    controller: _countrytypeCont,
                                    onChanged: (text) {
                                      _updateFormState();
                                    },
                                    validator: validateCountry,
                                    label: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: 'Country',
                                              style: CustomTextStyle
                                                  .greyTextFormFieldText),
                                          const TextSpan(
                                              text: ' ⁕',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 17)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _isFormComplete
                      ? CustomButton(
                          borderRadius: BorderRadius.circular(5),
                          height: MediaQuery.of(context).size.height / 24,
                          width: MediaQuery.of(context).size.width / 2.1,
                          onPressed: () {
                            print(fileuploader.imageURL);
                            if (formkey.currentState!.validate()) {
                              profileController.updateProfile(
                                  thumbUrl: fileuploader.imageURL.toString() ==
                                          "null"
                                      ? widget.profileData["imgUrl"].toString()
                                      : fileuploader.imageURL.toString(),
                                  mediumUrl: fileuploader.imageURL.toString() ==
                                          "null"
                                      ? widget.profileData["imgUrl"].toString()
                                      : fileuploader.imageURL.toString(),
                                  username: _restNameCont.text,
                                  imgUrl: fileuploader.imageURL.toString() ==
                                          "null"
                                      ? widget.profileData["imgUrl"].toString()
                                      : fileuploader.imageURL.toString(),
                                  bankName: _bankNameCont.text,
                                  accountNo: _accNumbCont.text,
                                  accountType: _accTypeCont.text.toLowerCase(),
                                  ifscCode: _ifscCont.text,
                                  panNo: _panNumbCont.text,
                                  gstNo: _gstCont.text,
                                  profileData: widget.profileData);
                            }
                          },
                          child: CustomText(
                            text: 'Update',
                            style: CustomTextStyle.mediumWhiteText,
                          ))
                      : CustomdisabledButton(
                          borderRadius: BorderRadius.circular(5),
                          height: MediaQuery.of(context).size.height / 23,
                          width: MediaQuery.of(context).size.width / 2,
                          onPressed: () {
                            if (formkey.currentState!.validate()) {}
                          },
                          child: Text(
                            'Update',
                            style: CustomTextStyle.mediumGreyButText,
                          )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
