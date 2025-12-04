// To parse this JSON data, do
//
//     final otpmodel = otpmodelFromJson(jsonString);

import 'dart:convert';

Otpmodel otpmodelFromJson(String str) => Otpmodel.fromJson(json.decode(str));

String otpmodelToJson(Otpmodel data) => json.encode(data.toJson());

class Otpmodel {
    int? code;
    bool? status;
    String? message;
    Data? data;

    Otpmodel({
        this.code,
        this.status,
        this.message,
        this.data,
    });

    factory Otpmodel.fromJson(Map<String, dynamic> json) => Otpmodel(
        code: json["code"],
        status: json["status"],
        message: json["message"],
       data: json["data"] != null && json["data"].isNotEmpty
            ? Data.fromJson(json["data"])
            : null,
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    String? otpId;

    Data({
        this.otpId,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        otpId: json["otpId"],
    );

    Map<String, dynamic> toJson() => {
        "otpId": otpId,
    };
}
