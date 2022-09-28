
import 'package:app_artistica/database/invoice_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:share/share.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:intl/number_symbols_data.dart' show numberFormatSymbols;
import 'package:theme_provider/theme_provider.dart';

import 'package:app_artistica/bloc/client/client_bloc.dart';
import 'package:app_artistica/bloc/product_sold/product_sold_bloc.dart';
import 'package:app_artistica/components/button.dart';
import 'package:app_artistica/components/containers.dart';
import 'package:app_artistica/screens/navigator/profile/invoices/children_card.dart';

class OrderItemWidget extends StatefulWidget {
  final InvoicesModel invoice;
  const OrderItemWidget({Key? key, required this.invoice}) : super(key: key);
  @override
  _OrderItemWidgetState createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  @override
  Widget build(BuildContext context) {
    final productSoldBloc = BlocProvider.of<ProductSoldBloc>(context, listen: false).state;
    final clientBloc = BlocProvider.of<ClientBloc>(context, listen: false).state;
    final infoclientsProvider = clientBloc.clients!.firstWhere((e) => e.id == widget.invoice.clientId);
    final color = ThemeProvider.themeOf(context).data.hintColor;
    return ContainerComponent(
                child: ExpansionTileCard(
                    title: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.top,
                        children: [
                          TableRow(children: [
                            Text("N° de transacción:",
                                style: TextStyle(color: color)),
                            Text(widget.invoice.id.toString(),
                                style: TextStyle(color: color)),
                          ]),
                          TableRow(children: [
                            Text("Estado:",
                                style: TextStyle(color: color)),
                            widget.invoice.countOverrideOrReverse == 1 || widget.invoice.countOverrideOrReverse == 3?
                            const Text( 'Facturado',
                                style: TextStyle(color: Colors.green))
                            :const Text( 'Anulado',
                                style: TextStyle(color: Colors.red)),
                          ]),
                          TableRow(children: [
                            Text("Cliente:",
                                style: TextStyle(color: color)),
                            Text(infoclientsProvider.name!,
                                style: TextStyle(color: color)),
                          ]),
                          TableRow(children: [
                            Text("Monto total:",
                                style: TextStyle(color: color)),
                            Text('${widget.invoice.totalAmount} Bs.',
                                style: TextStyle(color: color)),
                          ]),
                          TableRow(children: [
                            Text("Fecha de emisión:",
                                style: TextStyle(color: color)),
                            Text(widget.invoice.date.toString().substring(0, 10),
                                style: TextStyle(color: color)),
                          ]),
                          TableRow(children: [
                            Text("Hora de emisión:",
                                style: TextStyle(color: color)),
                            Text(widget.invoice.date.toString().substring(11, 16),
                                style: TextStyle(color: color)),
                          ]),
                          if (widget.invoice.countOverrideOrReverse != 4)
                            TableRow(children: [
                              Container(),
                              widget.invoice.countOverrideOrReverse == 1 ||widget.invoice.countOverrideOrReverse == 3?
                              ButtonComponent(
                                text: 'Compartir',
                                onPressed: () => Share.shareFiles([widget.invoice.fileInvoice!],text: 'app_artistica'))
                              : Container(),
                            ]),
                        ]),
                    children: <Widget>[
                      for (var item in productSoldBloc.soldProducts!.where((e) => e.invoiceId == widget.invoice.id))
                        Padding(
                            padding: const EdgeInsets.all(5),
                            child: ChildrenCard(item: item)),
                        Padding(
                            padding: const EdgeInsets.all(5),
                            child: Table(
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.top,
                                children: [
                                  TableRow(children: [
                                    Text("Total:",
                                        style: TextStyle(color: color)),
                                    Text(
                                        NumberFormat.decimalPattern(getCurrentLocale()).format(widget.invoice.totalAmount),
                                        style: TextStyle(color: color)),
                                  ]),
                                ])),
                ]));
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
