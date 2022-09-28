import 'package:app_artistica/bloc/product/product_bloc.dart';
import 'package:app_artistica/bloc/product_sold/product_sold_bloc.dart';
import 'package:app_artistica/database/client_model.dart';
import 'package:app_artistica/database/invoice_model.dart';
import 'package:app_artistica/utils/convert_number_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart' show NumberFormat;
import 'package:intl/number_symbols_data.dart' show numberFormatSymbols;
import 'package:provider/provider.dart';

  writeOnPdf(BuildContext context,InvoicesModel invoice,ClientsModel client, String nit){
    final productBloc = BlocProvider.of<ProductBloc>(context,listen:false).state;
    final productSoldBloc = BlocProvider.of<ProductSoldBloc>(context,listen:false).state;
    // final productBloc = BlocProvider.of<ProductBloc>(contextW,listen:false).state;
    final productosVendidos = productSoldBloc.soldProducts!.where((e)=>e.invoiceId==invoice.id);
    final pdf = pw.Document();
    String str = invoice.totalAmount!.toStringAsFixed(2);
    var arr = str.split('.');
    int montoTotal = int.parse(arr[0]);
    String montoDecimalTotal = arr[1];

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat(
          10 * PdfPageFormat.cm,
          ((25 * PdfPageFormat.cm) + (productosVendidos.length * 17)+((('\n'.allMatches(invoice.publicity!).length)+1)*12)),
          marginAll: 0.3 * PdfPageFormat.cm),
        margin: const pw.EdgeInsets.all(15),
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Center(
                child:
            pw.Text(invoice.companyName!,
                    textAlign: pw.TextAlign.center,
                    style: const pw.TextStyle(fontSize: 7))),
            pw.Center(child:
                        pw.Text("Casa Matriz",
                        textAlign: pw.TextAlign.center,
                        style: const pw.TextStyle(fontSize: 7))),
            pw.Center(child:
                        pw.Text(invoice.address!,
                        textAlign: pw.TextAlign.center,
                        style: const pw.TextStyle(fontSize: 7))),
            pw.Center(child:
                        pw.Text("Tel. ${invoice.telephone}",
                        textAlign: pw.TextAlign.center,
                        style: const pw.TextStyle(fontSize: 7))),
            pw.Center(child:
                        pw.Text(invoice.municipality!,
                        textAlign: pw.TextAlign.center,
                        style: const pw.TextStyle(fontSize: 7))),
            pw.Center(child: 
                        pw.Text("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                        style: const pw.TextStyle(fontSize: 7))),
            pw.Table.fromTextArray(
                border: null,
                cellAlignment: pw.Alignment.bottomRight,
                headerStyle: const pw.TextStyle(fontSize: 7),
                // cellPadding: null,
                cellAlignments: {0: pw.Alignment.center},
                cellStyle: const pw.TextStyle(
                  fontSize: 7,
                ),
                data: <List<String>>[
                  <String>["NIT: $nit"],
                  <String>["Nº FACTURA: ${invoice.invoiceNumber}"],
                  <String>["CUF: ${invoice.cuf}"],
                ]),
            pw.Center(child:
                        pw.Text("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                        style: const pw.TextStyle(fontSize: 7))),
            pw.Center(child:
                        pw.Text("FACTURA", style: const pw.TextStyle(fontSize: 7))),
            pw.Center(child:
                        pw.Text("(Con Derecho a Crédito Fiscal)",
                        style: const pw.TextStyle(fontSize: 7))),
            pw.Center(child:
                        pw.Text("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                        style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold))),
            _contentTable(context,
                client.numberDocument.toString(),
                client.name!,
                invoice.date.toString(),
                '${client.name}-${client.numberDocument}'),
            pw.Center(child:
                        pw.Text("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                        style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold))),
            pw.Center(child:
                        pw.Text("DETALLE", style: const pw.TextStyle(fontSize: 7))),
            for (var item in productosVendidos)
             _contentDetalleTable(productBloc,context, item),
            pw.Center(child:
                        pw.Text("..................................................................................................................",
                        style: const pw.TextStyle(fontSize: 7))),
            _contentTotalTable(context,invoice),
            pw.Text("SON: ${convert(montoTotal)} $montoDecimalTotal/100 BOLIVIANOS",
                style: const pw.TextStyle(fontSize: 7)),
            pw.Center(child: 
                      pw.Text("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                    style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold))),
            pw.SizedBox(height: 15),
            pw.Center(child:
                        pw.Text("ESTA FACTURA CONTRIBUYE AL DESARROLLO DEL PAÍS, EL USO ILÍCITO SERÁ SANCIONADO PENALMENTE DE ACUERDO A LEY",
                        textAlign: pw.TextAlign.center,style: const pw.TextStyle(fontSize: 7))),
            pw.SizedBox(height: 5),
            pw.Center(child:
                        pw.Text(invoice.legend!,
                        textAlign: pw.TextAlign.center,style: const pw.TextStyle(fontSize: 7))),
            pw.SizedBox(height: 5),
            pw.Center(child:
                        pw.Text("Este documento es una impresión de un Documento Digital emitido en una Modalidad de Facturación en Línea. La información podrá ser verificada a través del Código QR que forma parte del formato de la representación",
                        textAlign: pw.TextAlign.center,style: const pw.TextStyle(fontSize: 7))),
            pw.SizedBox(height: 15),
            pw.Center(child:
                        pw.BarcodeWidget(data: invoice.urlQr!,
                        width: 80,
                        height: 80,
                        barcode: pw.Barcode.qrCode()),
            ),
            pw.SizedBox(height: 15),
            pw.Center(child:
                        pw.Text(invoice.publicity!,
                        textAlign: pw.TextAlign.center,
                        style: const pw.TextStyle(fontSize: 7))),
          ];
        },
      )
    );
    return pdf;
  }
  pw.Widget _contentTable(pw.Context context, String documento,String nombreCliente, String fecha, String codigoCliente) {
    return pw.Table.fromTextArray(
        border: null,
        cellAlignment: pw.Alignment.centerLeft,
        headerStyle: const pw.TextStyle(fontSize: 7),
        // cellPadding:EdgeInsets.all(0),
        cellAlignments: {
          0: pw.Alignment.centerRight,
          1: pw.Alignment.centerLeft},
        cellStyle: const pw.TextStyle(fontSize: 7),
        data: <List<String>>[
          <String>['FECHA DE EMISIÓN:    ',fecha],
          <String>['NIT / CI:    ',documento],
          <String>['SEÑOR(ES):   ',nombreCliente],
          <String>['COD. CLIENTE:    ',codigoCliente],
        ]);
  }
  pw.Widget _contentDetalleTable(productBloc,pw.Context context, item) {
    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      // cellPadding: null,
      headerStyle: const pw.TextStyle(fontSize: 7),
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerRight},
      cellStyle: const pw.TextStyle(fontSize: 7),
      data: <List<String>>[
        <String>[item.productId.toString()+'='+deleteCharacterPDF(productBloc.products![productBloc.products!.indexWhere((e)=>e.id==item.productId)].title!)],
        <String>[
          item.typeDiscount=='PORCENTAJE'?
          item.quantity.toString() +' X ' +NumberFormat.decimalPattern(getCurrentLocale()).format(item.price) + ' - ' + ((item.discount*(item.quantity*item.price))/100).toString():
          item.quantity.toString() +' X ' +NumberFormat.decimalPattern(getCurrentLocale()).format(item.price) + ' - ' + item.discount.toString(),
          item.typeDiscount=='PORCENTAJE'?
          NumberFormat.decimalPattern(getCurrentLocale()).format((item.quantity*item.price)-((item.discount*(item.quantity*item.price))/100)):
          NumberFormat.decimalPattern(getCurrentLocale()).format((item.quantity*item.price)-item.discount)
          ],
      ],
    );
  }
  pw.Widget _contentTotalTable(pw.Context context,InvoicesModel invoice) {
    return pw.Table.fromTextArray(
        border: null,
        cellAlignment: pw.Alignment.centerLeft,
        headerStyle: const pw.TextStyle(
          fontSize: 7,
        ),
        // cellPadding: null,
        cellAlignments: {
          0: pw.Alignment.centerRight,
          1: pw.Alignment.centerRight,
        },
        cellStyle: const pw.TextStyle(
          fontSize: 7,
        ),
        data: <List<String>>[
          <String>['Subtotal Bs.',NumberFormat.decimalPattern(getCurrentLocale()).format(invoice.totalAmount)],
          <String>['(Importe válido para crédito fiscal)'],
          <String>['Total a Pagar ',NumberFormat.decimalPattern(getCurrentLocale()).format(invoice.totalAmount)],
        ]);
  }
   String deleteCharacterPDF(String str){
    final RegExp reg = RegExp(r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');
    if(str.contains(reg)){str = str.replaceAll(reg,'');}
     return str;
 }
   String getCurrentLocale() {
    const locale = Locale('es', 'ES');
    final joined = "${locale.languageCode}_${locale.countryCode}";
    if (numberFormatSymbols.keys.contains(joined)) {
      return joined;
    }
    return locale.languageCode;
  }