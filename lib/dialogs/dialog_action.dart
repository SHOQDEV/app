import 'package:app_artistica/components/animate.dart';
import 'package:app_artistica/components/button.dart';
import 'package:flutter/material.dart';

callDialogAction(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return ComponentAnimate(
            child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: Text(
            message,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            ButtonComponent(
                text: 'Aceptar', onPressed: () => Navigator.pop(context))
          ],
        ));
      });
}

class DialogTwoAction extends StatelessWidget {
  final String message;
  final Function() actionCorrect;
  final String messageCorrect;

  const DialogTwoAction(
      {Key? key,
      required this.message,
      required this.actionCorrect,
      required this.messageCorrect})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ComponentAnimate(
        child: AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Text(
        message,
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ButtonWhiteComponent(
              text: 'Cancelar',
              onPressed: () => Navigator.of(context).pop(),
            ),
            ButtonComponent(
                text: messageCorrect, onPressed: () => actionCorrect())
          ],
        )
      ],
    ));
  }
}
