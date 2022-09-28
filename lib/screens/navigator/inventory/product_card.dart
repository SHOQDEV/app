
import 'package:app_artistica/bloc/product/product_bloc.dart';
import 'package:app_artistica/bloc/selected_product/selected_product_bloc.dart';
import 'package:app_artistica/components/animate.dart';
import 'package:app_artistica/components/containers.dart';
import 'package:app_artistica/components/icon_rounded.dart';
// import 'package:app_artistica/database/db_provider.dart';
import 'package:app_artistica/database/product_model.dart';
import 'package:app_artistica/dialogs/dialog_action.dart';
import 'package:app_artistica/screens/navigator/inventory/create_product.dart';
import 'package:app_artistica/services/service_method.dart';
import 'package:app_artistica/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:intl/number_symbols_data.dart' show numberFormatSymbols;

class ProductCard extends StatelessWidget {
  final ProductsModel product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContainerComponent(
      child:
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Hero(
              tag: product.id.toString(),
              child: Image.network(product.img!,
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.width * 0.35,
                  gaplessPlayback: true,
                  fit: BoxFit.cover)),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Nombre: ${product.nombre}'),
              Text('Precio: ${product.precio}'),
              // Text('Vendidos: ${product.souldOut}'),
              // if (product.typeProduct != 'servicios')
                Text('Stock: ${product.cantidad}'),
              if (product.codbarras != '0')
                Text('Codigo de barras: ${product.codbarras}'),
            ],
          ),
        )),
        Column(children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(5),
              child: IconRoundedComponent(
                onTap: () {
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateProductScreen(product: product)));
                },
                icon: Icons.edit_outlined,
                colorIcon: Colors.blue[700],
              )),
          Padding(
              padding: const EdgeInsets.all(5),
              child: IconRoundedComponent(
                onTap: () => deleteProduct(context, product),
                icon: Icons.delete_outline_outlined,
                colorIcon: const Color(0xFfE21C34),
              )),
        ]),
      ]),
    );
  }

  deleteProduct(BuildContext context, ProductsModel product) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return ComponentAnimate(
              child: DialogTwoAction(
                  message: '¿Desea eliminar el producto ${product.nombre}?',
                  messageCorrect: 'Eliminar',
                  actionCorrect: () => serviceDelete(context,product)));
        });
  }
  serviceDelete(BuildContext context,ProductsModel product)async{
    final selectedProductBloc = BlocProvider.of<SelectedProductBloc>(context,listen: false);
    final productBloc = BlocProvider.of<ProductBloc>(context,listen: false);
    var response = await serviceMethod( context, 'delete', null, serviceProduct(product.id), true, null );
    if(response != null){
      //ELIMINA LOGICAMENTE LA TABLA products_ff SELECCIONADA
      // await DBProvider.db.deleteProductById(product.id!);
      productBloc.add(RemoveProduct(product));
      if(selectedProductBloc.state.existSelectedProduct){
        for (final selectedProduct in selectedProductBloc.state.selectedProducts!.where((e) => e.productId == product.id)) {
          // await DBProvider.db.deleteSelectProductById(selectedProduct.id!);
          selectedProductBloc.add(RemoveSelectedProduct(selectedProduct));
          selectedProductBloc.add(CalculateTotalCount());
        }
      }
      Navigator.of(context).pop();
    }
  }

  format(value) {
    NumberFormat.decimalPattern(getCurrentLocale()).format(value);
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
