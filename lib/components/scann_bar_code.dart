import 'dart:async';
import 'dart:math';

import 'package:app_artistica/components/containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:theme_provider/theme_provider.dart';

class ScannBarCodeComponent extends StatefulWidget {
  final Function(String) barcode;
  final IconData icon;
  const ScannBarCodeComponent(
      {Key? key,
      required this.barcode,
      required this.icon})
      : super(key: key);

  @override
  _ScannBarCodeComponentState createState() => _ScannBarCodeComponentState();
}

class _ScannBarCodeComponentState extends State<ScannBarCodeComponent> {
  ScanResult? scanResult;

  final _flashOnController = TextEditingController(text: 'CON FLASH');
  final _flashOffController = TextEditingController(text: 'SIN FLASH');
  final _cancelController = TextEditingController(text: 'ATRAS');

  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);
  List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  Future scan() async {
    try {
      var options = ScanOptions(
        strings: {
          "cancel": _cancelController.text,
          "flash_on": _flashOnController.text,
          "flash_off": _flashOffController.text,
        },
        restrictFormat: selectedFormats,
        useCamera: -1,
        autoEnableFlash: false,
        android: const AndroidOptions(
          aspectTolerance: 0.00,
          useAutoFocus: true,
        ),
      );
      var result = await BarcodeScanner.scan(options: options);
      setState(() => scanResult = result);
      if (scanResult!.rawContent != '') widget.barcode(scanResult!.rawContent);
    } on PlatformException catch (e) {
      widget.barcode(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child:ContainerRoundedComponent(
        child: Transform.rotate(
          angle: 90 * pi / 180,
          child: Icon(
            widget.icon,
            color: ThemeProvider.themeOf(context).data.hintColor,
          ),
        ),
      ),
        onTap: () => scan());
  }
}
