import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theme_provider/theme_provider.dart';

class CreditCard extends StatefulWidget {
  final String cardHolder;
  final TextEditingController typeDocumentInvoice;
  final numberTargetController;
  final String cardExpiration;
  const CreditCard(
      {Key? key,
      required this.typeDocumentInvoice,
      required this.cardHolder,
      required this.numberTargetController,
      required this.cardExpiration})
      : super(key: key);

  @override
  _CreditCardState createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController numberTargetController1 = TextEditingController();
  TextEditingController numberTargetController4 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Card(
      elevation: 5,
      color: ThemeProvider.themeOf(context).data.primaryColorLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        height: 200,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset(
              "assets/images/app_artistica.png",
              height: 50,
              width: 50,
            ),
            Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Form(
                    key: formKey,
                    child: Row(
                      children: [
                         Flexible(
                          flex: 2,
                          child: TextFormField(
                            inputFormatters: [
                               LengthLimitingTextInputFormatter(4)
                            ],
                            onChanged: (v) {
                              if (numberTargetController1.text.length == 4) {
                                node.nextFocus();
                              }
                              setState(() =>
                                  widget.numberTargetController.text = numberTargetController1.text + numberTargetController4.text);
                            },
                            controller: numberTargetController1,
                            decoration: InputDecoration(
                                hintText: 'XXXX',
                                hintStyle: TextStyle(
                                  // ignore: deprecated_member_use
                                  color: ThemeProvider.themeOf(context).data.accentColor,
                                ),
                                labelStyle: const TextStyle(color: Color(0xff1D1D25))),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const Spacer(),
                        const Text('0000'),
                        const Spacer(),
                        const Text('0000'),
                        const Spacer(),
                         Flexible(
                          flex: 2,
                          child: TextFormField(
                            inputFormatters: [
                               LengthLimitingTextInputFormatter(4)
                            ],
                            onChanged: (v) {
                              if (numberTargetController4.text.length == 4) {
                                node.nextFocus();
                              }
                              setState(() =>
                                  widget.numberTargetController.text = numberTargetController1.text + numberTargetController4.text);
                            },
                            controller: numberTargetController4,
                            decoration: InputDecoration(
                                hintText: 'XXXX',
                                hintStyle: TextStyle(
                                  // ignore: deprecated_member_use
                                  color: ThemeProvider.themeOf(context).data.accentColor,
                                )),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ))
                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildDetailsBlock(
                  label: 'NOMBRE DEL CLIENTE',
                  value: widget.cardHolder,
                ),
                _buildDetailsBlock(
                  label: 'NUMERO DE DOCUMENTO',
                  value: widget.cardExpiration,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column _buildDetailsBlock({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: const TextStyle(
              color: Colors.black,fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}