import 'package:app_artistica/bloc/product/product_bloc.dart';
import 'package:app_artistica/database/product_model.dart';
import 'package:app_artistica/database/sale_product_model.dart';
// import 'package:app_artistica/providers/product_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:intl/number_symbols_data.dart' show numberFormatSymbols;

class ChildrenCardCustomer extends StatelessWidget {
  final SoldProductsModel item;
  const ChildrenCardCustomer({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rroductBloc = BlocProvider.of<ProductBloc>(context, listen: true).state;
    // final productsProvider = Provider.of<ProductsProvider>(context);
    ProductsModel product = rroductBloc.products![rroductBloc.products!.indexWhere((e) => e.id == item.productId)];
    return Table(
      
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        children: [
          TableRow(children: [
            // ignore: deprecated_member_use
            Text("Producto:", style: TextStyle(color: Theme.of(context).accentColor)),
            // ignore: deprecated_member_use
            Text(product.nombre!,style: TextStyle(color: Theme.of(context).accentColor)),
          ]),
          TableRow(children: [
            // ignore: deprecated_member_use
            Text("Precio unidad:", style: TextStyle(color: Theme.of(context).accentColor)),
            Text(product.precio.toString(),
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
            // Text(
            //                                   rroductBloc
            //                                 .products![rroductBloc
            //                                     .products!
            //                                     .indexWhere((e) =>
            //                                         e.id == item.productId)]
            //                                 .typeProduct ==
            //                             'servicios'
            //                         ? NumberFormat.decimalPattern(getCurrentLocale())
            //                                 .format(
            //                                     (item.price! * item.quantity!) -
            //                                         ((item.discount! / 100) *
            //                                             (item.price! *
            //                                                 item.quantity!))) +
            //                             ' Bs.'
            //                         : NumberFormat.decimalPattern(
            //                                     getCurrentLocale())
            //                                 .format(
            //                                     (item.price! * item.quantity!) -
            //                                         item.discount!) +
            //                             ' Bs.',
            //     // ignore: deprecated_member_use
            //     style: TextStyle(color: Theme.of(context).accentColor)),
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


class ListProductsCustomer extends StatelessWidget {
  const ListProductsCustomer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}