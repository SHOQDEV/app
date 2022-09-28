import 'package:bloc/bloc.dart';
import 'package:app_artistica/database/client_model.dart';
import 'package:meta/meta.dart';

part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  ClientBloc() : super(const ClientState()) {

    on<UpdateClients>  ( ( event,emit )  => _onUpdateClients(event));


    on<UpdateClientsById>  ( ( event,emit )  => _onUpdateClientsById( event ));


    on<RemoveClient>  ( ( event,emit )  => _onRemoveClient( event ));


    on<UpdateAllClients>((event, emit) {
      if(event.clients.isEmpty){
        emit( state.copyWith( existClient: false ) );
      }else{
        emit( state.copyWith( existClient: true,clients:event.clients ) );
      }
    });
    
  }

  _onRemoveClient( RemoveClient event )async {
    final clients = state.clients!.where((e) => e.id != event.client.id).toList();
    emit(state.copyWith(clients: clients));
  }

  _onUpdateClients( UpdateClients event )async {
    List<ClientsModel> clients = state.existClient?[ ...state.clients!, event.client ]:[ event.client ];
    emit(state.copyWith(existClient: true, clients : clients));
  }

  _onUpdateClientsById( UpdateClientsById event )async{
    if( !state.existClient) return;
    List<ClientsModel> clients = state.clients!;
    clients[clients.indexWhere((e) => e.id == event.client.id)] = event.client;
    emit(state.copyWith(clients: clients));
  }
}
