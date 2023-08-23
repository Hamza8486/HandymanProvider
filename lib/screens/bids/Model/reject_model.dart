// To parse this JSON data, do
//
//     final getRejectResponse = getRejectResponseFromJson(jsonString);

import 'dart:convert';

GetRejectResponse getRejectResponseFromJson(String str) => GetRejectResponse.fromJson(json.decode(str));

String getRejectResponseToJson(GetRejectResponse data) => json.encode(data.toJson());

class GetRejectResponse {
  GetRejectResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  int statusCode;
  String message;
  List<Datum> data;

  factory GetRejectResponse.fromJson(Map<String, dynamic> json) => GetRejectResponse(
    statusCode: json["statusCode"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.subId,
    this.providerId,
    this.postId,
    required this.cusId,
    required this.description,
    this.budget,
    required this.address,
    this.image,
    required this.date,
    required  this.status,
    required  this.phoneNo,
    required  this.createdAt,
    required  this.updatedAt,
  });

  int id;
  String subId;
  dynamic providerId;
  dynamic postId;
  String cusId;
  String description;
  dynamic budget;
  String address;
  dynamic image;
  DateTime date;
  String status;
  String phoneNo;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    subId: json["sub_id"]??"",
    providerId: json["provider_id"],
    postId: json["post_id"],
    cusId: json["cus_id"]??"",
    description: json["description"]??"",
    budget: json["budget"],
    address: json["address"]??"",
    image: json["image"],
    date: DateTime.parse(json["date"]),
    status: json["status"]??"",
    phoneNo: json["phone_no"]??"",
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sub_id": subId,
    "provider_id": providerId,
    "post_id": postId,
    "cus_id": cusId,
    "description": description,
    "budget": budget,
    "address": address,
    "image": image,
    "date": date.toIso8601String(),
    "status": status,
    "phone_no": phoneNo,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
