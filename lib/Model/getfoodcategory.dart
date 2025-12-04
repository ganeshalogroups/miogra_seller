// To parse this JSON data, do
//
//     final foodcategory = foodcategoryFromJson(jsonString);

import 'dart:convert';

Foodcategory foodcategoryFromJson(String str) => Foodcategory.fromJson(json.decode(str));

String foodcategoryToJson(Foodcategory data) => json.encode(data.toJson());

class Foodcategory {
    int code;
    bool status;
    String message;
    Data data;

    Foodcategory({
       required this.code,
       required this.status,
       required this.message,
       required this.data,
    });

    factory Foodcategory.fromJson(Map<String, dynamic> json) => Foodcategory(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    int totalCount;
    int fetchCount;
    List<Datum> data;

    Data({
     required   this.totalCount,
      required  this.fetchCount,
      required  this.data,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalCount: json["totalCount"],
        fetchCount: json["fetchCount"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "fetchCount": fetchCount,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String? id;
    String? foodCateName;
    String? foodCateImage;
    List<String>? foodCateAdditionalImg;
    String? productCateId;
    String? foodCateTitle;
    String? foodCateDescription;
    String? foodCateType;
    String? restaurantId;
    bool? defaultStatus;
    bool? status;
    bool? deleted;
    String? foodCategoryCode;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Datum({
        this.id,
        this.foodCateName,
        this.foodCateImage,
        this.foodCateAdditionalImg,
        this.productCateId,
        this.foodCateTitle,
        this.foodCateDescription,
        this.foodCateType,
        this.restaurantId,
        this.defaultStatus,
        this.status,
        this.deleted,
        this.foodCategoryCode,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        foodCateName: json["foodCateName"],
        foodCateImage: json["foodCateImage"],
        foodCateAdditionalImg: List<String>.from(json["foodCateAdditionalImg"].map((x) => x)),
        productCateId: json["productCateId"],
        foodCateTitle: json["foodCateTitle"],
        foodCateDescription: json["foodCateDescription"],
        foodCateType: json["foodCateType"],
        restaurantId: json["restaurantId"],
        defaultStatus: json["defaultStatus"],
        status: json["status"],
        deleted: json["deleted"],
        foodCategoryCode: json["foodCategoryCode"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "foodCateName": foodCateName,
        "foodCateImage": foodCateImage,
        "foodCateAdditionalImg": List<dynamic>.from(foodCateAdditionalImg!.map((x) => x)),
        "productCateId": productCateId,
        "foodCateTitle": foodCateTitle,
        "foodCateDescription": foodCateDescription,
        "foodCateType": foodCateType,
        "restaurantId": restaurantId,
        "defaultStatus": defaultStatus,
        "status": status,
        "deleted": deleted,
        "foodCategoryCode": foodCategoryCode,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
    };
}
