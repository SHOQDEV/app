import 'package:bloc/bloc.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:meta/meta.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(const ContactState()) {

    on<UpdateListSelectedContact>  ( ( event,emit )  => emit(state.copyWith(listSelectedContacts : event.contacts)));

    on<UpdateContact>  ( ( event,emit )  => emit(state.copyWith(existContact:true, contacts : event.contacts, listSelectedContacts:[])));

    on<UpdateSelectedContact>  ( ( event,emit )  => _onUpdateSelectedContact( event ));
  }

  _onUpdateSelectedContact( UpdateSelectedContact event )async {
    List<Contact> categories = state.listSelectedContacts!.isNotEmpty?[ ...state.listSelectedContacts!, event.contact ]:[ event.contact ];
    emit(state.copyWith(listSelectedContacts : categories));
  }
}
