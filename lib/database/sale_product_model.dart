// To parse this JSON data, do
//
//     final soldProductsModel = soldProductsModelFromJson(jsonString);

import 'dart:convert';

List<SoldProductsModel> soldProductsModelFromJson(String str) => List<SoldProductsModel>.from(json.decode(str).map((x) => SoldProductsModel.fromJson(x)));

String soldProductsModelToJson(List<SoldProductsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SoldProductsModel {
    SoldProductsModel({
        this.id,
        this.productId,
        this.invoiceId,
        this.discount,
        this.typeDiscount,
        this.quantity,
        this.price,
    });

    int? id;
    int? productId;
    int? invoiceId;
    double? discount;
    String? typeDiscount;
    int? quantity;
    double? price;

    SoldProductsModel copyWith({
        int? id,
        int? productId,
        int? invoiceId,
        double? discount,
        String? typeDiscount,
        int? quantity,
        double? price,
    }) => 
        SoldProductsModel(
            id: id ?? this.id,
            productId: productId ?? this.productId,
            invoiceId: invoiceId ?? this.invoiceId,
            discount: discount ?? this.discount,
            typeDiscount: typeDiscount ?? this.typeDiscount,
            quantity: quantity ?? this.quantity,
            price: price ?? this.price,
        );

    factory SoldProductsModel.fromJson(Map<String, dynamic> json) => SoldProductsModel(
        id: json["id"],
        productId: json["productId"],
        invoiceId: json["invoiceId"],
        discount: json["discount"].toDouble(),
        typeDiscount: json["typeDiscount"],
        quantity: json["quantity"],
        price: json["price"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "invoiceId": invoiceId,
        "discount": discount,
        "typeDiscount": typeDiscount,
        "quantity": quantity,
        "price": price,
    };
}
