// To parse this JSON data, do
//
//     final businessProfileResponse = businessProfileResponseFromJson(jsonString);

import 'dart:convert';

BusinessProfileResponse businessProfileResponseFromJson(String str) => BusinessProfileResponse.fromJson(json.decode(str));

String businessProfileResponseToJson(BusinessProfileResponse data) => json.encode(data.toJson());



class BusinessProfileResponse {
  int? statusCode;
  String? message;
  BusinessData? data;

  BusinessProfileResponse({this.statusCode, this.message, this.data});

  BusinessProfileResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new BusinessData.fromJson(json['data']) : null;
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

class BusinessData {
  int? id;
  String? name;
  var providerId;
  String? image;
  String? frontPassport;
  String? backPassport;
  String? dob;
  String? aboutMe;
  var status;
  String? createdAt;
  String? updatedAt;
  String? age;
  List<Services>? services;
  List<Review>? review;
 
  int? countReview;
  var rating;
  var bestOne;
  int? isTop;

  BusinessData(
      {this.id,
        this.name,
        this.providerId,
        this.image,
        this.isTop,
        this.frontPassport,
        this.review,
        this.backPassport,
        this.dob,
        this.aboutMe,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.age,
        this.services,
        this.countReview,
        this.rating,
        this.bestOne});

  BusinessData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    providerId = json['provider_id'];
    image = json['image'];
    if (json['review'] != null) {
      review = <Review>[];
      json['review'].forEach((v) {
        review!.add(new Review.fromJson(v));
      });
    }
    isTop = json['is_top'];
    frontPassport = json['front_passport'];
    backPassport = json['back_passport'];
    dob = json['dob'];
    aboutMe = json['about_me'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    age = json['age'];
    if (json['Services'] != null) {
      services = <Services>[];
      json['Services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
   
    countReview = json['countReview'];
    rating = json['rating'];
    bestOne = json['bestOne'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['provider_id'] = this.providerId;
    if (this.review != null) {
      data['review'] = this.review!.map((v) => v.toJson()).toList();
    }
    data['image'] = this.image;
    data['front_passport'] = this.frontPassport;
    data['back_passport'] = this.backPassport;
    data['dob'] = this.dob;
    data['is_top'] = this.isTop;
    data['about_me'] = this.aboutMe;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['age'] = this.age;
    if (this.services != null) {
      data['Services'] = this.services!.map((v) => v.toJson()).toList();
    }
   
    data['countReview'] = this.countReview;
    data['rating'] = this.rating;
    data['bestOne'] = this.bestOne;
    return data;
  }
}



class Review {
  var id;
  String? name;
  String? description;
  var rating;
  var image;
  var customerId;
  var providerId;
  var parentId;
  var postId;
  var jobId;
  var price;
  var status;
  String? createdAt;
  String? updatedAt;

  Review(
      {this.id,
        this.name,
        this.description,
        this.rating,
        this.image,
        this.customerId,
        this.providerId,
        this.parentId,
        this.postId,
        this.jobId,
        this.price,
        this.status,
        this.createdAt,
        this.updatedAt});

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    rating = json['rating'];
    image = json['image'];
    customerId = json['customer_id'];
    providerId = json['provider_id'];
    parentId = json['parent_id'];
    postId = json['post_id'];
    jobId = json['job_id'];
    price = json['price'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['rating'] = this.rating;
    data['image'] = this.image;
    data['customer_id'] = this.customerId;
    data['provider_id'] = this.providerId;
    data['parent_id'] = this.parentId;
    data['post_id'] = this.postId;
    data['job_id'] = this.jobId;
    data['price'] = this.price;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Services {
  var id;
  String? name;
  String? description;
  String? image;
  var price;
  var parentId;
  var subId;
  var status;
  String? createdAt;
  String? updatedAt;
  var objectId;

  Services(
      {this.id,
        this.name,
        this.description,
        this.image,
        this.price,
        this.parentId,
        this.subId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.objectId});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    price = json['price'];
    parentId = json['parent_id'];
    subId = json['sub_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    objectId = json['object_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['price'] = this.price;
    data['parent_id'] = this.parentId;
    data['sub_id'] = this.subId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['object_id'] = this.objectId;
    return data;
  }
}
