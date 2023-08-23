// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UpdateCatModel {
  String id;
  String ? idObject;
  String price;
  String name;



  UpdateCatModel({
    required this.id,
    required this.price,
    required this.name,
     this.idObject,


  });

  UpdateCatModel copyWith({
    String? id,

    String ?price,
    String ?name,
    String ?idObject

  }) {
    return UpdateCatModel(
      id: id ?? this.id,
      price: price ?? this.price,

      name: name ?? this.name,
      idObject: idObject ?? this.idObject,

    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,

      'price': price,
      'name': name,
      'idObject': idObject,

    };
  }

  factory UpdateCatModel.fromMap(Map<String, dynamic> map) {
    return UpdateCatModel(
      id: map['id'] as String,

      price: map['price'] as String,

      name: map['name'] as String,
      idObject: map['idObject'] as String,

    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateCatModel.fromJson(String source) =>
      UpdateCatModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class UpdateToCatModel {
  UpdateCatModel updateCatModel;

  UpdateToCatModel({required this.updateCatModel});
}
