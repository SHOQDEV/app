part of 'contact_bloc.dart';

@immutable
class ContactState {

  final bool existContact;
  final List<Contact>? contacts;
  final List<Contact>? listSelectedContacts;

  const ContactState({
    this.existContact = false,
    this.contacts,
    this.listSelectedContacts,

  });
  ContactState copyWith({
    bool? existContact,
    List<Contact>? contacts,
    List<Contact>? listSelectedContacts

  }) => ContactState(
    existContact         :   existContact        ??  this.existContact,
    contacts         :   contacts        ??  this.contacts,
    listSelectedContacts : listSelectedContacts ?? this.listSelectedContacts
  );
}
