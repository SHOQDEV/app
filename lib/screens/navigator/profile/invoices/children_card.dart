import 'package:app_artistica/bloc/product/product_bloc.dart';
import 'package:app_artistica/database/product_model.dart';
import 'package:app_artistica/database/sale_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:intl/number_symbols_data.dart' show numberFormatSymbols;

class ChildrenCard extends StatelessWidget {
  final SoldProductsModel item;
  const ChildrenCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context, listen: true).state;
    // final productsProvider = Provider.of<ProductsProvider>(context);
    ProductsModel infoproductsProvider = productBloc.products![productBloc.products!.indexWhere((e) => e.id == item.productId)];
    return Table(
      
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        children: [
          TableRow(children: [
            // ignore: deprecated_member_use
            Text("Producto:", style: TextStyle(color: Theme.of(context).accentColor)),
            // ignore: deprecated_member_use
            Text(infoproductsProvider.nombre!,style: TextStyle(color: Theme.of(context).accentColor)),
          ]),
          TableRow(children: [
            // ignore: deprecated_member_use
            Text("Precio unidad:", style: TextStyle(color: Theme.of(context).accentColor)),
            Text(infoproductsProvider.precio.toString(),
                // ignore: deprecated_member_use
                style: TextStyle(color: Theme.of(context).accentColor)),
          ]),
          TableRow(children: [
            // ignore: deprecated_member_use
            Text("Cantidad:", style: TextStyle(color: Theme.of(context).accentColor)),
            Text(item.quantity.toString(),
                // ignore: deprecated_member_use
                style: TextStyle(color: Theme.of(context).accentColor)),
          ]),
          TableRow(children: [
            // ignore: deprecated_member_use
            Text("Descuento:", style: TextStyle(color: Theme.of(context).accentColor)),
            Text(item.typeDiscount == 'PORCENTAJE'? NumberFormat.decimalPattern(getCurrentLocale()).format(item.discount) +' %': NumberFormat.decimalPattern(getCurrentLocale()).format(item.discount) +' Bs.',
                // ignore: deprecated_member_use
                style: TextStyle(color: Theme.of(context).accentColor)),
          ]),
          TableRow(children: [
            // ignore: deprecated_member_use
            Text("Sub total:", style: TextStyle(color: Theme.of(context).accentColor)),
          //             if(item.typeDiscount=='MONTO')
          // item.quantity.toString() +' X ' +NumberFormat.decimalPattern(getCurrentLocale()).format(item.price) + ' - ' + item.discount.toString(),
          // if(item.typeDiscount=='PORCENTAJE')
          // item.quantity.toString() +' X ' +NumberFormat.decimalPattern(getCurrentLocale()).format(item.price) + ' - ' + ((item.discount*(item.quantity*item.price))/100).toString(),
          // if(item.typeDiscount=='MONTO')
          // NumberFormat.decimalPattern(getCurrentLocale()).format((item.quantity*item.price)-item.discount),
          // if(item.typeDiscount=='PORCENTAJE')
          // NumberFormat.decimalPattern(getCurrentLocale()).format((item.quantity*item.price)-((item.discount*(item.quantity*item.price))/100))
            Text(item.typeDiscount == 'PORCENTAJE'
                ? NumberFormat.decimalPattern(getCurrentLocale()).format((item.price! * item.quantity!) - ((item.discount! / 100) * (item.price! * item.quantity!))) + ' Bs.'
                : NumberFormat.decimalPattern(getCurrentLocale()) .format((item.price! * item.quantity!) -item.discount!) + ' Bs.',
                // ignore: deprecated_member_use
                style: TextStyle(color: Theme.of(context).accentColor)),
          ]),
          const TableRow(children: [
            Text('-----------'),
            Text('-----------'),
          ]),
        ]);
  }
    String getCurrentLocale() {
    const locale = Locale('es', 'ES');
    final joined = "${locale.languageCode}_${locale.countryCode}";
    if (numberFormatSymbols.keys.contains(joined)) {
      return joined;
    }
    return locale.languageCode;
  }
}
