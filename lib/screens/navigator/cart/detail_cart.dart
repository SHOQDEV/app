
import 'package:app_artistica/bloc/product/product_bloc.dart';
import 'package:app_artistica/bloc/selected_product/selected_product_bloc.dart';
import 'package:app_artistica/components/animate.dart';
import 'package:app_artistica/components/containers.dart';
import 'package:app_artistica/components/icon_rounded.dart';
import 'package:app_artistica/components/menu_icon.dart';
import 'package:app_artistica/database/db_provider.dart';
import 'package:app_artistica/database/product_model.dart';
import 'package:app_artistica/dialogs/dialog_action.dart';
import 'package:app_artistica/screens/navigator/cart/discount/dialog_discount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:intl/number_symbols_data.dart' show numberFormatSymbols;

import 'package:theme_provider/theme_provider.dart';

class DetailCart extends StatefulWidget {
  final SelectedProductsModel selectedProduct;
  final Function() delete;
  final Function(String, num) agreeDiscount;
  final Function() desagreeDiscount;
  const DetailCart(
      {Key? key,
      required this.selectedProduct,
      required this.delete,
      required this.agreeDiscount,
      required this.desagreeDiscount})
      : super(key: key);

  @override
  _DetailCartState createState() => _DetailCartState();
}

class _DetailCartState extends State<DetailCart> {
  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context).state;
    final product = productBloc.products!.firstWhere((e) => e.id == widget.selectedProduct.productId);
    return ContainerComponent(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right:5),
                  child:
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(product.img!,
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: MediaQuery.of(context).size.width * 0.35,
                      gaplessPlayback: true,
                      fit: BoxFit.cover),
                )),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(product.nombre!),
                          ),
                          MenuIconRoundedComponent(
                            discount: widget.selectedProduct.discount! > 0?true:false,
                            onTap: (int value) => selectMenu( value, product.nombre! ),
                            icon: Icons.more_vert_sharp
                          )
                        ],
                      ),
                      Text(
                        "Precio: " + NumberFormat.decimalPattern(getCurrentLocale()).format(product.precio) + ' Bs.',
                      ),
                      if (widget.selectedProduct.typeDiscount == 'MONTO'||widget.selectedProduct.typeDiscount == 'PORCENTAJE')
                      RichText(
                          text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "Descuento: ",
                            style: TextStyle(
                                color: ThemeProvider.themeOf(context)
                                    .data
                                    // ignore: deprecated_member_use
                                    .accentColor)),
                        if (widget.selectedProduct.typeDiscount == 'MONTO')
                          TextSpan(
                              text: 
                                  NumberFormat.decimalPattern(getCurrentLocale()).format(widget.selectedProduct.discount) +
                                  ' Bs.',
                              style: const TextStyle(color: Colors.red)),
                        if (widget.selectedProduct.typeDiscount == 'PORCENTAJE')
                          TextSpan(
                              text:
                                  NumberFormat.decimalPattern(getCurrentLocale()).format(widget.selectedProduct.discount) +
                                  ' %',
                              style: const TextStyle(color: Colors.red))
                      ])),
                      Row(
                        children: [
                          Expanded(child: Row(
                            children: [

                          IconRoundedComponent(
                            onTap: () => decreaseSerieORImei(product, widget.selectedProduct),
                            icon: Icons.remove,
                          ),
                          Text(widget.selectedProduct.quantity.toString(),style: const TextStyle(fontWeight: FontWeight.bold)),
                          IconRoundedComponent(
                            onTap: ()  => increaseSerieORImei(product, widget.selectedProduct),
                            icon: Icons.add,
                          ),
                            ],
                          )),
                          Column(
                            crossAxisAlignment : CrossAxisAlignment.end,
                            children: [
                              if (widget.selectedProduct.typeDiscount == 'MONTO'||widget.selectedProduct.typeDiscount == 'PORCENTAJE')
                              Text(NumberFormat.decimalPattern(getCurrentLocale()).format(widget.selectedProduct.quantity! * product.precio!) + ' Bs.',
                                style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold)),
                              if (widget.selectedProduct.typeDiscount != 'PORCENTAJE')                  
                              Text(NumberFormat.decimalPattern(getCurrentLocale()).format((widget.selectedProduct.quantity! * product.precio!) - widget.selectedProduct.discount!) + ' Bs.',
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                              if (widget.selectedProduct.typeDiscount == 'PORCENTAJE')
                              Text(
                                NumberFormat.decimalPattern(getCurrentLocale()).format((widget.selectedProduct.quantity! * product.precio!) - ((widget.selectedProduct.discount! / 100) * (widget.selectedProduct.quantity! * product.precio!))) + ' Bs.',
                                  style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ));
  }

  selectMenu(int value, String title ) {
    switch (value.toString()) {
      //Agregar descuento
      case '1':
        if (widget.selectedProduct.discount! > 0) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return ComponentAnimate(
                  child:DialogTwoAction(
                      message: 'Desea eliminar el descuento de $title',
                      messageCorrect: 'Eliminar',
                      actionCorrect: () => widget.desagreeDiscount()
                       ));
            });
        }else{
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ComponentAnimate(
                  child:DialogDiscout(
                      price: (widget.selectedProduct.price! * widget.selectedProduct.quantity!),
                      action: (String reazon, num value) => widget.agreeDiscount(reazon, value)
                      ));
            });
        }
        break;
      case '2':
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return ComponentAnimate(
                  child:DialogTwoAction(
                      message: '¿Desea eliminar $title?',
                      messageCorrect: 'Eliminar',
                      actionCorrect: () => deleteItem()));
            });
      default:
    }
  }

  deleteItem() async {
    final productBloc = BlocProvider.of<ProductBloc>(context,listen: false);
    final selectedProductBloc = BlocProvider.of<SelectedProductBloc>(context,listen: false);
    final product = productBloc.state.products!.firstWhere((e) => e.id == widget.selectedProduct.productId);

    product.cantidad = product.cantidad! + 1;

    productBloc.add(UpdateProductsById(product));

    await DBProvider.db.deleteSelectProductById(widget.selectedProduct.id!);
    selectedProductBloc.add(RemoveSelectedProduct(widget.selectedProduct));
    selectedProductBloc.add(CalculateTotalCount());
    Navigator.of(context).pop();
  }
  increaseSerieORImei(ProductsModel product, SelectedProductsModel selectedProduct) async {
    final productBloc = BlocProvider.of<ProductBloc>(context,listen: false);
    final selectedProductBloc = BlocProvider.of<SelectedProductBloc>(context,listen: false);
    print('product.cantidad ${product.cantidad}');
    print('selectedProduct.quantity ${selectedProduct.quantity}');
    if (product.cantidad! > 0 ) {
      product.cantidad = product.cantidad! - 1;
      selectedProduct.quantity = selectedProduct.quantity! + 1;

      await DBProvider.db.updateSelectProduct(selectedProduct);
      productBloc.add(UpdateProductsById(product));
      selectedProductBloc.add(UpdateSelectedProductById(selectedProduct));
      selectedProductBloc.add(CalculateTotalCount());
    }
  }
  decreaseSerieORImei(ProductsModel product, SelectedProductsModel selectedProduct) async {
    final productBloc = BlocProvider.of<ProductBloc>(context,listen: false);
    final selectedProductBloc = BlocProvider.of<SelectedProductBloc>(context,listen: false);
    if (selectedProduct.quantity! > 1) {
      product.cantidad = product.cantidad! + 1;
      selectedProduct.quantity = selectedProduct.quantity! - 1;

      await DBProvider.db.updateSelectProduct(selectedProduct);
      productBloc.add(UpdateProductsById(product));
      selectedProductBloc.add(UpdateSelectedProductById(selectedProduct));
      selectedProductBloc.add(CalculateTotalCount());
    }
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
