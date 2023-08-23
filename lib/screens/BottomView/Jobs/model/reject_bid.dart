
import 'dart:convert';

RejectBidResponse rejectBidResponseFromJson(String str) => RejectBidResponse.fromJson(json.decode(str));

String rejectBidResponseToJson(RejectBidResponse data) => json.encode(data.toJson());

class RejectBidResponse {
  int? statusCode;
  String? message;

  RejectBidResponse({this.statusCode, this.message});

  RejectBidResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}