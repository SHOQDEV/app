import 'package:app_artistica/database/client_model.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:app_artistica/bloc/client/client_bloc.dart';
import 'package:app_artistica/bloc/contact/contact_bloc.dart';
import 'package:app_artistica/components/input.dart';
import 'package:app_artistica/components/button.dart';
import 'package:app_artistica/dialogs/dialog_action.dart';
import 'package:app_artistica/utils/search_contacts.dart';
import 'package:app_artistica/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DynamicDialog extends StatefulWidget {
  final ClientsModel customer;

  const DynamicDialog({Key? key, required this.customer}) : super(key: key);
  @override
  _DynamicDialogState createState() => _DynamicDialogState();
}

class _DynamicDialogState extends State<DynamicDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController editNombreClienteController = TextEditingController();
  TextEditingController editTelefonoClienteController = TextEditingController();
  TextEditingController editEmailClienteController = TextEditingController();
  TextEditingController editDocumentoClienteController = TextEditingController();
  int? typeDocumentNumber;
  // List<Contact> contacts = [];
  // List<Contact> contactsFiltered = [];
  bool isContact = false;
  List<Contact> list=[];
  @override
  void initState() {
    editNombreClienteController =
        TextEditingController(text: widget.customer.name);
    editTelefonoClienteController =
        TextEditingController(text: widget.customer.numberContact.toString());
    editEmailClienteController =
        TextEditingController(text: widget.customer.email);
    editDocumentoClienteController =
        TextEditingController(text: widget.customer.numberDocument.toString());
    typeDocumentNumber = widget.customer.typeDocument;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    final clientBloc = BlocProvider.of<ClientBloc>(context, listen: true).state;
    final contactBloc = BlocProvider.of<ContactBloc>(context, listen: true);
    return AlertDialog(
      content: SingleChildScrollView(
          child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text("Editar cliente "),
                  InputComponentNoIcon(
                    textInputAction: TextInputAction.next,
                    labelText: 'Nombre del cliente',
                    textCapitalization: TextCapitalization.characters,
                    controllerText: editNombreClienteController,
                    keyboardType: TextInputType.text,
                    onEditingComplete: () => node.nextFocus(),
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
                  ),
                  InputComponentNoIcon(
                    textInputAction: TextInputAction.next,
                    labelText: 'Número telefónico del cliente',
                    controllerText: editTelefonoClienteController,
                    keyboardType: TextInputType.phone,
                    onEditingComplete: () => node.nextFocus(),
                    onChanged: (value) => searchContact(),
                    inputFormatters: [
                      // ignore: deprecated_member_use
                      // WhitelistingTextInputFormatter.digitsOnly,
                    ],
                    validator: (value) {
                      if (value.length > 7) {
                        return null;
                      } else {
                        return 'Ingrese el teléfono del cliente';
                      }
                    },
                  ),
                  ItemContacts(
                    number: editTelefonoClienteController.toString(),
                    contact: (Contact contact) {
                      setState(() {
                        editTelefonoClienteController.text =
                            (contact.phones!.elementAt(0).value)!
                                .replaceAll('+591', '');
                        editNombreClienteController.text =
                            contact.displayName!;
                        contactBloc.add(
                            UpdateListSelectedContact(const []));
                      });
                    }),
                  InputComponentNoIcon(
                    textInputAction: TextInputAction.next,
                    labelText: 'Correo del cliente (opcional)',
                    controllerText: editEmailClienteController,
                    keyboardType: TextInputType.emailAddress,
                    onEditingComplete: () => node.nextFocus(),
                    validator: (value){},
                  ),
                  InputComponentNoIcon(
                    textInputAction: TextInputAction.next,
                    labelText: 'Número de documento',
                    inputFormatters: [
                      // ignore: deprecated_member_use
                      // WhitelistingTextInputFormatter.digitsOnly,
                    ],
                    controllerText: editDocumentoClienteController,
                    keyboardType: TextInputType.number,
                    onEditingComplete: () => node.nextFocus(),
                    validator: (value) {
                      if (value.isNotEmpty) {
                        if (clientBloc.clients!.where((e) =>e.numberDocument.toString() == value).isEmpty) {
                          return null;
                        } else {
                          if (clientBloc.clients!.where((e) => e.numberDocument.toString() == value && e.typeDocument==typeDocumentNumber && e.id != widget.customer.id).isEmpty) {
                            return null;
                          }else{
                            return 'Existe un cliente identico';
                          }
                        }
                      } else {
                        return 'Ingrese el número de documento del cliente';
                      }
                    },
                  ),
                ],
              ))),
      actions: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ButtonWhiteComponent(
            text: 'Cancelar',
            onPressed: () => Navigator.of(context).pop(),
          ),
          ButtonComponent(
            text: 'Guardar',
            onPressed: () => saveClient(),
          )
        ])
      ],
    );
  }
  searchContact() {
    final contactBloc = BlocProvider.of<ContactBloc>(context, listen: false);
    if (editTelefonoClienteController.text.isNotEmpty) {
      if (contactBloc.state.existContact) {
        contactBloc.add(UpdateListSelectedContact(const []));
        for (Contact contact in contactBloc.state.contacts!) {
          if (contact.phones!.isNotEmpty) {
            if (contact.phones!.elementAt(0).value!.isNotEmpty) {
              if (contact.phones!
                  .elementAt(0)
                  .value!
                  .contains(editTelefonoClienteController.text)) {
                print('contact ${contact.phones} - ${contact.displayName}');
                contactBloc.add(UpdateSelectedContact(contact));
              }
            }
          }
        }
      }
    } else {
      contactBloc.add(UpdateListSelectedContact(const []));
    }
  }
  saveClient() async {
    final clientBloc = BlocProvider.of<ClientBloc>(context, listen: false);
    // final contactsProvider = Provider.of<ContactsProvider>(context, listen: false);
    // final clientsProvider = Provider.of<ClientsProvider>(context, listen: false);
    // int cont=0;
    // int cont2=0;
    if (formKey.currentState!.validate()) {
      if(typeDocumentNumber == null){
        return callDialogAction( context, 'Debe ingresar un tipo de documento');
      }
      // for (Contact contact in contactsProvider.contacts) {
      //   if (contact.phones.isNotEmpty) {
      //     if(contact.phones.elementAt(0).value.isNotEmpty){
      //       if (contact.phones.elementAt(0).value.contains==editTelefonoClienteController.text) {
      //         cont2=cont2+1;
      //       }
      //     }
      //   }
      //   cont=cont+1;
      //   if(cont==contactsProvider.contacts){
      //     if (cont2==0) {
      //     Contact newContact = Contact();
      //     newContact.givenName = editTelefonoClienteController.text.trim();
      //     newContact.phones = [
      //       Item(label: "mobile", value: editTelefonoClienteController.text.trim())
      //     ];
      //     await ContactsService.addContact(newContact);
      //     }
      //   }
      // }
      setState(() {
        widget.customer.name = editNombreClienteController.text.trim();
        widget.customer.email = editEmailClienteController.text.trim();
        widget.customer.numberDocument = int.parse(editDocumentoClienteController.text.trim());
        widget.customer.typeDocument = typeDocumentNumber;
        widget.customer.numberContact = int.parse(editTelefonoClienteController.text.trim());
      });
      clientBloc.add(UpdateClientsById(widget.customer));
      Navigator.of(context).pop();
    }
  }
}
