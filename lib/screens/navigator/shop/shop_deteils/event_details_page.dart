import 'package:app_artistica/bloc/product/product_bloc.dart';
import 'package:app_artistica/bloc/selected_product/selected_product_bloc.dart';
import 'package:app_artistica/components/button.dart';
import 'package:app_artistica/components/header_pages.dart';
import 'package:app_artistica/database/db_provider.dart';
import 'package:app_artistica/database/product_model.dart';
import 'package:app_artistica/dialogs/dialog_action.dart';
import 'package:app_artistica/screens/navigator/shop/shop_deteils/event_details_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:intl/number_symbols_data.dart' show numberFormatSymbols;

class EventDetailsPage extends StatefulWidget {
  final ProductsModel? product;

  const EventDetailsPage({Key? key, this.product}) : super(key: key);

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  String? titleAlert;
  bool stateAlert = false;
  int currentAmount = 1;
  num? priceTotal;
  @override
  void initState() {
    super.initState();
    setState(() => priceTotal = widget.product!.precio);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Column(children: <Widget>[
              ComponentHeader(
                  stateBack: true, text: widget.product!.nombre!.toUpperCase()),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    ClipPath(
                      clipper: ImageClipper(),
                      child: Stack(children: <Widget>[
                        Hero(
                          tag: '${widget.product!.nombre!}-shop',
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                widget.product!.img!,
                                fit: BoxFit.cover,
                                width: screenWidth,
                                height: screenHeight * 0.55,
                                colorBlendMode: BlendMode.darken,
                              )),
                        ),
                      ]),
                    ),
                    ProductContent(
                        product: widget.product!,
                        onChanges: (num value, int value2) => setState(() {
                              priceTotal = value;
                              currentAmount = value2;
                            })),
                  ],
                ),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text("TOTAL"),
                      Text(
                        NumberFormat.decimalPattern(getCurrentLocale())
                            .format(priceTotal),
                      ),
                    ],
                  ),
                  ButtonComponent(
                    text: 'Agregar al carrito',
                    onPressed: () => addCart(),
                  )
                ],
              )
            ])));
  }

  String getCurrentLocale() {
    const locale = Locale('es', 'ES');
    final joined = "${locale.languageCode}_${locale.countryCode}";
    if (numberFormatSymbols.keys.contains(joined)) {
      return joined;
    }
    return locale.languageCode;
  }

  addCart() async {
      if (currentAmount <= widget.product!.cantidad!) {
        return addItem();
      } else {
        return callDialogAction(
            context, 'Llegaste al stock 0 de ${widget.product!.nombre}');
      }
  }

  addItem() async {
    final selectedProductBloc = BlocProvider.of<SelectedProductBloc>(context, listen: false);
    final productBloc = BlocProvider.of<ProductBloc>(context, listen: false);
      //ACTUALIZANDO LA TABLA products_ff
      widget.product!.cantidad = widget.product!.cantidad! - currentAmount;
      productBloc.add(UpdateProductsById(widget.product!));

    await DBProvider.db.getALLSelectedProductsModelByproductId(widget.product!.id!)
        .then((result) async {
      if (result != null) {

        final selectedProductsModel = result;
        selectedProductsModel.quantity = selectedProductsModel.quantity! + currentAmount;

        await DBProvider.db.updateSelectProduct(selectedProductsModel);
        selectedProductBloc.add(UpdateSelectedProductById(selectedProductsModel));
        selectedProductBloc.add(CalculateTotalCount());
        return Navigator.of(context).pop();
      } else {
        //AGREGANDO A LA TABLA selectedProducts_ff
        final selectedProductsModel = SelectedProductsModel(
          productId: widget.product!.id,
          discount: 0,
          typeDiscount: 'SIN DESCUENTO',
          quantity: currentAmount,
          price: widget.product!.precio,
        );
        await DBProvider.db.newSelectedProductsModel(selectedProductsModel)
            .then((value) => DBProvider.db
                .getSelectedProductsModelById(value)
                .then((value2) =>
                    selectedProductBloc.add(UpdateSelectedProducts(value2))));
        selectedProductBloc.add(CalculateTotalCount());
        return Navigator.of(context).pop();
      }
    });
  }
}

class ImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    Offset curveEndPoint = Offset(size.width, size.height * 0.90);
    path.lineTo(0, curveEndPoint.dy);
    path.quadraticBezierTo(
        size.width / 2, size.height, curveEndPoint.dx, curveEndPoint.dy);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
