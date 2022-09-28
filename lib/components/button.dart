import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class ButtonComponent extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const ButtonComponent(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      splashColor: Colors.transparent,
      // minWidth: double.infinity,
      // height: 30,
      color: ThemeProvider.themeOf(context).data.primaryColorLight,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,
                style: const TextStyle(color:Colors.white)),
          ]),
      onPressed:onPressed
    );
  }
}

class ButtonWhiteComponent extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const ButtonWhiteComponent(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      splashColor: Colors.transparent,
      // minWidth: double.infinity,
      // height: 30,
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,
                style: const TextStyle(
                    color: Colors.black )),
          ]),
      onPressed:onPressed
    );
  }
}
