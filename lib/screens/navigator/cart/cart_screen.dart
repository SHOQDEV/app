
import 'package:app_artistica/database/selected_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:intl/number_symbols_data.dart' show numberFormatSymbols;

import 'package:app_artistica/bloc/product/product_bloc.dart';
import 'package:app_artistica/bloc/selected_product/selected_product_bloc.dart';
import 'package:app_artistica/components/button.dart';
import 'package:app_artistica/components/header_pages.dart';
import 'package:app_artistica/models/detail_invoice.dart';
import 'package:app_artistica/screens/navigator/cart/detail_cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
  @override
  _CartPageScreen createState() => _CartPageScreen();
}

class _CartPageScreen extends State<CartScreen> {
  int? guia;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController discountController = TextEditingController();
  int? selectID;
  bool colorValue = false;
  num? subTotalItem;
  String? selectText;

  @override
  Widget build(BuildContext context) {
    final selectedProductBloc =
        BlocProvider.of<SelectedProductBloc>(context, listen: true).state;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Column(children: <Widget>[
          const ComponentHeader(stateBack: false, text: 'Carrito'),
          Expanded(
            child: selectedProductBloc.existSelectedProduct
                ? SingleChildScrollView(
                    child: Column(
                    children: [
                      for (var item in selectedProductBloc.selectedProducts!)
                        DetailCart(
                          selectedProduct: item,
                          agreeDiscount: (String reazon, num value) => agreeDiscount(reazon, value, item),
                          desagreeDiscount: () => desagreeDiscount(item),
                          delete: () {},
                        )
                    ],
                  ))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/carts_contend.png',
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: MediaQuery.of(context).size.width * 0.45,
                        gaplessPlayback: true,
                        fit: BoxFit.scaleDown,
                      ),
                      const Text(
                          'Aqui observaras los productos antes de ser facturados')
                    ],
                  ),
          ),
          if (selectedProductBloc.totalCount != 0.0)
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        "TOTAL",
                      ),
                      Text(NumberFormat.decimalPattern(getCurrentLocale())
                          .format(selectedProductBloc.totalCount)),
                    ],
                  ),
                ),
                Expanded(
                    child: SizedBox(
                        height: 35,
                        child: ButtonComponent(
                          text: 'Facturar',
                          onPressed: () => checkIn(),
                        ))),
              ],
            ),
        ]));
  }

  desagreeDiscount(SelectedProductsModel item) async {
    final selectedProductBloc = BlocProvider.of<SelectedProductBloc>(context, listen: false);
    final selectedProductsModel = SelectedProductsModel(
      id: item.id,
      productId: item.productId,
      discount: 0.0,
      typeDiscount: 'SIN DESCUENTO',
      quantity: item.quantity
    );
    // await DBProvider.db.updateSelectProduct(selectedProductsModel);
    selectedProductBloc.add(UpdateSelectedProductById(selectedProductsModel));
    selectedProductBloc.add(CalculateTotalCount());
    Navigator.of(context).pop();
  }

  agreeDiscount(String reazon, num value, SelectedProductsModel item) async {
    final selectedProductBloc = BlocProvider.of<SelectedProductBloc>(context, listen: false);
    final selectedProductsModel = SelectedProductsModel(
      id: item.id,
      productId: item.productId,
      discount: double.parse('$value'),
      typeDiscount: reazon.toUpperCase(),
      quantity: item.quantity
    );
    selectedProductBloc.add(UpdateSelectedProductById(selectedProductsModel));
    selectedProductBloc.add(CalculateTotalCount());
    Navigator.of(context).pop();
  }

  checkIn() {
    final selectedProductBloc = BlocProvider.of<SelectedProductBloc>(context, listen: false).state;
    final productBloc = BlocProvider.of<ProductBloc>(context, listen: false).state;
    productDetail = [];
    String numeroSerieMoment = '';
    String numeroImeiMoment = '';

    for (var listProductsSelect in selectedProductBloc.selectedProducts!) {

      final product = productBloc.products!.firstWhere((e) => e.id == listProductsSelect.productId);

      double aux3;

      if(listProductsSelect.typeDiscount == 'PORCENTAJE'){
        aux3 = ((listProductsSelect.discount! / 100) * (listProductsSelect.quantity! * listProductsSelect.price!));
      }else{
        aux3 = listProductsSelect.discount!;
      }
      final aux = (listProductsSelect.quantity! * listProductsSelect.price!) - aux3;

      ProductDetail productDetailx = ProductDetail(
          descripcion: product.nombre,
          cantidad: listProductsSelect.quantity,
          precioUnitario: num.parse(product.precio!.toStringAsFixed(5)),
          montoDescuento: num.parse(aux3.toStringAsFixed(5)),
          subTotal: num.parse(aux.toStringAsFixed(5)),
          numeroSerie: numeroSerieMoment == ""
              ? numeroSerieMoment
              : numeroSerieMoment.substring(1),
          numeroImei: numeroImeiMoment == ""
              ? numeroImeiMoment
              : numeroImeiMoment.substring(1));
      productDetail.add(productDetailx);
    }

    Navigator.pushNamed(context, 'billing');
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
