part of 'contact_bloc.dart';

@immutable
abstract class ContactEvent {}



class UpdateContact extends ContactEvent {
  
  final List<Contact> contacts;

  UpdateContact(this.contacts);
}

class UpdateListSelectedContact extends ContactEvent {
  
  final List<Contact> contacts;

  UpdateListSelectedContact(this.contacts);
}


class UpdateSelectedContact extends ContactEvent {
  
  final Contact contact;

  UpdateSelectedContact(this.contact);
}