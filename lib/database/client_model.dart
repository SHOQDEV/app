// To parse this JSON data, do
//
//     final clientsModel = clientsModelFromJson(jsonString);

import 'dart:convert';

List<ClientsModel> clientsModelFromJson(String str) => List<ClientsModel>.from(json.decode(str).map((x) => ClientsModel.fromJson(x)));

String clientsModelToJson(List<ClientsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClientsModel {
    ClientsModel({
        this.id,
        this.name,
        this.email,
        this.numberDocument,
        this.typeDocument,
        this.numberContact,
    });

    int? id;
    String? name;
    String? email;
    int? numberDocument;
    int? typeDocument;
    int? numberContact;

    ClientsModel copyWith({
        int? id,
        String? name,
        String? email,
        int? numberDocument,
        int? typeDocument,
        int? numberContact,
    }) => 
        ClientsModel(
            id: id ?? this.id,
            name: name ?? this.name,
            email: email ?? this.email,
            numberDocument: numberDocument ?? this.numberDocument,
            typeDocument: typeDocument ?? this.typeDocument,
            numberContact: numberContact ?? this.numberContact,
        );

    factory ClientsModel.fromJson(Map<String, dynamic> json) => ClientsModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        numberDocument: json["numberDocument"],
        typeDocument: json["typeDocument"],
        numberContact: json["numberContact"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "numberDocument": numberDocument,
        "typeDocument": typeDocument,
        "numberContact": numberContact,
    };
}
