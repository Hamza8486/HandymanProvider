// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

// ignore_for_file: prefer_void_to_null

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  int? statusCode;
  String? message;
  Data? data;

  LoginResponse({this.statusCode, this.message, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? phoneNo;
  var email;
  String? address;
  var userId;
  var image;
  String? aboutMe;
  var subCatId;
  var age;
  String? verify;
  String? favorite;
  String? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.firstName,
        this.lastName,
        this.phoneNo,
        this.email,
        this.address,
        this.userId,
        this.image,
        this.aboutMe,
        this.subCatId,
        this.age,
        this.verify,
        this.favorite,
        this.status,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name']??"";
    lastName = json['last_name']??"";
    phoneNo = json['phone_no']??"";
    email = json['email'];
    address = json['address']??"";
    userId = json['user_id']??"";
    image = json['image']??"";
    aboutMe = json['about_me']??"";
    subCatId = json['sub_cat_id'];
    age = json['age']??"";
    verify = json['verify']??"";
    favorite = json['favorite']??"";
    status = json['status']??"";
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone_no'] = phoneNo;
    data['email'] = email;
    data['address'] = address;
    data['user_id'] = userId;
    data['image'] = image;
    data['about_me'] = aboutMe;
    data['sub_cat_id'] = subCatId;
    data['age'] = age;
    data['verify'] = verify;
    data['favorite'] = favorite;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
