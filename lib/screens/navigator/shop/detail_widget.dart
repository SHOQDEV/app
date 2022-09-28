
import 'package:app_artistica/components/containers.dart';
import 'package:app_artistica/database/product_model.dart';
import 'package:app_artistica/screens/navigator/shop/shop_deteils/event_details_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:intl/number_symbols_data.dart' show numberFormatSymbols;

class DetailWidget extends StatelessWidget {
  final ProductsModel product;
  const DetailWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EventDetailsPage(product: product),
                ),
              );
            },
            child: ContainerComponent(
                width: 260,
                height: 370,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(children: <Widget>[
                        Hero(
                          tag: '${product.nombre!}-shop',
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(product.img!,
                                  height: 250,
                                  width: 250,
                                  gaplessPlayback: true,
                                  fit: BoxFit.cover)),
                        ),
                      ]),
                      const Divider(),
                      Text(
                        product.nombre!.toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                          '${NumberFormat.decimalPattern(getCurrentLocale()).format(product.precio)} Bs.',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red)),
                    ],
                  ),
                ))));
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
