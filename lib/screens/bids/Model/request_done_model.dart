// To parse this JSON data, do
//
//     final reqDoneResponse = reqDoneResponseFromJson(jsonString);

import 'dart:convert';

ReqDoneResponse reqDoneResponseFromJson(String str) => ReqDoneResponse.fromJson(json.decode(str));

String reqDoneResponseToJson(ReqDoneResponse data) => json.encode(data.toJson());

class ReqDoneResponse {
  ReqDoneResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  int statusCode;
  String message;
  String data;

  factory ReqDoneResponse.fromJson(Map<String, dynamic> json) => ReqDoneResponse(
    statusCode: json["statusCode"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": data,
  };
}
