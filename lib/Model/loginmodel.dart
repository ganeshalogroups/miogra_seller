// To parse this JSON data, do
//
//     final loginmodel = loginmodelFromJson(jsonString);

import 'dart:convert';

Loginmodel loginmodelFromJson(String str) => Loginmodel.fromJson(json.decode(str));

String loginmodelToJson(Loginmodel data) => json.encode(data.toJson());

class Loginmodel {
    int code;
    bool status;
    String message;
    Data data;

    Loginmodel({
      required  this.code,
      required  this.status,
      required  this.message,
      required  this.data,
    });

    factory Loginmodel.fromJson(Map<String, dynamic> json) => Loginmodel(
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
    String? id;
    String? name;
    String? lastName;
    String? email;
    String? mobileNo;
    String? password;
    dynamic adminProfile;
    dynamic gstNo;
    String? uuid;
    String? subAdminType;
    List<String>? role;
    String? parentAdminUserId;
    dynamic productId;
    dynamic fcmToken;
    dynamic noOfOrdersPerMonth;
    bool? isVerified;
    bool? deleted;
    bool? status;
    String? activeStatus;
    dynamic imgUrl;
    dynamic logoUrl;
    List<dynamic>? additionalImage;
    dynamic fssaiCertificate;
    dynamic fssaiNumber;
    String? secretKey;
    dynamic lastSeen;
    dynamic aditionalContactNumber;
    Address? address;
    Map<String, bool> adminUserKyc;
    BankDetails? bankDetails;
    PaymentRisk? paymentRisk;
    bool? isRecommended;
    ServiceList? serviceList;
    dynamic instructions;
    List<dynamic>? cusineList;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    String? token;

    Data({
        this.id,
        this.name,
        this.lastName,
        this.email,
        this.mobileNo,
        this.password,
        this.adminProfile,
        this.gstNo,
        this.uuid,
        this.subAdminType,
        this.role,
        this.parentAdminUserId,
        this.productId,
        this.fcmToken,
        this.noOfOrdersPerMonth,
        this.isVerified,
        this.deleted,
        this.status,
        this.activeStatus,
        this.imgUrl,
        this.logoUrl,
        this.additionalImage,
        this.fssaiCertificate,
        this.fssaiNumber,
        this.secretKey,
        this.lastSeen,
        this.aditionalContactNumber,
        this.address,
      required  this.adminUserKyc,
        this.bankDetails,
        this.paymentRisk,
        this.isRecommended,
        this.serviceList,
        this.instructions,
        this.cusineList,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.token,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        name: json["name"],
        lastName: json["lastName"],
        email: json["email"],
        mobileNo: json["mobileNo"],
        password: json["password"],
        adminProfile: json["adminProfile"],
        gstNo: json["gstNo"],
        uuid: json["uuid"],
        subAdminType: json["subAdminType"],
        role: List<String>.from(json["role"].map((x) => x)),
        parentAdminUserId: json["parentAdminUserId"],
        productId: json["productId"],
        fcmToken: json["fcmToken"],
        noOfOrdersPerMonth: json["noOfOrdersPerMonth"],
        isVerified: json["isVerified"],
        deleted: json["deleted"],
        status: json["status"],
        activeStatus: json["activeStatus"],
        imgUrl: json["imgUrl"],
        logoUrl: json["logoUrl"],
        additionalImage: List<dynamic>.from(json["additionalImage"].map((x) => x)),
        fssaiCertificate: json["fssaiCertificate"],
        fssaiNumber: json["fssaiNumber"],
        secretKey: json["secretKey"],
        lastSeen: json["lastSeen"],
        aditionalContactNumber: json["aditionalContactNumber"],
        address: Address.fromJson(json["address"]),
        adminUserKyc: Map.from(json["adminUserKYC"]).map((k, v) => MapEntry<String, bool>(k, v)),
        bankDetails: BankDetails.fromJson(json["BankDetails"]),
        paymentRisk: PaymentRisk.fromJson(json["paymentRisk"]),
        isRecommended: json["isRecommended"],
        serviceList: ServiceList.fromJson(json["serviceList"]),
        instructions: json["instructions"],
        cusineList: List<dynamic>.from(json["cusineList"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "lastName": lastName,
        "email": email,
        "mobileNo": mobileNo,
        "password": password,
        "adminProfile": adminProfile,
        "gstNo": gstNo,
        "uuid": uuid,
        "subAdminType": subAdminType,
        "role": List<dynamic>.from(role!.map((x) => x)),
        "parentAdminUserId": parentAdminUserId,
        "productId": productId,
        "fcmToken": fcmToken,
        "noOfOrdersPerMonth": noOfOrdersPerMonth,
        "isVerified": isVerified,
        "deleted": deleted,
        "status": status,
        "activeStatus": activeStatus,
        "imgUrl": imgUrl,
        "logoUrl": logoUrl,
        "additionalImage": List<dynamic>.from(additionalImage!.map((x) => x)),
        "fssaiCertificate": fssaiCertificate,
        "fssaiNumber": fssaiNumber,
        "secretKey": secretKey,
        "lastSeen": lastSeen,
        "aditionalContactNumber": aditionalContactNumber,
        "address": address!.toJson(),
        "adminUserKYC": Map.from(adminUserKyc).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "BankDetails": bankDetails!.toJson(),
        "paymentRisk": paymentRisk!.toJson(),
        "isRecommended": isRecommended,
        "serviceList": serviceList!.toJson(),
        "instructions": instructions,
        "cusineList": List<dynamic>.from(cusineList!.map((x) => x)),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "token": token,
    };
}

class Address {
    dynamic companyName;
    dynamic fullAddress;
    dynamic street;
    dynamic city;
    dynamic state;
    dynamic country;
    String? postalCode;
    dynamic landMark;
    dynamic contactPerson;
    dynamic contactPersonNumber;
    String? addressType;
    dynamic latitude;
    dynamic longitude;
    String? region;
    dynamic houseNo;
    dynamic district;

    Address({
        this.companyName,
        this.fullAddress,
        this.street,
        this.city,
        this.state,
        this.country,
        this.postalCode,
        this.landMark,
        this.contactPerson,
        this.contactPersonNumber,
        this.addressType,
        this.latitude,
        this.longitude,
        this.region,
        this.houseNo,
        this.district,
    });

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        companyName: json["companyName"],
        fullAddress: json["fullAddress"],
        street: json["street"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        postalCode: json["postalCode"],
        landMark: json["landMark"],
        contactPerson: json["contactPerson"],
        contactPersonNumber: json["contactPersonNumber"],
        addressType: json["addressType"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        region: json["region"],
        houseNo: json["houseNo"],
        district: json["district"],
    );

    Map<String, dynamic> toJson() => {
        "companyName": companyName,
        "fullAddress": fullAddress,
        "street": street,
        "city": city,
        "state": state,
        "country": country,
        "postalCode": postalCode,
        "landMark": landMark,
        "contactPerson": contactPerson,
        "contactPersonNumber": contactPersonNumber,
        "addressType": addressType,
        "latitude": latitude,
        "longitude": longitude,
        "region": region,
        "houseNo": houseNo,
        "district": district,
    };
}

class BankDetails {
    dynamic bankName;
    dynamic acType;
    dynamic accountNumber;
    dynamic ifscCode;
    dynamic branchName;

    BankDetails({
        this.bankName,
        this.acType,
        this.accountNumber,
        this.ifscCode,
        this.branchName,
    });

    factory BankDetails.fromJson(Map<String, dynamic> json) => BankDetails(
        bankName: json["bankName"],
        acType: json["acType"],
        accountNumber: json["accountNumber"],
        ifscCode: json["ifscCode"],
        branchName: json["branchName"],
    );

    Map<String, dynamic> toJson() => {
        "bankName": bankName,
        "acType": acType,
        "accountNumber": accountNumber,
        "ifscCode": ifscCode,
        "branchName": branchName,
    };
}

class PaymentRisk {
    dynamic high;
    dynamic medium;
    dynamic low;

    PaymentRisk({
        this.high,
        this.medium,
        this.low,
    });

    factory PaymentRisk.fromJson(Map<String, dynamic> json) => PaymentRisk(
        high: json["high"],
        medium: json["medium"],
        low: json["low"],
    );

    Map<String, dynamic> toJson() => {
        "high": high,
        "medium": medium,
        "low": low,
    };
}

class ServiceList {
    dynamic foodDelivery;
    dynamic parcelDelivery;
    dynamic rideBooking;
    dynamic jobService;

    ServiceList({
        this.foodDelivery,
        this.parcelDelivery,
        this.rideBooking,
        this.jobService,
    });

    factory ServiceList.fromJson(Map<String, dynamic> json) => ServiceList(
        foodDelivery: json["foodDelivery"],
        parcelDelivery: json["parcelDelivery"],
        rideBooking: json["rideBooking"],
        jobService: json["jobService"],
    );

    Map<String, dynamic> toJson() => {
        "foodDelivery": foodDelivery,
        "parcelDelivery": parcelDelivery,
        "rideBooking": rideBooking,
        "jobService": jobService,
    };
}
