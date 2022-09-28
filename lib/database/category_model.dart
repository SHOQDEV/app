// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromJson(jsonString);

import 'dart:convert';

CategoriesModel categoriesModelFromJson(String str) => CategoriesModel.fromJson(json.decode(str));

String categoriesModelToJson(CategoriesModel data) => json.encode(data.toJson());

class CategoriesModel {
    CategoriesModel({
        this.id,
        this.nombre,
        this.updatedAt,
    });

    String? id;
    String? nombre;
    String? updatedAt;

    CategoriesModel copyWith({
        String? id,
        String? nombre,
        String? updatedAt,
    }) => 
        CategoriesModel(
            id: id ?? this.id,
            nombre: nombre ?? this.nombre,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
        id: json["id"],
        nombre: json["nombre"],
        updatedAt: json["updatedAt"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "updatedAt": updatedAt,
    };
}
