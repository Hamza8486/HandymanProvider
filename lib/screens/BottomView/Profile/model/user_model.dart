
// To parse this JSON data, do
//
//     final profileResponse = profileResponseFromJson(jsonString);

import 'dart:convert';

ProfileResponse profileResponseFromJson(String str) => ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) => json.encode(data.toJson());


class ProfileResponse {
  int? statusCode;
  String? message;
  ProfileModel? data;

  ProfileResponse({this.statusCode, this.message, this.data});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new ProfileModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ProfileModel {
  var id;
  String? firstName;
  String? lastName;
  String? phoneNo;
  var email;
  String? address;
  var userId;
  String? image;
  String? aboutMe;
 var subCatId;
  String? age;
  var verify;
  var favorite;
  var status;
  String? createdAt;
  String? updatedAt;

  ProfileModel(
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

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNo = json['phone_no'];
    email = json['email'];
    address = json['address'];
    userId = json['user_id'];
    image = json['image'];
    aboutMe = json['about_me'];
    subCatId = json['sub_cat_id'];
    age = json['age'];
    verify = json['verify'];
    favorite = json['favorite'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone_no'] = this.phoneNo;
    data['email'] = this.email;
    data['address'] = this.address;
    data['user_id'] = this.userId;
    data['image'] = this.image;
    data['about_me'] = this.aboutMe;
    data['sub_cat_id'] = this.subCatId;
    data['age'] = this.age;
    data['verify'] = this.verify;
    data['favorite'] = this.favorite;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
