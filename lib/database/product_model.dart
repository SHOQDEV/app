// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

ProductsModel productsModelFromJson(String str) => ProductsModel.fromJson(json.decode(str));

String productsModelToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel {
    ProductsModel({
        this.precio,
        this.cantidad,
        this.codbarras,
        this.vendidos,
        this.id,
        this.nombre,
        this.categoriaId,
        this.descripcion,
        this.img,
        this.updatedAt,
    });

    double? precio;
    int? cantidad;
    String? codbarras;
    int? vendidos;
    String? id;
    String? nombre;
    String? categoriaId;
    String? descripcion;
    String? img;
    String? updatedAt;

    ProductsModel copyWith({
        double? precio,
        int? cantidad,
        String? codbarras,
        int? vendidos,
        String? id,
        String? nombre,
        String? categoriaId,
        String? descripcion,
        String? img,
        String? updatedAt,
    }) => 
        ProductsModel(
            precio: precio ?? this.precio,
            cantidad: cantidad ?? this.cantidad,
            codbarras: codbarras ?? this.codbarras,
            vendidos: vendidos ?? this.vendidos,
            id: id ?? this.id,
            nombre: nombre ?? this.nombre,
            categoriaId: categoriaId ?? this.categoriaId,
            descripcion: descripcion ?? this.descripcion,
            img: img ?? this.img,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        precio: json["precio"].toDouble(),
        cantidad: json["cantidad"],
        codbarras: json["codbarras"],
        vendidos: json["vendidos"],
        id: json["_id"],
        nombre: json["nombre"],
        categoriaId: json["categoriaId"],
        descripcion: json["descripcion"],
        img: json["img"],
        updatedAt: json["updatedAt"],
    );

    Map<String, dynamic> toJson() => {
        "precio": precio,
        "cantidad": cantidad,
        "codbarras": codbarras,
        "vendidos": vendidos,
        "_id": id,
        "nombre": nombre,
        "categoriaId": categoriaId,
        "descripcion": descripcion,
        "img": img,
        "updatedAt": updatedAt,
    };
}
