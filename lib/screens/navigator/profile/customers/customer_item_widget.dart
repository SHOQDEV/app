import 'package:app_artistica/database/client_model.dart';
import 'package:app_artistica/database/sale_product_model.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:app_artistica/bloc/client/client_bloc.dart';
import 'package:app_artistica/bloc/invoice/invoice_bloc.dart';
import 'package:app_artistica/bloc/product_sold/product_sold_bloc.dart';
import 'package:app_artistica/components/animate.dart';
import 'package:app_artistica/components/containers.dart';
import 'package:app_artistica/components/icon_rounded.dart';
import 'package:app_artistica/dialogs/dialog_action.dart';
import 'package:app_artistica/screens/navigator/profile/customers/children_card.dart';
import 'package:flutter/material.dart';
import 'package:app_artistica/screens/navigator/profile/customers/customer_edit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerItemWidget extends StatefulWidget {
  final ClientsModel client;

  const CustomerItemWidget({Key? key, required this.client}) : super(key: key);

  @override
  _CustomerItemWidget createState() => _CustomerItemWidget();
}

class _CustomerItemWidget extends State<CustomerItemWidget> {
  @override
  Widget build(BuildContext context) {
    final invoiceBloc =
        BlocProvider.of<InvoiceBloc>(context, listen: true).state;
    final productSoldBloc =
        BlocProvider.of<ProductSoldBloc>(context, listen: true).state;
    // final invoiceProvider = Provider.of<InvoiceProvider>(context);
    // final saleProductsProvider = Provider.of<SaleProductsProvider>(context);
    return ContainerComponent(
        child: ExpansionTileCard(
            // margin: const EdgeInsets.only(top: 15),
            title: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                children: [
                  TableRow(children: [
                    Text("Nombre:",
                        style: TextStyle(
                            // ignore: deprecated_member_use
                            color: Theme.of(context).accentColor)),
                    Text(widget.client.name!,
                        style: TextStyle(
                            // ignore: deprecated_member_use
                            color: Theme.of(context).accentColor)),
                  ]),
                  if (widget.client.numberDocument != 99001 &&
                      widget.client.numberDocument != 99002 &&
                      widget.client.numberDocument != 99003)
                    TableRow(children: [
                      Text("Teléfono:",
                          style: TextStyle(
                              // ignore: deprecated_member_use
                              color: Theme.of(context).accentColor)),
                      Text(widget.client.numberContact.toString(),
                          style: TextStyle(
                              // ignore: deprecated_member_use
                              color: Theme.of(context).accentColor)),
                    ]),
                  if (widget.client.numberDocument != 99001 &&
                      widget.client.numberDocument != 99002 &&
                      widget.client.numberDocument != 99003)
                    TableRow(children: [
                      Text("Correo:",
                          style: TextStyle(
                              // ignore: deprecated_member_use
                              color: Theme.of(context).accentColor)),
                      Text(widget.client.email!,
                          style: TextStyle(
                              // ignore: deprecated_member_use
                              color: Theme.of(context).accentColor)),
                    ]),
                  if (widget.client.numberDocument != 99001 &&
                      widget.client.numberDocument != 99002 &&
                      widget.client.numberDocument != 99003)
                    TableRow(children: [
                      Text("Número de documento:",
                          style: TextStyle(
                              // ignore: deprecated_member_use
                              color: Theme.of(context).accentColor)),
                      Text(widget.client.numberDocument.toString(),
                          style: TextStyle(
                              // ignore: deprecated_member_use
                              color: Theme.of(context).accentColor)),
                    ]),
                  if (widget.client.numberDocument != 99001 &&
                      widget.client.numberDocument != 99002 &&
                      widget.client.numberDocument != 99003)
                    TableRow(children: [
                      const Text(""),
                      Row(
                        children: [
                          IconRoundedComponent(
                            onTap: () => editCustomer(),
                            icon: Icons.edit_outlined,
                            colorIcon: Colors.blue[700],
                          ),
                          const VerticalDivider(),
                          IconRoundedComponent(
                            onTap: () => deleteCustomer(),
                            icon: Icons.delete_outline_outlined,
                            colorIcon: const Color(0xFfE21C34),
                          ),
                        ],
                      )
                    ]),
                ]),
            children: <Widget>[
          if (invoiceBloc.existInvoice)
            for (var item in invoiceBloc.invoices!
                .where((e) => e.clientId == widget.client.id))
              for (SoldProductsModel listSaleProduct in productSoldBloc
                  .soldProducts!
                  .where((e) => e.invoiceId == item.id))
                // Text(listSaleProduct.id.toString())
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: ChildrenCardCustomer(item: listSaleProduct)),
        ]));
  }

  editCustomer() {
    return showDialog(
        context: context,
        builder: ((BuildContext context) {
          return ComponentAnimate(
              child: DynamicDialog(customer: widget.client));
        }));
  }

  deleteCustomer() {
    final clientBloc = BlocProvider.of<ClientBloc>(context, listen: false);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ComponentAnimate(
              child: DialogTwoAction(
                  message: '¿Desea eliminar el cliente ${widget.client.name}?',
                  messageCorrect: 'Eliminar',
                  actionCorrect: () async {
                    clientBloc.add(RemoveClient(widget.client));
                    Navigator.pop(context);
                  }));
        });
  }
}
