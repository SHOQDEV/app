// To parse this JSON data, do
//
//     final selectedProductsModel = selectedProductsModelFromJson(jsonString);

import 'dart:convert';

List<SelectedProductsModel> selectedProductsModelFromJson(String str) => List<SelectedProductsModel>.from(json.decode(str).map((x) => SelectedProductsModel.fromJson(x)));

String selectedProductsModelToJson(List<SelectedProductsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SelectedProductsModel {
    SelectedProductsModel({
        this.id,
        this.productId,
        this.discount,
        this.typeDiscount,
        this.quantity,
        this.price,
    });

    int? id;
    String? productId;
    double? discount;
    String? typeDiscount;
    int? quantity;
    double? price;

    SelectedProductsModel copyWith({
        int? id,
        String? productId,
        double? discount,
        String? typeDiscount,
        int? quantity,
        double? price,
    }) => 
        SelectedProductsModel(
            id: id ?? this.id,
            productId: productId ?? this.productId,
            discount: discount ?? this.discount,
            typeDiscount: typeDiscount ?? this.typeDiscount,
            quantity: quantity ?? this.quantity,
            price: price ?? this.price,
        );

    factory SelectedProductsModel.fromJson(Map<String, dynamic> json) => SelectedProductsModel(
        id: json["id"],
        productId: json["productId"],
        discount: json["discount"].toDouble(),
        typeDiscount: json["typeDiscount"],
        quantity: json["quantity"],
        price: json["price"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "discount": discount,
        "typeDiscount": typeDiscount,
        "quantity": quantity,
        "price": price,
    };
}
