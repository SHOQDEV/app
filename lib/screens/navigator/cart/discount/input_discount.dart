import 'package:app_artistica/components/input.dart';
import 'package:app_artistica/components/button.dart';
import 'package:app_artistica/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class InputDiscount extends StatefulWidget {
  final double price;
  final Function() backScreen;
  final Function() saveDiscount;
  final MoneyMaskedTextController discountController;
  final String reazonDiscount;
  const InputDiscount(
      {Key? key,
      required this.price,
      required this.backScreen,
      required this.saveDiscount,
      required this.discountController,
      required this.reazonDiscount})
      : super(key: key);

  @override
  _InputDiscountState createState() => _InputDiscountState();
}

class _InputDiscountState extends State<InputDiscount> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: SingleChildScrollView(
            child: Column(
          children: [
            InputComponentNoIcon(
              focusNode: focusNode,
              textInputAction: TextInputAction.next,
              labelText: 'Descuento en ${widget.reazonDiscount}',
              controllerText: widget.discountController,
              keyboardType: TextInputType.number,
              onEditingComplete: () {
                if (formKey.currentState!.validate()) widget.saveDiscount();
              },
              validator: (value) {
                if (isNumericSupZero(value)) {
                  if (widget.reazonDiscount == 'MONTO') {
                    if (widget.price <
                        double.parse(value.replaceFirst(RegExp(','), '.'))) {
                      return 'Ingresa un descuento valido';
                    } else {
                      return null;
                    }
                  } else {
                    if (100 <
                        double.parse(value.replaceFirst(RegExp(','), '.'))) {
                      return 'Ingresa un descuento valido';
                    } else {
                      return null;
                    }
                  }
                } else {
                  return 'Ingrese el un descuento valido';
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonWhiteComponent(
                  text: 'Atrás',
                  onPressed: widget.backScreen,
                ),
                ButtonComponent(
                  text: 'Guardar',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {}
                    widget.saveDiscount();
                  },
                )
              ],
            )
          ],
        )));
  }
}
