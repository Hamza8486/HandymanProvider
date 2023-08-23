// To parse this JSON data, do
//
//     final allJobResponse = allJobResponseFromJson(jsonString);

import 'dart:convert';

AllJobResponse allJobResponseFromJson(String str) => AllJobResponse.fromJson(json.decode(str));

String allJobResponseToJson(AllJobResponse data) => json.encode(data.toJson());

class AllJobResponse {
  AllJobResponse({
    required this.statusCode,
    required this.message,
    required  this.data,
  });

  int statusCode;
  String message;
  Data data;

  factory AllJobResponse.fromJson(Map<String, dynamic> json) => AllJobResponse(
    statusCode: json["statusCode"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.jobs,
  });

  List<Job> jobs;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    jobs: List<Job>.from(json["jobs"].map((x) => Job.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "jobs": List<dynamic>.from(jobs.map((x) => x.toJson())),
  };
}

class Job {
  Job({
    required this.id,
    required  this.subId,
    this.providerId,
    required  this.cusId,
    required this.description,
    required this.budget,
    required  this.address,
    required  this.image,
    required this.date,
    required this.status,
    required this.phoneNo,
    required this.createdAt,
    required this.updatedAt,
    required this.jobNumber,
     this.customer,
    required this.reviews,
  });

  int id;
  var subId;
  dynamic providerId;
  var cusId;
  String description;
  var budget;
  String address;
  String image;
  DateTime date;
  var status;
  String phoneNo;
  DateTime createdAt;
  DateTime updatedAt;
  var jobNumber;
  Customer ? customer;
  int reviews;

  factory Job.fromJson(Map<String, dynamic> json) => Job(
    id: json["id"],
    subId: json["sub_id"]??"",
    providerId: json["provider_id"],
    cusId: json["cus_id"]??"",
    description: json["description"]??"",
    budget: json["budget"]??"" ,
    address: json["address"]??"",
    image: json["image"]??"",
    date: DateTime.parse(json["date"]),
    status: json["status"]??"",
    phoneNo: json["phone_no"]??"",
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    jobNumber: json["job_number"]??"",
    customer: Customer.fromJson(json["customer"]),
    reviews: json["reviews"]??0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sub_id": subId,
    "provider_id": providerId,
    "cus_id": cusId,
    "description": description,
    "budget": budget ,
    "address": address,
    "image": image ,
    "date": date.toIso8601String(),
    "status": status,
    "phone_no": phoneNo,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "job_number": jobNumber,
    "customer": customer!.toJson(),
    "reviews": reviews,
  };
}

class Customer {
  Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNo,
    required this.address,
    required this.userAddress,
    required this.userLat,
    required this.userLong,
    required this.email,
    required this.image,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String firstName;
  String lastName;
  String phoneNo;
  String address;
  String userAddress;
  String userLat;
  String userLong;
  String email;
  String image;
  var userId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    firstName: json["first_name"]??"",
    lastName: json["last_name"]??"",
    phoneNo: json["phone_no"]??"",
    address: json["address"]??"",
    userAddress: json["user_address"]??"",
    userLat: json["user_lat"] ??"",
    userLong: json["user_long"]??"" ,
    email: json["email"]??"" ,
    image: json["image"]??"",
    userId: json["user_id"]??"",
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "phone_no": phoneNo,
    "address": address,
    "user_address": userAddress ,
    "user_lat": userLat ,
    "user_long": userLong ,
    "email": email ,
    "image": image ,
    "user_id": userId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
