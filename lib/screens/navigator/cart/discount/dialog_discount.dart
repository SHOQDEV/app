import 'package:app_artistica/components/button.dart';
import 'package:app_artistica/screens/navigator/cart/discount/card_image.dart';
import 'package:app_artistica/screens/navigator/cart/discount/input_discount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class DialogDiscout extends StatefulWidget {
  final double price;
  final Function(String, num) action;

  const DialogDiscout({Key? key, required this.price, required this.action})
      : super(key: key);

  @override
  _DialogDiscoutState createState() => _DialogDiscoutState();
}

class _DialogDiscoutState extends State<DialogDiscout>
    with TickerProviderStateMixin {
  MoneyMaskedTextController discountController = MoneyMaskedTextController();
  TabController? tabController;
  String? reazonDiscount;
  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 1, vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: SizedBox(
        height: MediaQuery.of(context).size.width <
                MediaQuery.of(context).size.height
            ? MediaQuery.of(context).size.width * 0.6
            : MediaQuery.of(context).size.height * 0.5,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            children: [
              const Text(
                'Elige el método de descuento',
                textAlign: TextAlign.center,
              ),
              Expanded(
                  child: DefaultTabController(
                initialIndex: 1,
                length: 3,
                child: TabBarView(
                  controller: tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    InputDiscount(
                        price: widget.price,
                        backScreen: () {
                          FocusScope.of(context).unfocus();
                          tabController!.animateTo(tabController!.index + 1);
                        },
                        saveDiscount: () => widget.action(
                            'MONTO',
                            num.parse(discountController.text.replaceFirst(RegExp(','), '.'))),
                        discountController: discountController,
                        reazonDiscount: 'MONTO'),
                    SizedBox(
                        height: 400,
                        child: SingleChildScrollView(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CardImage(
                              text: 'MONTO',
                              image: 'assets/icons/money.png',
                              nextScreen: () {
                                setState(() => reazonDiscount = 'MONTO');
                                tabController!.animateTo(tabController!.index - 1);
                              },
                            ),
                            CardImage(
                              text: 'PORCENTAJE',
                              image: 'assets/icons/porcent.png',
                              nextScreen: () {
                                setState(() => reazonDiscount = 'PORCENTAJE');
                                tabController!.animateTo(tabController!.index + 1);
                              },
                            ),
                          ],
                        ))),
                    InputDiscount(
                        price: widget.price,
                        backScreen: () {
                          FocusScope.of(context).unfocus();
                          tabController!.animateTo(tabController!.index - 1);
                        },
                        saveDiscount: () => widget.action(
                            'PORCENTAJE',
                            num.parse(discountController.text.replaceFirst(RegExp(','), '.'))),
                        discountController: discountController,
                        reazonDiscount: 'PORCENTAJE')
                  ],
                ),
              )),
              ButtonWhiteComponent(
                text: 'Cancelar',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
