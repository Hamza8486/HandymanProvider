// To parse this JSON data, do
//
//     final subCatResponse = subCatResponseFromJson(jsonString);

import 'dart:convert';

SubCatResponse subCatResponseFromJson(String str) => SubCatResponse.fromJson(json.decode(str));

String subCatResponseToJson(SubCatResponse data) => json.encode(data.toJson());

class SubCatResponse {
  SubCatResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  int statusCode;
  String message;
  List<SubCatModel> data;

  factory SubCatResponse.fromJson(Map<String, dynamic> json) => SubCatResponse(
    statusCode: json["statusCode"],
    message: json["message"],
    data: List<SubCatModel>.from(json["data"].map((x) => SubCatModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SubCatModel {
  SubCatModel({
    required  this.id,
    required  this.name,
    required  this.description,
    required  this.image,
    required this.status,
    required  this.parentId,
    required  this.createdAt,
    required  this.updatedAt,
  });

  int id;
  String name;
  String description;
  String image;
  String status;
  String parentId;
  DateTime createdAt;
  DateTime updatedAt;

  factory SubCatModel.fromJson(Map<String, dynamic> json) => SubCatModel(
    id: json["id"],
    name: json["name"]??"",
    description: json["description"]??"",
    image: json["image"]??"",
    status: json["status"]??"",
    parentId: json["parent_id"]??"",
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image": image,
    "status": status,
    "parent_id": parentId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
