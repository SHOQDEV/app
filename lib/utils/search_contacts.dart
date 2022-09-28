import 'package:contacts_service/contacts_service.dart';
import 'package:app_artistica/bloc/contact/contact_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemContacts extends StatefulWidget {
  final String number;
  final Function(Contact) contact;
  const ItemContacts(
      {Key? key,
      required this.number,
      required this.contact})
      : super(key: key);

  @override
  State<ItemContacts> createState() => _ItemContactsState();
}

class _ItemContactsState extends State<ItemContacts> {
  @override
  Widget build(BuildContext context) { 
    final contactBloc = BlocProvider.of<ContactBloc>(context, listen: true).state;
    return Visibility(
      visible: contactBloc.existContact,
      child: contactBloc.listSelectedContacts!.isNotEmpty?
      SizedBox(
          height: 180,
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (contactBloc.existContact)
                for (Contact contact in contactBloc.listSelectedContacts!)
                  ListTile(
                    onTap: () {
                      widget.contact(contact);
                    },
                    leading: (contact.avatar != null && contact.avatar!.isNotEmpty)
                        ? CircleAvatar(
                            backgroundImage: MemoryImage(contact.avatar!))
                        : Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffD89E49),
                            ),
                            child: CircleAvatar(
                                child: Text(contact.initials(),
                                    style:
                                        const TextStyle(color: Colors.white)),
                                backgroundColor: Colors.transparent)),
                    title: Text('Nombre: ${contact.displayName}'),
                    subtitle: Text(
                        'Número: ${contact.phones!.isNotEmpty ? contact.phones!.elementAt(0).value : ''}'),
                  )
              ],
            ),
          )
          ):Container(),
    );
  }
}
