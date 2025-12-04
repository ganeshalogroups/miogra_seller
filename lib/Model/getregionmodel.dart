// To parse this JSON data, do
//
//     final getregion = getregionFromJson(jsonString);

import 'dart:convert';

Getregion getregionFromJson(String str) => Getregion.fromJson(json.decode(str));

String getregionToJson(Getregion data) => json.encode(data.toJson());

class Getregion {
    int code;
    bool status;
    String message;
    Data data;

    Getregion({
      required  this.code,
      required  this.status,
       required this.message,
       required this.data,
    });

    factory Getregion.fromJson(Map<String, dynamic> json) => Getregion(
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
       required this.totalCount,
       required this.fetchCount,
       required this.data,
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
    String? userId;
    String? regionName;
    List<String>? regionPincodes;
    dynamic regionLat;
    dynamic regionLong;
    bool? deleted;
    bool? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    VendorDetails? vendorDetails;

    Datum({
        this.id,
        this.userId,
        this.regionName,
        this.regionPincodes,
        this.regionLat,
        this.regionLong,
        this.deleted,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.vendorDetails,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        userId: json["userId"],
        regionName: json["regionName"],
        regionPincodes: List<String>.from(json["regionPincodes"].map((x) => x)),
        regionLat: json["regionLat"],
        regionLong: json["regionLong"],
        deleted: json["deleted"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        vendorDetails: VendorDetails.fromJson(json["vendorDetails"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "regionName": regionName,
        "regionPincodes": List<dynamic>.from(regionPincodes!.map((x) => x)),
        "regionLat": regionLat,
        "regionLong": regionLong,
        "deleted": deleted,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "vendorDetails": vendorDetails?.toJson(),
    };
}

class VendorDetails {
    String? id;
    String? name;
    String? lastName;
    String? email;
    String? mobileNo;
    dynamic adminProfile;
    String? uuid;

    VendorDetails({
        this.id,
        this.name,
        this.lastName,
        this.email,
        this.mobileNo,
        this.adminProfile,
        this.uuid,
    });

    factory VendorDetails.fromJson(Map<String, dynamic> json) => VendorDetails(
        id: json["_id"],
        name: json["name"],
        lastName: json["lastName"],
        email: json["email"],
        mobileNo: json["mobileNo"],
        adminProfile: json["adminProfile"],
        uuid: json["uuid"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "lastName": lastName,
        "email": email,
        "mobileNo": mobileNo,
        "adminProfile": adminProfile,
        "uuid": uuid,
    };
}
