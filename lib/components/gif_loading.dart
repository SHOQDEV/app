import 'dart:async';

import 'package:flutter/material.dart';

showSuccessful( BuildContext context, String textDialog, Function() finish) async {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return GifLoadingSuccessful(text: textDialog);
      });
  Timer(const Duration(milliseconds: 1500), () {
    Navigator.of(context).pop();
    finish();
  });
}

class GifLoadingSuccessful extends StatelessWidget {
  final String text;
  // final
  const GifLoadingSuccessful({Key? key, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage(
                  'assets/gifs/successful.gif',
                ),
                fit: BoxFit.cover,
              ),
              Text(text,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center)
            ],
          ),
        ));
  }
}
showLoading( BuildContext context, String textDialog) async {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return GifLoading(text: textDialog);
      });
}

class GifLoading extends StatelessWidget {
  final String text;
  const GifLoading(
      {Key? key, required this.text})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage(
                  'assets/gifs/loading.gif',
                ),
                fit: BoxFit.cover,
              ),
              Text(text,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center)
            ],
          )
        ));
  }
}
