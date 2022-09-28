// To parse this JSON data, do
//
//     final invoicesModel = invoicesModelFromJson(jsonString);

import 'dart:convert';

List<InvoicesModel> invoicesModelFromJson(String str) => List<InvoicesModel>.from(json.decode(str).map((x) => InvoicesModel.fromJson(x)));

String invoicesModelToJson(List<InvoicesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InvoicesModel {
    InvoicesModel({
        this.id,
        this.clientId,
        this.codeTypePayment,
        this.numberTarjet,
        this.codeCoin,
        this.exchangeRate,
        this.date,
        this.countOverrideOrReverse,
        this.reasonOverrideCode,
        this.fileInvoice,
        this.totalAmount,
        this.totalAmountSubjectToIva,
        this.totalAmountCurrency,
        this.amountGiftCard,
        this.additionalDiscount,
        this.address,
        this.telephone,
        this.municipality,
        this.invoiceNumber,
        this.cuf,
        this.legend,
        this.urlQr,
        this.publicity,
        this.companyName,
    });

    int? id;
    int? clientId;
    String? codeTypePayment;
    int? numberTarjet;
    String? codeCoin;
    double? exchangeRate;
    DateTime? date;
    int? countOverrideOrReverse;
    int? reasonOverrideCode;
    String? fileInvoice;
    double? totalAmount;
    double? totalAmountSubjectToIva;
    double? totalAmountCurrency;
    double? amountGiftCard;
    double? additionalDiscount;
    String? address;
    String? telephone;
    String? municipality;
    String? invoiceNumber;
    String? cuf;
    String? legend;
    String? urlQr;
    String? publicity;
    String? companyName;

    InvoicesModel copyWith({
        int? id,
        int? clientId,
        String? codeTypePayment,
        int? numberTarjet,
        String? codeCoin,
        double? exchangeRate,
        DateTime? date,
        int? countOverrideOrReverse,
        int? reasonOverrideCode,
        String? fileInvoice,
        double? totalAmount,
        double? totalAmountSubjectToIva,
        double? totalAmountCurrency,
        double? amountGiftCard,
        double? additionalDiscount,
        String? address,
        String? telephone,
        String? municipality,
        String? invoiceNumber,
        String? cuf,
        String? legend,
        String? urlQr,
        String? publicity,
        String? companyName,
    }) => 
        InvoicesModel(
            id: id ?? this.id,
            clientId: clientId ?? this.clientId,
            codeTypePayment: codeTypePayment ?? this.codeTypePayment,
            numberTarjet: numberTarjet ?? this.numberTarjet,
            codeCoin: codeCoin ?? this.codeCoin,
            exchangeRate: exchangeRate ?? this.exchangeRate,
            date: date ?? this.date,
            countOverrideOrReverse: countOverrideOrReverse ?? this.countOverrideOrReverse,
            reasonOverrideCode: reasonOverrideCode ?? this.reasonOverrideCode,
            fileInvoice: fileInvoice ?? this.fileInvoice,
            totalAmount: totalAmount ?? this.totalAmount,
            totalAmountSubjectToIva: totalAmountSubjectToIva ?? this.totalAmountSubjectToIva,
            totalAmountCurrency: totalAmountCurrency ?? this.totalAmountCurrency,
            amountGiftCard: amountGiftCard ?? this.amountGiftCard,
            additionalDiscount: additionalDiscount ?? this.additionalDiscount,
            address: address ?? this.address,
            telephone: telephone ?? this.telephone,
            municipality: municipality ?? this.municipality,
            invoiceNumber: invoiceNumber ?? this.invoiceNumber,
            cuf: cuf ?? this.cuf,
            legend: legend ?? this.legend,
            urlQr: urlQr ?? this.urlQr,
            publicity: publicity ?? this.publicity,
            companyName: companyName ?? this.companyName,
        );

    factory InvoicesModel.fromJson(Map<String, dynamic> json) => InvoicesModel(
        id: json["id"],
        clientId: json["clientId"],
        codeTypePayment: json["codeTypePayment"],
        numberTarjet: json["numberTarjet"],
        codeCoin: json["codeCoin"],
        exchangeRate: json["exchangeRate"].toDouble(),
        date: DateTime.parse(json["date"]),
        countOverrideOrReverse: json["countOverrideOrReverse"],
        reasonOverrideCode: json["reasonOverrideCode"],
        fileInvoice: json["fileInvoice"],
        totalAmount: json["totalAmount"].toDouble(),
        totalAmountSubjectToIva: json["totalAmountSubjectToIva"].toDouble(),
        totalAmountCurrency: json["totalAmountCurrency"].toDouble(),
        amountGiftCard: json["amountGiftCard"].toDouble(),
        additionalDiscount: json["additionalDiscount"].toDouble(),
        address: json["address"],
        telephone: json["telephone"],
        municipality: json["municipality"],
        invoiceNumber: json["invoiceNumber"],
        cuf: json["cuf"],
        legend: json["legend"],
        urlQr: json["urlQr"],
        publicity: json["publicity"],
        companyName: json["companyName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "clientId": clientId,
        "codeTypePayment": codeTypePayment,
        "numberTarjet": numberTarjet,
        "codeCoin": codeCoin,
        "exchangeRate": exchangeRate,
        "date": date!.toIso8601String(),
        "countOverrideOrReverse": countOverrideOrReverse,
        "reasonOverrideCode": reasonOverrideCode,
        "fileInvoice": fileInvoice,
        "totalAmount": totalAmount,
        "totalAmountSubjectToIva": totalAmountSubjectToIva,
        "totalAmountCurrency": totalAmountCurrency,
        "amountGiftCard": amountGiftCard,
        "additionalDiscount": additionalDiscount,
        "address": address,
        "telephone": telephone,
        "municipality": municipality,
        "invoiceNumber": invoiceNumber,
        "cuf": cuf,
        "legend": legend,
        "urlQr": urlQr,
        "publicity": publicity,
        "companyName": companyName,
    };
}
