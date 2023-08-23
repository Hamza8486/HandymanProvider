// To parse this JSON data, do
//
//     final bidListResponse = bidListResponseFromJson(jsonString);

import 'dart:convert';

BidListResponse bidListResponseFromJson(String str) => BidListResponse.fromJson(json.decode(str));

String bidListResponseToJson(BidListResponse data) => json.encode(data.toJson());


class BidListResponse {
  int? statusCode;
  String? message;
  Data? data;

  BidListResponse({this.statusCode, this.message, this.data});

  BidListResponse.fromJson(Map<String, dynamic> json) {
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
  List<Active>? active;
  List<Active>? rejected;
  List<Active>? completed;

  Data({this.active, this.rejected, this.completed});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['active'] != null) {
      active = <Active>[];
      json['active'].forEach((v) {
        active!.add(new Active.fromJson(v));
      });
    }
    if (json['rejected'] != null) {
      rejected = <Active>[];
      json['rejected'].forEach((v) {
        rejected!.add(new Active.fromJson(v));
      });
    }
    if (json['completed'] != null) {
      completed = <Active>[];
      json['completed'].forEach((v) {
        completed!.add(new Active.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.active != null) {
      data['active'] = this.active!.map((v) => v.toJson()).toList();
    }
    if (this.rejected != null) {
      data['rejected'] = this.rejected!.map((v) => v.toJson()).toList();
    }
    if (this.completed != null) {
      data['completed'] = this.completed!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Active {
  int? id;
  var subId;
  var providerId;
  var customerId;
  var jobId;
  var address;
  var image;
  String? description;
  var price;
  var status;
  var reason;
  var agree;
  String? createdAt;
  String? updatedAt;
  Job? job;
  Customer? customer;

  Active(
      {this.id,
        this.subId,
        this.providerId,
        this.customerId,
        this.jobId,
        this.address,
        this.image,
        this.description,
        this.price,
        this.status,
        this.reason,
        this.agree,
        this.createdAt,
        this.updatedAt,
        this.job,
        this.customer});

  Active.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subId = json['sub_id'];
    providerId = json['provider_id'];
    customerId = json['customer_id'];
    jobId = json['job_id'];
    address = json['address'];
    image = json['image'];
    description = json['description'];
    price = json['price'];
    status = json['status'];
    reason = json['reason'];
    agree = json['agree'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    job = json['job'] != null ? new Job.fromJson(json['job']) : null;
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_id'] = this.subId;
    data['provider_id'] = this.providerId;
    data['customer_id'] = this.customerId;
    data['job_id'] = this.jobId;
    data['address'] = this.address;
    data['image'] = this.image;
    data['description'] = this.description;
    data['price'] = this.price;
    data['status'] = this.status;
    data['reason'] = this.reason;
    data['agree'] = this.agree;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.job != null) {
      data['job'] = this.job!.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}

class Job {
  int? id;
  var subId;
  var providerId;
  var postId;
  var cusId;
  String? description;
  var budget;
  String? address;
  var image;
  var selectProvider;
  String? date;
  var status;
  var userStatus;
  String? phoneNo;
  var prove;
  String? createdAt;
  String? updatedAt;
  String? subName;

  Job(
      {this.id,
        this.subId,
        this.providerId,
        this.postId,
        this.cusId,
        this.description,
        this.budget,
        this.address,
        this.image,
        this.selectProvider,
        this.date,
        this.status,
        this.userStatus,
        this.phoneNo,
        this.prove,
        this.createdAt,
        this.updatedAt,
        this.subName});

  Job.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subId = json['sub_id'];
    providerId = json['provider_id'];
    postId = json['post_id'];
    cusId = json['cus_id'];
    description = json['description'];
    budget = json['budget'];
    address = json['address'];
    image = json['image'];
    selectProvider = json['select_provider'];
    date = json['date'];
    status = json['status'];
    userStatus = json['user_status'];
    phoneNo = json['phone_no'];
    prove = json['prove'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    subName = json['sub_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_id'] = this.subId;
    data['provider_id'] = this.providerId;
    data['post_id'] = this.postId;
    data['cus_id'] = this.cusId;
    data['description'] = this.description;
    data['budget'] = this.budget;
    data['address'] = this.address;
    data['image'] = this.image;
    data['select_provider'] = this.selectProvider;
    data['date'] = this.date;
    data['status'] = this.status;
    data['user_status'] = this.userStatus;
    data['phone_no'] = this.phoneNo;
    data['prove'] = this.prove;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['sub_name'] = this.subName;
    return data;
  }
}

class Customer {
  int? id;
  String? firstName;
  String? lastName;
  String? phoneNo;
  String? address;
  var userAddress;
  var userLat;
  var userLong;
  String? email;
  String? image;
  var userId;
  var verify;
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
        this.verify,
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
    image = json['image'];
    userId = json['user_id'];
    verify = json['verify'];
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
    data['verify'] = this.verify;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

