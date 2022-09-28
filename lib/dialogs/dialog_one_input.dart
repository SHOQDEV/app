import 'package:app_artistica/components/input.dart';
import 'package:app_artistica/components/button.dart';
import 'package:flutter/material.dart';

class DialogOneInputAction extends StatefulWidget {
  final String message;
  final TextEditingController controllerText;
  final Function(TextEditingController textControllerName) actionCorrect;
  final String messageCorrect;
  final String? title;
  final Function(String) validator;
  final TextCapitalization textCapitalization;
  const DialogOneInputAction(
      {Key? key,
      this.title,
      required this.controllerText,
      required this.textCapitalization,
      required this.validator,
      required this.message,
      required this.actionCorrect,
      required this.messageCorrect})
      : super(key: key);

  @override
  _DialogOneInputActionState createState() => _DialogOneInputActionState();
}

class _DialogOneInputActionState extends State<DialogOneInputAction> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Form(
            key: formKey,
            child: Stack(
              // overflow: Overflow.visible,
              alignment: Alignment.topCenter,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width <
                          MediaQuery.of(context).size.height
                      ? MediaQuery.of(context).size.width * 0.6
                      : MediaQuery.of(context).size.height * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Column(
                      children: [
                        Text(
                          widget.message,
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(),
                        InputComponentNoIcon(
                          textInputAction: TextInputAction.next,
                          labelText: 'Nombre de la ' + widget.title!,
                          controllerText: widget.controllerText,
                          textCapitalization: widget.textCapitalization,
                          keyboardType: TextInputType.text,
                          onEditingComplete: () => node.nextFocus(),
                          validator: widget.validator,
                        ),
                        const Spacer(),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ButtonWhiteComponent(
                                text: 'Cancelar',
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                              ButtonComponent(
                                text: widget.messageCorrect,
                                onPressed: () {
                                  if(formKey.currentState!.validate())widget.actionCorrect(widget.controllerText);},
                              )
                            ]),
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
