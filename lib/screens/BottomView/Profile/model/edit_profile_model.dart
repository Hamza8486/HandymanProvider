// To parse this JSON data, do
//
//     final profileEditResponse = profileEditResponseFromJson(jsonString);

import 'dart:convert';

ProfileEditResponse profileEditResponseFromJson(String str) => ProfileEditResponse.fromJson(json.decode(str));

String profileEditResponseToJson(ProfileEditResponse data) => json.encode(data.toJson());

class ProfileEditResponse {
  ProfileEditResponse({
    required this.statusCode,
    required this.message,
  });

  int statusCode;
  String message;

  factory ProfileEditResponse.fromJson(Map<String, dynamic> json) => ProfileEditResponse(
    statusCode: json["statusCode"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
  };
}
