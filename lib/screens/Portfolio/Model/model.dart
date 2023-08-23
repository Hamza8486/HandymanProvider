// To parse this JSON data, do
//
//     final getPortfolioResponse = getPortfolioResponseFromJson(jsonString);

import 'dart:convert';

GetPortfolioResponse getPortfolioResponseFromJson(String str) => GetPortfolioResponse.fromJson(json.decode(str));

String getPortfolioResponseToJson(GetPortfolioResponse data) => json.encode(data.toJson());

class GetPortfolioResponse {
  GetPortfolioResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  int statusCode;
  String message;
  List<Datum> data;

  factory GetPortfolioResponse.fromJson(Map<String, dynamic> json) => GetPortfolioResponse(
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
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.proId,
  });

  int id;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  var proId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    image: json["image"]??"",
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    proId: json["pro_id"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "pro_id": proId,
  };
}
