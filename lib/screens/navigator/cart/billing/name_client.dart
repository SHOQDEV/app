import 'package:app_artistica/components/input.dart';
import 'package:app_artistica/utils/utils.dart';
import 'package:flutter/material.dart';

class NameClient extends StatefulWidget {
  final num paymentAmount;
  final FocusScopeNode node;
  final TextEditingController documentController;
  final TextEditingController nameController;
  final Function(bool) sinNombreF;
  const NameClient(
      {Key? key,
      required this.paymentAmount,
      required this.node,
      required this.documentController,
      required this.nameController,
      required this.sinNombreF})
      : super(key: key);

  @override
  State<NameClient> createState() => _NameClientState();
}

class _NameClientState extends State<NameClient> {
  @override
  Widget build(BuildContext context) {
    return InputComponent(
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.next,
            controllerText: widget.nameController,
            onEditingComplete: () => widget.node,
            validator: (value) {
              if (value.isNotEmpty) {
                if (validateText(value)) {
                  return null;
                } else {
                  return 'Ingrese el nombre del cliente';
                }
              } else {
                return 'Ingrese el nombre del cliente';
              }
            },
            onChanged: (value) {
              if (widget.documentController.text != '') {
                // setState(() => sinNombreState = false);
                widget.sinNombreF(false);
              }
            },
            onTap: () {
              // if (clientsSelected.isNotEmpty) {
              //   widget.sinNombreF(false);
              //   // setState(() {
              //   //   sinNombreState = false;
              //   // });
              // }
            },
            keyboardType: TextInputType.name,
            icon: Icons.person,
            labelText: "Nombre del cliente",
          );
  }
}
