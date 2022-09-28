import 'package:app_artistica/components/icon_rounded.dart';
import 'package:app_artistica/database/product_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:intl/number_symbols_data.dart' show numberFormatSymbols;

class ProductContent extends StatefulWidget {
  final ProductsModel product;
  final Function(num,int) onChanges;
  const ProductContent({Key? key, 
    required this.product,
    required this.onChanges}) : super(key: key);

  @override
  _ProductContentState createState() => _ProductContentState();
}

class _ProductContentState extends State<ProductContent> {
  int currentAmount = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(widget.product.nombre!,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold)),
                ),
                Expanded(
                    child: Text(
                        'Bs. ' +
                            NumberFormat.decimalPattern(getCurrentLocale())
                                .format(widget.product.precio),
                        textAlign: TextAlign.end,
                        style: const TextStyle(fontWeight: FontWeight.bold)))
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text("CANTIDAD"),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconRoundedComponent(
                          icon: Icons.remove, onTap: () => subtractItembtn()),
                      const SizedBox(width: 15),
                      Text(
                        "$currentAmount",
                      ),
                      const SizedBox(width: 15),
                      IconRoundedComponent(
                          icon: Icons.add, onTap: () => addItembtn()),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  addItembtn() {
      if (currentAmount < widget.product.cantidad!) {
        setState(() {
          currentAmount += 1;
          // priceTotal = currentAmount * widget.product.price;
          widget.onChanges(currentAmount * widget.product.precio!,currentAmount);
        });
      }
  }

  subtractItembtn() {
    if (currentAmount > 1) {
      setState(() {
        currentAmount -= 1;
        // priceTotal = currentAmount * widget.product.price;
        widget.onChanges(currentAmount * widget.product.precio!,currentAmount);
      });
    }
  }

  String getCurrentLocale() {
    const locale =  Locale('es', 'ES');
    final joined = "${locale.languageCode}_${locale.countryCode}";
    if (numberFormatSymbols.keys.contains(joined)) {
      return joined;
    }
    return locale.languageCode;
  }
}
