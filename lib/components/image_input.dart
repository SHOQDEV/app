import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:theme_provider/theme_provider.dart';

class ImageInputComponent extends StatefulWidget {
  final Widget child;
  final Function(File) onPressed;
  const ImageInputComponent(
      {Key? key,
      required this.child,
      required this.onPressed})
      : super(key: key);

  @override
  _ImageInputComponentState createState() => _ImageInputComponentState();
}

class _ImageInputComponentState extends State<ImageInputComponent> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child:widget.child
            ),
            Positioned(
            bottom: 5,
            right: -15,
            child: RawMaterialButton(
              padding: const EdgeInsets.all(5.0),
              onPressed: () => _displayPickImageDialog(),
              elevation: 3,
              fillColor: Colors.white,
              child: Icon(
                Icons.camera_alt,
                size: 35,
                color: ThemeProvider.themeOf(context).data.primaryColorLight,
              ),
              shape: const CircleBorder(),
            ),
          )
        ],
      ),
    );
  }
  void _onImageButtonPressed(ImageSource source,BuildContext context) async {
    final pickedFile = await ImagePicker.platform.pickImage(
      source: source,
      maxWidth: 1000,
      maxHeight: 1000,
      imageQuality: 100,
    );
    widget.onPressed(File(pickedFile!.path));
  }

  _displayPickImageDialog() {
    showCupertinoModalPopup<String>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
              title: const Text(
                'Seleccionar medio de Imagen',
              ),
              actions: <Widget>[
                CupertinoActionSheetAction(
                  child: const Text('Cámara'),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop("Discard");
                    _onImageButtonPressed(ImageSource.camera, context);
                  },
                ),
                CupertinoActionSheetAction(
                  child: const Text('Galería'),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop("Discard");
                    _onImageButtonPressed(ImageSource.gallery, context);
                  },
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                child: const Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop("Discard");
                },
              ));
        });
  }
}
