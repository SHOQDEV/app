import 'package:app_artistica/database/client_model.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:app_artistica/bloc/client/client_bloc.dart';
import 'package:app_artistica/bloc/contact/contact_bloc.dart';
import 'package:app_artistica/components/input.dart';
import 'package:app_artistica/components/button.dart';
// import 'package:app_artistica/database/db_provider.dart';
import 'package:app_artistica/utils/search_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DialogNewClient extends StatefulWidget {
  final String nameClient;
  final String documentClient;
  final int typeDocument;
  final Function(ClientsModel) correct;
  const DialogNewClient(
      {Key? key,
      required this.nameClient,
      required this.documentClient,
      required this.typeDocument,
      required this.correct})
      : super(key: key);

  @override
  State<DialogNewClient> createState() => _DialogNewClientState();
}

class _DialogNewClientState extends State<DialogNewClient> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController phoneClientController = TextEditingController();
  TextEditingController emailClientController = TextEditingController();
  bool isContact = false;
  bool existContact = true;
  // List<Contact> list=[];
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    final contactBloc = BlocProvider.of<ContactBloc>(context, listen: true);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: const Center(child: Text('Cliente Nuevo')),
      content: SingleChildScrollView(
          child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Nombre: ${widget.nameClient} "),
                  Text("Número de documento: ${widget.documentClient}"),
                  InputComponentNoIcon(
                    textInputAction: TextInputAction.next,
                    labelText: 'Número telefónico del cliente',
                    controllerText: phoneClientController,
                    keyboardType: TextInputType.phone,
                    onEditingComplete: () => node.nextFocus(),
                    inputFormatters: [
                      // ignore: deprecated_member_use
                      // WhitelistingTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (value) async {
                      // setState(()=>list=[]);
                      await searchContact();
                      // contactBloc.add(UpdateSelectedContact(contact));
                      // contactsProvider.updateContactsSelectProvider(list);
                    },
                    validator: (value) {
                      if (value.length > 7) {
                        return null;
                      } else {
                        return 'Ingrese el teléfono del cliente';
                      }
                    },
                  ),
                  ItemContacts(
                    number: phoneClientController.toString(),
                    contact: (Contact contact) {
                      setState(() {
                        phoneClientController.text = (contact.phones!.elementAt(0).value)! .replaceAll('+591', '');
                        // nombreClienteController.text = contact.displayName!;
                        contactBloc.add( UpdateListSelectedContact(const []));
                      });
                    }),
                  InputComponentNoIcon(
                    textInputAction: TextInputAction.next,
                    labelText: 'Correo del cliente (opcional)',
                    controllerText: emailClientController,
                    keyboardType: TextInputType.emailAddress,
                    onEditingComplete: () => node.nextFocus(),
                    validator: (value){},
                  ),
                ],
              ))),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ButtonWhiteComponent(
              text: 'Cancelar',
              onPressed: () => Navigator.of(context).pop(),
            ),
            ButtonComponent(
              text: 'Crear',
              onPressed: () => saveClient(),
            )
          ],
        )
      ],
    );
  }
  searchContact(){
    final contactBloc = BlocProvider.of<ContactBloc>(context, listen: false);
    if (phoneClientController.text.isNotEmpty) {
      if (contactBloc.state.existContact) {
        contactBloc.add(UpdateListSelectedContact(const []));
        for (Contact contact in contactBloc.state.contacts!) {
          if (contact.phones!.isNotEmpty) {
            if(contact.phones!.elementAt(0).value!.isNotEmpty){
              if (contact.phones!.elementAt(0).value!.contains(phoneClientController.text)) {
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
    final contactBloc = BlocProvider.of<ContactBloc>(context, listen: false).state;
    FocusScope.of(context).unfocus();
    int cont=0;
    int cont2=0;
    
    if (formKey.currentState!.validate()) {
      // for (Contact contact in contactBloc.contacts!) {
      //   if (contact.phones!.isNotEmpty) {
      //     if(contact.phones!.elementAt(0).value!.isNotEmpty){
      //       if (contact.phones!.elementAt(0).value!.contains==phoneClientController.text) {
      //         cont2=cont2+1;
      //       }
      //     }
      //   }
      //   cont=cont+1;
      //   if(cont==contactBloc.contacts){
      //     if (cont2==0) {
      //     Contact newContact = Contact();
      //     newContact.givenName = widget.nameClient.trim();
      //     newContact.phones = [
      //       Item(label: "mobile", value: phoneClientController.text.trim())
      //     ];
      //     await ContactsService.addContact(newContact);
      //     }
      //   }
      // }
      //AGREGANDO A LA TABLA clients_ff
      // final clientModel = ClientsModel(
      //   name: widget.nameClient.trim(),
      //   email: emailClientController.text.trim(),
      //   numberDocument: int.parse(widget.documentClient.trim()),
      //   typeDocument: widget.typeDocument,
      //   numberContact: int.parse(phoneClientController.text.trim())
      // );
      // await DBProvider.db.newClientsModel(clientModel)
      // .then((value) => DBProvider.db.getClientsModelById(value)
      // .then((value2) {
      //   clientBloc.add(UpdateClients(value2));
      //   widget.correct(value2);
      // }));
 
  }
}
}