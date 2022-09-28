import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Row, Stack, Column, Alignment;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:open_file/open_file.dart' as open_file;

import 'package:app_artistica/bloc/client/client_bloc.dart';
import 'package:app_artistica/bloc/invoice/invoice_bloc.dart';
import 'package:app_artistica/bloc/product_sold/product_sold_bloc.dart';
import 'package:app_artistica/components/animate.dart';
import 'package:app_artistica/components/button.dart';
import 'package:app_artistica/components/header_pages.dart';
import 'package:app_artistica/components/menu_icon.dart';
import 'package:app_artistica/database/client_model.dart';
import 'package:app_artistica/services/auth_service.dart';
import 'package:app_artistica/utils/dialog_date_picker.dart';
import 'package:app_artistica/database/invoice_model.dart';
import 'package:app_artistica/screens/navigator/profile/invoices/order_item_widget.dart';

class OperationsScreen extends StatefulWidget {
  const OperationsScreen({Key? key}) : super(key: key);
  @override
  _OperationsScreen createState() => _OperationsScreen();
}

class _OperationsScreen extends State<OperationsScreen> {
  List<DateTime> fechas = [];
  String date1 = '';
  String date2 = '';
  List<InvoicesModel> excelTable = [];
  @override
  Widget build(BuildContext context) {
    final invoiceBloc = BlocProvider.of<InvoiceBloc>(context, listen: true);
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(children: <Widget>[
            const ComponentHeader(stateBack: true, text: 'Transacciones'),
            Row(
              children: [
                ButtonWhiteComponent(
                  text: 'Filtrar por fechas',
                  onPressed: ()=>filterDate(),
                ),
                const Spacer(),
                MenuFilterRoundedComponent(
                onTap: (int value) => filterOptions(value)
              ),
              ],
            ),
            Expanded(
                child: SingleChildScrollView(
                    child: Column(
              children: [
                if(invoiceBloc.state.existInvoice)
                for (var item in invoiceBloc.state.showInvoices!)
                 OrderItemWidget(invoice: item)
              ],
            )))
          ])));
  }

  List<DateTime> calculateDaysInterval(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  filterOptions(int value) async {
    final invoiceBloc = BlocProvider.of<InvoiceBloc>(context, listen: false);
    switch (value.toString()) {
      case '0':
      invoiceBloc.add(UpdateInvoicesAnulado(!invoiceBloc.state.stateAnulado));
      invoiceBloc.add(ShowInvoices());
        break;
      case '1':
      invoiceBloc.add(UpdateInvoicesFacturado(!invoiceBloc.state.stateFacturado));
      invoiceBloc.add(ShowInvoices());
        break;
      case '2':
        generateExcel();
        break;
      default:
    }
  }

  filterDate(){
    final invoiceBloc = BlocProvider.of<InvoiceBloc>(context, listen: false);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return ComponentAnimate(child: DialogDatePicker(
            range: (String date1, String date2) async {
              fechas.clear();
              for (var item in calculateDaysInterval( DateTime.parse(date1), DateTime.parse(date2))) {
                fechas.add(item);
              }
              invoiceBloc.add(UpdateStateDate(true));
              invoiceBloc.add(UpdateDate(fechas));
              invoiceBloc.add(ShowInvoices());
              Navigator.of(context).pop();
            },
          ));
        });
  }

  Future<void> generateExcel() async {
    final invoiceBloc = BlocProvider.of<InvoiceBloc>(context, listen: false).state.showInvoices;
    final productSoldBloc = BlocProvider.of<ProductSoldBloc>(context, listen: false).state;
    final clientBloc = BlocProvider.of<ClientBloc>(context, listen: false).state;
    final authService = Provider.of<AuthService>(context, listen: false);

    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    sheet.showGridlines = false;
    sheet.enableSheetCalculations();

    sheet.getRangeByName('A1').columnWidth = 4.82;
    sheet.getRangeByName('B1').columnWidth = 13.20;
    sheet.getRangeByName('C1').columnWidth = 13.20;
    sheet.getRangeByName('D1').columnWidth = 26;
    sheet.getRangeByName('E1').columnWidth = 13.20;
    sheet.getRangeByName('F1').columnWidth = 13.20;
    sheet.getRangeByName('G1').columnWidth = 26;
    sheet.getRangeByName('H1').columnWidth = 13.20;
    sheet.getRangeByName('I1').columnWidth = 13.20;
    sheet.getRangeByName('J1').columnWidth = 13.20;

    sheet.getRangeByName('A1').cellStyle.hAlign = HAlignType.center;
    sheet.getRangeByName('B1').cellStyle.hAlign = HAlignType.center;
    sheet.getRangeByName('C1').cellStyle.hAlign = HAlignType.center;
    sheet.getRangeByName('D1').cellStyle.hAlign = HAlignType.center;
    sheet.getRangeByName('E1').cellStyle.hAlign = HAlignType.center;
    sheet.getRangeByName('F1').cellStyle.hAlign = HAlignType.center;
    sheet.getRangeByName('G1').cellStyle.hAlign = HAlignType.center;
    sheet.getRangeByName('H1').cellStyle.hAlign = HAlignType.center;
    sheet.getRangeByName('I1').cellStyle.hAlign = HAlignType.center;
    sheet.getRangeByName('J1').cellStyle.hAlign = HAlignType.justify;

    sheet.getRangeByName('A1').cellStyle.vAlign = VAlignType.center;
    sheet.getRangeByName('B1').cellStyle.vAlign = VAlignType.center;
    sheet.getRangeByName('C1').cellStyle.vAlign = VAlignType.center;
    sheet.getRangeByName('D1').cellStyle.vAlign = VAlignType.center;
    sheet.getRangeByName('E1').cellStyle.vAlign = VAlignType.center;
    sheet.getRangeByName('F1').cellStyle.vAlign = VAlignType.center;
    sheet.getRangeByName('G1').cellStyle.vAlign = VAlignType.center;
    sheet.getRangeByName('H1').cellStyle.vAlign = VAlignType.center;
    sheet.getRangeByName('I1').cellStyle.vAlign = VAlignType.center;
    sheet.getRangeByName('J1').cellStyle.vAlign = VAlignType.center;

    sheet.getRangeByName('A1').cellStyle.backColor = '#002060';
    sheet.getRangeByName('B1').cellStyle.backColor = '#002060';
    sheet.getRangeByName('C1').cellStyle.backColor = '#002060';
    sheet.getRangeByName('D1').cellStyle.backColor = '#002060';
    sheet.getRangeByName('E1').cellStyle.backColor = '#002060';
    sheet.getRangeByName('F1').cellStyle.backColor = '#002060';
    sheet.getRangeByName('G1').cellStyle.backColor = '#002060';
    sheet.getRangeByName('H1').cellStyle.backColor = '#002060';
    sheet.getRangeByName('I1').cellStyle.backColor = '#002060';
    sheet.getRangeByName('J1').cellStyle.backColor = '#002060';

    sheet.getRangeByName('A1').cellStyle.fontColor = '#F2F2F2';
    sheet.getRangeByName('B1').cellStyle.fontColor = '#F2F2F2';
    sheet.getRangeByName('C1').cellStyle.fontColor = '#F2F2F2';
    sheet.getRangeByName('D1').cellStyle.fontColor = '#F2F2F2';
    sheet.getRangeByName('E1').cellStyle.fontColor = '#F2F2F2';
    sheet.getRangeByName('F1').cellStyle.fontColor = '#F2F2F2';
    sheet.getRangeByName('G1').cellStyle.fontColor = '#F2F2F2';
    sheet.getRangeByName('H1').cellStyle.fontColor = '#F2F2F2';
    sheet.getRangeByName('I1').cellStyle.fontColor = '#F2F2F2';
    sheet.getRangeByName('J1').cellStyle.fontColor = '#F2F2F2';
    sheet.getRangeByName('A1:J1').cellStyle.bold = true;
    final Range range6 = sheet.getRangeByName('B15:G15');
    range6.cellStyle.fontSize = 10;
    range6.cellStyle.bold = true;
    //cabecera
    sheet.getRangeByIndex(1, 1).setText('N°');
    sheet.getRangeByIndex(1, 2).setText('FECHA');
    sheet.getRangeByIndex(1, 3).setText('N° DE FACTURA');
    sheet.getRangeByIndex(1, 4).setText('CUF');
    sheet.getRangeByIndex(1, 5).setText('ESTADO');
    sheet.getRangeByIndex(1, 6).setText('NIT / CI');
    sheet.getRangeByIndex(1, 7).setText('NOMBRE O RAZON SOCIAL');
    sheet.getRangeByIndex(1, 8).setText('IMPORTE TOTAL');
    sheet.getRangeByIndex(1, 9).setText('DSCTOS.');
    sheet.getRangeByIndex(1, 10).setText('IMPORTE BASE PARA CREDITO FISCAL');

    for (var i = 1; i < invoiceBloc!.length + 1; i++) {
      ClientsModel client = clientBloc.clients!
          .firstWhere((e) => e.id == invoiceBloc[i - 1].clientId);
      sheet
          .getRangeByName('A${i + 1}:J${i + 1}')
          .cellStyle
          .borders
          .all
          .lineStyle = LineStyle.medium;
      sheet.getRangeByName('A${i + 1}:J${i + 1}').cellStyle.hAlign =
          HAlignType.center;
      sheet.getRangeByName('A${i + 1}:J${i + 1}').cellStyle.vAlign =
          VAlignType.center;

      sheet.getRangeByIndex((i + 1), 1).setText(i.toString());
      sheet.getRangeByIndex((i + 1), 2).setText(invoiceBloc[i - 1].date.toString());
      sheet.getRangeByIndex((i + 1), 3).setText(invoiceBloc[i - 1].invoiceNumber);
      sheet.getRangeByIndex((i + 1), 4).setText(invoiceBloc[i - 1].cuf);
      if (invoiceBloc[i - 1].countOverrideOrReverse == 2 ||
          invoiceBloc[i - 1].countOverrideOrReverse == 4) {
        sheet.getRangeByIndex((i + 1), 5).setText('A');
        sheet.getRangeByName('A${i + 1}:J${i + 1}').cellStyle.backColor =
            '#FF0000';
      } else {
        sheet.getRangeByIndex((i + 1), 5).setText('V');
        sheet.getRangeByName('A${i + 1}:J${i + 1}').cellStyle.backColor =
            '#FFFF00';
      }

      sheet
          .getRangeByIndex((i + 1), 6)
          .setText(client.numberDocument.toString());
      sheet.getRangeByIndex((i + 1), 7).setText(client.name);
      double aux;
      double aux2 = 0.0;
      double aux3 = 0.0;
      double aux4 = 0.0;
      for (var item in productSoldBloc.soldProducts!
          .where((e) => e.invoiceId == invoiceBloc[i - 1].id)) {
        aux2 = aux2 + (item.price! * item.quantity!);
      }
      for (var item in productSoldBloc.soldProducts!
          .where((e) => e.invoiceId == invoiceBloc[i - 1].id)) {
        if (item.typeDiscount == 'PORCENTAJE') {
          aux = ((item.discount! / 100) * (item.price! * item.quantity!));
        } else {
          aux = item.discount!;
        }
        aux3 = aux3 + aux;
      }
      for (var item in productSoldBloc.soldProducts!
          .where((e) => e.invoiceId == invoiceBloc[i - 1].id)) {
        if (item.typeDiscount == 'PORCENTAJE') {
          aux = (item.price! * item.quantity!) -
              ((item.discount! / 100) * (item.price! * item.quantity!));
        } else {
          aux = (item.price! * item.quantity!) - item.discount!;
        }
        aux4 = aux4 + aux;
      }
      sheet.getRangeByIndex((i + 1), 8).setNumber(aux2);
      sheet.getRangeByIndex((i + 1), 9).setNumber(aux3);
      sheet.getRangeByIndex((i + 1), 10).setNumber(aux4);
    }
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    final Directory directory =
        await path_provider.getApplicationDocumentsDirectory();
    final String path = directory.path;
    String lastDate = DateTime.now()
        .toString()
        .replaceAll(' ', '')
        .replaceAll('/', '')
        .replaceAll(':', '')
        .replaceAll('.', '');
    var nit = await authService.readCredentialNit();
    print('$path/${nit}_$lastDate.xlsx');
    final File file = File('$path/${nit}_$lastDate.xlsx');
    await file.writeAsBytes(bytes);
    await open_file.OpenFile.open('$path/${nit}_$lastDate.xlsx');
  }
}
