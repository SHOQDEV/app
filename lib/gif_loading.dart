import 'package:flutter/material.dart';

class GifLoading extends StatelessWidget {
  const GifLoading(
      {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: const Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          child: Image(
            image: AssetImage(
              'assets/gifs/loading.gif',
            ),
            fit: BoxFit.cover,
          ),
        ));
  }
}
