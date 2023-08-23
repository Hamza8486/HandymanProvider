// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CatModel {
  String id;
  String price;
  String name;



  CatModel({
    required this.id,
    required this.price,
    required this.name,


  });

  CatModel copyWith({
    String? id,

    var price,
    String ?name

  }) {
    return CatModel(
      id: id ?? this.id,
      price: price ?? this.price,

      name: name ?? this.name,

    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,

      'price': price,
      'name': name,

    };
  }

  factory CatModel.fromMap(Map<String, dynamic> map) {
    return CatModel(
      id: map['id'] as String,

      price: map['price'] as String,

      name: map['name'] as String,

    );
  }

  String toJson() => json.encode(toMap());

  factory CatModel.fromJson(String source) =>
      CatModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class AddToCatModel {
  CatModel catModel;

  AddToCatModel({required this.catModel});
}
