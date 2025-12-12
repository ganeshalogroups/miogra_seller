// ignore_for_file: depend_on_referenced_packages, file_names, avoid_print

import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:miogra_seller/Constants/const_variables.dart';
import 'package:miogra_seller/UrlList/api.dart';

class ImageUploader {
  var isFileUploading = false.obs;
  var imageURL = "".obs;
  String usertoken = getStorage.read("usertoken") ?? '';
  Future uploadImage({File? file}) async {
    try {
      isFileUploading(true);
      String fileName = file!.path.split('/').last;
      String? mimeType = lookupMimeType(file.path);
      if (mimeType == null || mimeType == "application/octet-stream") {
        mimeType = "image/png";
      }

      dio.FormData formData = dio.FormData.fromMap({
        "file": await dio.MultipartFile.fromFile(
          file.path,
          filename: fileName,
          contentType: dio.DioMediaType.parse(mimeType),
        ),
      });

      var response = await dio.Dio().post(
        API.bannerUpload,
        data: formData,
        options: dio.Options(
          headers: {
            "Accept": "*/*",
            "Content-Type": "multipart/form-data",
            'Authorization': 'Bearer $usertoken',
            "userid": "$userId",
          },
        ),
      );
print("FILLLLE   UPLOADD   ${formData}");
print("AAAAAPPPPP     ${API.bannerUpload}");
      var result = response.data;
      print("file upload res ${response.statusCode}");
      if (response.statusCode == 200) {
        print(response.data["data"]["imgUrl"]);
        imageURL(response.data["data"]["imgUrl"]);
      } else {
        Get.snackbar(
          "File Upload Failed",
          "Aadhar Front......: ${result["data"]["imgUrl"]}",
        );
      }
    } catch (error) {
      // print('$error');
    } finally {
      isFileUploading(false);
    }
  }

  Future uploadReturnImage({File? file}) async {
    try {
      isFileUploading(true);
      String fileName = file!.path.split('/').last;
      String? mimeType = lookupMimeType(file.path);
      if (mimeType == null || mimeType == "application/octet-stream") {
        mimeType = "image/png";
      }

      dio.FormData formData = dio.FormData.fromMap({
        "file": await dio.MultipartFile.fromFile(
          file.path,
          filename: fileName,
          contentType: dio.DioMediaType.parse(mimeType),
        ),
      });

      var response = await dio.Dio().post(
        API.bannerUpload,
        data: formData,
        options: dio.Options(
          headers: {
            "Accept": "*/*",
            "Content-Type": "multipart/form-data",
            'Authorization': 'Bearer $usertoken',
          },
        ),
      );

      var result = response.data;
      print("file upload res ${response.statusCode}");
      if (response.statusCode == 200) {
        return response.data["data"]["imgUrl"].toString();
        // imageURL(response.data["data"]["imgUrl"]);
      } else {
        Get.snackbar(
          "File Upload Failed",
          "Aadhar Front......: ${result["data"]["imgUrl"]}",
        );
        return "null";
      }
    } catch (error) {
      // print('$error');
      return "null";
    } finally {
      isFileUploading(false);
    }
  }
}
