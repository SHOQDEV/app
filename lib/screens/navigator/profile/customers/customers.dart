import 'package:app_artistica/database/client_model.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:app_artistica/bloc/client/client_bloc.dart';
import 'package:app_artistica/bloc/contact/contact_bloc.dart';
import 'package:app_artistica/components/header_pages.dart';
import 'package:app_artistica/components/input.dart';
import 'package:app_artistica/components/button.dart';
import 'package:app_artistica/dialogs/dialog_action.dart';
import 'package:app_artistica/utils/search_contacts.dart';
import 'package:app_artistica/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:app_artistica/screens/navigator/profile/customers/customer_item_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_provider/theme_provider.dart';

class Customers extends StatefulWidget {
  const Customers({
    Key? key,
  }) : super(key: key);
  @override
  _CustomersScreen createState() => _CustomersScreen();
}

class _CustomersScreen extends State<Customers> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ExpansionTileCardState> cardB = GlobalKey();
  bool expandido = false;
  int? typeDocumentNumber;
  TextEditingController searchController = TextEditingController();
  TextEditingController nombreClienteController = TextEditingController();
  TextEditingController correoClienteController = TextEditingController();
  TextEditingController telefonoClienteController = TextEditingController();
  TextEditingController documentoClienteController = TextEditingController();
  FocusNode? focusNode;
  
  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    final clientBloc = BlocProvider.of<ClientBloc>(context, listen: true).state;
    final contactBloc = BlocProvider.of<ContactBloc>(context, listen: true);
    return Scaffold(
      body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Column(children: <Widget>[
              const ComponentHeader(stateBack: true, text: 'Clientes'),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Form(
                          key: formKey,
                          child: ExpansionTileCard(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10),
                            expandedColor: ThemeProvider.themeOf(context)
                                .data
                                .scaffoldBackgroundColor,
                            key: cardB,
                            leading: CircleAvatar(
                                backgroundColor: ThemeProvider.themeOf(context)
                                    .data
                                    .primaryColorLight,
                                child:
                                    const Icon(Icons.add, color: Colors.white)),
                            title: const Text('Añadir Nuevo Cliente'),
                            onExpansionChanged: (expands) {
                              if (expands) {
                                contactBloc
                                    .add(UpdateListSelectedContact(const []));
                                focusNode!.requestFocus();
                                setState(() => expandido = true);
                                nombreClienteController.text = '';
                                searchController.text = '';
                                documentoClienteController.text = '';
                                correoClienteController.text = '';
                                telefonoClienteController.text = '';
                              } else {
                                setState(() => expandido = false);
                              }
                            },
                            children: <Widget>[
                              InputComponentNoIcon(
                                textInputAction: TextInputAction.next,
                                labelText: 'Número telefónico del cliente',
                                controllerText: searchController,
                                keyboardType: TextInputType.phone,
                                onEditingComplete: () => node.nextFocus(),
                                onChanged: (value) => searchContact(),
                                validator: (value) {
                                  if (value.length > 7) {
                                    return null;
                                  } else {
                                    return 'Ingrese el teléfono del cliente';
                                  }
                                },
                              ),
                              ItemContacts(
                                  number: searchController.toString(),
                                  contact: (Contact contact) {
                                    setState(() {
                                      searchController.text =
                                          (contact.phones!.elementAt(0).value)!
                                              .replaceAll('+591', '');
                                      nombreClienteController.text =
                                          contact.displayName!;
                                      contactBloc.add(
                                          UpdateListSelectedContact(const []));
                                    });
                                  }),
                              InputComponentNoIcon(
                                textInputAction: TextInputAction.next,
                                labelText: 'Nombre del cliente',
                                textCapitalization:
                                    TextCapitalization.characters,
                                controllerText: nombreClienteController,
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
                                labelText: 'Correo del cliente (opcional)',
                                controllerText: correoClienteController,
                                keyboardType: TextInputType.emailAddress,
                                onEditingComplete: () => node.nextFocus(),
                                validator: (value) {},
                              ),
                              InputComponentNoIcon(
                                textInputAction: TextInputAction.next,
                                labelText: 'Número de documento',
                                controllerText: documentoClienteController,
                                keyboardType: TextInputType.number,
                                onEditingComplete: () => node.nextFocus(),
                                validator: (value) {
                                  if (value.isNotEmpty) {
                                    if (clientBloc.existClient) {
                                      return null;
                                    } else {
                                      if (clientBloc.clients!
                                          .where((e) =>
                                              e.numberDocument.toString() ==
                                              value)
                                          .isEmpty) {
                                        return null;
                                      } else {
                                        if (clientBloc.clients!
                                            .where((e) => e.numberDocument.toString() == value && e.typeDocument == typeDocumentNumber)
                                            .isEmpty) {
                                          return null;
                                        } else {
                                          return 'Existe un cliente identico';
                                        }
                                      }
                                    }
                                  } else {
                                    return 'Ingrese el número de documento del cliente';
                                  }
                                },
                              ),
                              const Divider(),
                              ButtonBar(
                                alignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  ButtonWhiteComponent(
                                      text: 'CANCELAR',
                                      onPressed: () =>
                                          cardB.currentState?.collapse()),
                                  ButtonComponent(
                                    text: 'GUARDAR',
                                    onPressed: () => saveClient(),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      if (clientBloc.existClient)
                        for (var customer in clientBloc.clients!)
                          CustomerItemWidget(client: customer)
                    ],
                  ),
                ),
              )
            ])),
    );
  }

  searchContact() {
    final contactBloc = BlocProvider.of<ContactBloc>(context, listen: false);
    if (searchController.text.isNotEmpty) {
      if (contactBloc.state.existContact) {
        contactBloc.add(UpdateListSelectedContact(const []));
        for (Contact contact in contactBloc.state.contacts!) {
          if (contact.phones!.isNotEmpty) {
            if (contact.phones!.elementAt(0).value!.isNotEmpty) {
              if (contact.phones!
                  .elementAt(0)
                  .value!
                  .contains(searchController.text)) {
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
    print('saveClient');
    final clientBloc = BlocProvider.of<ClientBloc>(context, listen: false);
    // int cont=0;
    // int cont2=0;
    FocusScope.of(context).unfocus();

    if (formKey.currentState!.validate()) {
      if(typeDocumentNumber == null){
        return callDialogAction( context, 'Debe ingresar un tipo de documento');
      }
      // for (Contact contact in contactBloc.contacts!) {
      //   if (contact.phones!.isNotEmpty) {
      //     if(contact.phones!.elementAt(0).value!.isNotEmpty){
      //       if (contact.phones!.elementAt(0).value!.contains==searchController.text) {
      //         cont2=cont2+1;
      //       }
      //     }
      //   }
      //   cont=cont+1;
      //   if(cont==contactBloc.contacts){
      //     if (cont2==0) {
      //     Contact newContact = Contact();
      //     newContact.givenName = nombreClienteController.text.trim();
      //     newContact.phones = [
      //       Item(label: "mobile", value: searchController.text.trim())
      //     ];
      //     await ContactsService.addContact(newContact);
      //     }
      //   }
      // }
      //AGREGANDO A LA TABLA clients_ff
      // final clientModel = ClientsModel(
      //     name: nombreClienteController.text.trim(),
      //     email: correoClienteController.text.trim(),
      //     numberDocument: int.parse(documentoClienteController.text.trim()),
      //     typeDocument: typeDocumentNumber,
      //     numberContact: int.parse(searchController.text.trim()));
      // var idClient = await DBProvider.db.newClientsModel(clientModel);
      // DBProvider.db.getClientsModelById(idClient).then((res) => clientBloc.add(UpdateClients(res)));
      cardB.currentState?.collapse();
    }
  }
}
