import 'package:app_artistica/bloc/client/client_bloc.dart';
import 'package:app_artistica/components/button.dart';
import 'package:app_artistica/components/input.dart';
import 'package:app_artistica/components/selector_options.dart';
import 'package:app_artistica/database/client_model.dart';
import 'package:app_artistica/screens/navigator/cart/billing/name_client.dart';
import 'package:app_artistica/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberDocument extends StatefulWidget {
  final num paymentAmount;
  final FocusScopeNode node;
  final TextEditingController documentController;
  final TextEditingController nameController;
  final TextEditingController typeDocumentInvoice;
  final Function(ClientsModel) clientModelGenerate;

  const NumberDocument(
      {Key? key,
      required this.clientModelGenerate,
      required this.typeDocumentInvoice,
      required this.paymentAmount,
      required this.node,
      required this.documentController,
      required this.nameController,
      })
      : super(key: key);

  @override
  State<NumberDocument> createState() => _NumberDocumentState();
}

class _NumberDocumentState extends State<NumberDocument> {
  bool documentClient = true;
  List clientsSelected = [];

  bool ifclientsSelected = false;
  String emailClient = '';
  bool booListClients = false;

  bool diplomaticoState = false;
  bool controlTributarioState = false;
  bool ventasDiaState = false;
  bool returnState = false;
  bool documentState = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: !returnState,
          child: InputComponent(
            textInputAction: TextInputAction.next,
            controllerText: widget.documentController,
            onEditingComplete: () {
              // if (clientsSelected.isNotEmpty) {
              //   widget.sinNombreF(false);
              // }
              widget.node.nextFocus();
            },
            validator: (value) {
              if (isNumeric(value)) {
                return null;
              } else {
                return 'Ingrese un Número de documento';
              }
            },
            inputFormatters: [
              // ignore: deprecated_member_use
              // WhitelistingTextInputFormatter.digitsOnly,
            ],
            onChanged: (value) {
              if (widget.documentController.text != '') {
                setState(() {
                  diplomaticoState = false;
                  controlTributarioState = false;
                  returnState = false;
                  ventasDiaState =false;
                });
                buscar(value);
              } else {
                setState(() {
                  clientsSelected = [];
                  diplomaticoState = false;
                  controlTributarioState = false;
                  returnState = false;
                  ventasDiaState =false;
                });
              }
            },
            onTapInput: () {
              setState(() {
                diplomaticoState = false;
                controlTributarioState = false;
                returnState = false;
                ventasDiaState =false;
              });
            },
            keyboardType: TextInputType.number,
            icon: Icons.person,
            labelText: "Número de documento",
          ),
        ),
        Visibility(
            visible: diplomaticoState,
            child: ButtonComponent(
              text: 'DIPLOMÁTICO',
              onPressed: () {
                  setState(() {
                    widget.nameController.text = 'Diplomático';
                    diplomaticoState = false;
                    controlTributarioState = false;
                    returnState = true;
                    ventasDiaState =false;
                    documentState = false;
                  });
                  widget.node.nextFocus();
              },
            )),
        Visibility(
            visible: controlTributarioState,
            child: ButtonComponent(
              text: 'CONTROL TRIBUTARIO',
              onPressed: () {
                  setState(() {
                    widget.nameController.text = 'Control Tributario';
                    diplomaticoState = false;
                    controlTributarioState = false;
                    returnState = true;
                    ventasDiaState = false;
                    documentState = false;
                  });
                  widget.node.nextFocus();
              },
            )),
        Visibility(
            visible: ventasDiaState,
            child: ButtonComponent(
              text: 'VENTAS DEL DÍA',
              onPressed: () {
                  setState(() {
                    widget.nameController.text = 'Ventas menores del día';
                    diplomaticoState = false;
                    controlTributarioState = false;
                    returnState = true;
                    ventasDiaState = false;
                    documentState = false;
                  });
                  widget.node.nextFocus();
              },
            )),
        Visibility(
            visible: returnState,
            child: ButtonComponent(
              text: 'REGRESAR',
              onPressed: () {
                setState(() {
                  widget.nameController.text = '';
                  widget.documentController.text = '';
                  diplomaticoState = false;
                  controlTributarioState = false;
                  returnState = false;
                  ventasDiaState =false;
                  documentState = true;
                });
              },
            )),
        Visibility(
            visible: clientsSelected.isNotEmpty ? true : false,
            child: SizedBox(
              height: (MediaQuery.of(context).size.height / 10) * clientsSelected.length,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: clientsSelected.length,
                  itemBuilder: (BuildContext context, int index) {
                    return MaterialButton(
                        splashColor: Colors.transparent,
                        color: const Color(0XFFF2F2F2),
                        shape: const StadiumBorder(),
                        child: Text( '${clientsSelected[index].numberDocument} - ${clientsSelected[index].name}'),
                        onPressed: () {
                          widget.clientModelGenerate(clientsSelected[index]);
                          FocusScope.of(context).unfocus();
                          setState(() {
                            widget.documentController.text = clientsSelected[index].numberDocument.toString();
                            widget.nameController.text = clientsSelected[index].name;
                            widget.typeDocumentInvoice.text = clientsSelected[index].typeDocument.toString();
                            diplomaticoState = false;
                            controlTributarioState = false;
                            returnState = true;
                            ventasDiaState =false;
                            documentState = false;
                            clientsSelected = [];
                          });
                          
                        });
                  }),
            )),
            const SizedBox(height: 15.0),
            if(returnState)
            Text('Número de documento: ${widget.documentController.text}'),
            if(returnState)
            if(widget.nameController.text != 'Control Tributario' && widget.nameController.text != 'Diplomático' && widget.nameController.text != 'Ventas menores del día')

            if(returnState)
            Text('Nombre del ciente: ${widget.nameController.text}'),
           Visibility(
              visible: documentState,
              child:  NameClient(
              paymentAmount: widget.paymentAmount,
              node: widget.node,
              documentController: widget.documentController,
              nameController: widget.nameController,
              sinNombreF: (val) {
                // setState(() {
                //   sinNombreState = val;
                // });
              })),
            
      ],
    );
  }

  buscar(data) {
    final clientBloc = BlocProvider.of<ClientBloc>(context, listen: false).state;
    clientsSelected = [];
    if (data == '99001') {
      setState(() {
        diplomaticoState = true;
        controlTributarioState = false;
        returnState = false;
        ventasDiaState =false;
      });
    }
    if (data == '99002') {
      setState(() {
        diplomaticoState = false;
        controlTributarioState = true;
        returnState = false;
        ventasDiaState = false;
      });
    }
    if (data == '99003') {
      setState(() {
        diplomaticoState = false;
        controlTributarioState = false;
        returnState = false;
        ventasDiaState = true;
      });
    }
    for (var item in clientBloc.clients!.where((e) =>
        e.numberDocument != 99001 &&
        e.numberDocument != 99002 &&
        e.numberDocument != 99003 &&
        e.numberDocument.toString().contains(data))) {
        setState(() {
          // ifclientsSelected = true;
          clientsSelected.add(ClientsModel(
              id: item.id,
              name: item.name,
              email: item.email,
              numberDocument: item.numberDocument,
              typeDocument: item.typeDocument,
              numberContact: item.numberContact));
        });
    }
    if (clientsSelected.isNotEmpty) {
      setState(() => booListClients = true);
    } else {
      setState(() => booListClients = false);
    }
  }
}
