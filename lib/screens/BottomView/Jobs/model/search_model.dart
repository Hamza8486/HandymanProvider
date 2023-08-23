// To parse this JSON data, do
//
//     final searchJobResponse = searchJobResponseFromJson(jsonString);

import 'dart:convert';

SearchJobResponse searchJobResponseFromJson(String str) => SearchJobResponse.fromJson(json.decode(str));

String searchJobResponseToJson(SearchJobResponse data) => json.encode(data.toJson());



class SearchJobResponse {
  int? statusCode;
  String? message;
  Data? data;

  SearchJobResponse({this.statusCode, this.message, this.data});

  SearchJobResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  List<Jobs>? jobs;

  Data({this.jobs});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['jobs'] != null) {
      jobs = <Jobs>[];
      json['jobs'].forEach((v) {
        jobs!.add(new Jobs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jobs != null) {
      data['jobs'] = this.jobs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Jobs {
  int? id;
  var subId;
  var providerId;
  var cusId;
  String? description;
  var budget;
  String? address;
  String? image;
  String? date;
  var status;
  String? phoneNo;
  DateTime? createdAt;
  DateTime? updatedAt;
  var jobNumber;
  Customer? customer;
  var reviews;

  Jobs(
      {this.id,
        this.subId,
        this.providerId,
        this.cusId,
        this.description,
        this.budget,
        this.address,
        this.image,
        this.date,
        this.status,
        this.phoneNo,
        this.createdAt,
        this.updatedAt,
        this.jobNumber,
        this.customer,
        this.reviews});

  Jobs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subId = json['sub_id'];
    providerId = json['provider_id'];
    cusId = json['cus_id'];
    description = json['description'];
    budget = json['budget'];
    address = json['address'];
    image = json['image'];
    date = json['date'];
    status = json['status'];
    phoneNo = json['phone_no'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
    jobNumber = json['job_number'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    reviews = json['reviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_id'] = this.subId;
    data['provider_id'] = this.providerId;
    data['cus_id'] = this.cusId;
    data['description'] = this.description;
    data['budget'] = this.budget;
    data['address'] = this.address;
    data['image'] = this.image;
    data['date'] = this.date;
    data['status'] = this.status;
    data['phone_no'] = this.phoneNo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['job_number'] = this.jobNumber;

      data['customer'] = this.customer!.toJson();

    data['reviews'] = this.reviews;
    return data;
  }
}

class Customer {
  int? id;
  String? firstName;
  String? lastName;
  String? phoneNo;
  String? address;
  String? userAddress;
  String? userLat;
  String? userLong;
  String? email;
  String? image;
  var userId;
  String? createdAt;
  String? updatedAt;

  Customer(
      {this.id,
        this.firstName,
        this.lastName,
        this.phoneNo,
        this.address,
        this.userAddress,
        this.userLat,
        this.userLong,
        this.email,
        this.image,
        this.userId,
        this.createdAt,
        this.updatedAt});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNo = json['phone_no'];
    address = json['address'];
    userAddress = json['user_address'];
    userLat = json['user_lat'];
    userLong = json['user_long'];
    email = json['email'];
    image = json['image']??"";
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone_no'] = this.phoneNo;
    data['address'] = this.address;
    data['user_address'] = this.userAddress;
    data['user_lat'] = this.userLat;
    data['user_long'] = this.userLong;
    data['email'] = this.email;
    data['image'] = this.image;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
