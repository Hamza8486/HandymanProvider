
import 'dart:convert';

PlaceBidResponse placeBidResponseFromJson(String str) => PlaceBidResponse.fromJson(json.decode(str));

String placeBidResponseToJson(PlaceBidResponse data) => json.encode(data.toJson());

class PlaceBidResponse {
  int? statusCode;
  String? message;

  PlaceBidResponse({this.statusCode, this.message});

  PlaceBidResponse.fromJson(Map<String, dynamic> json) {
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