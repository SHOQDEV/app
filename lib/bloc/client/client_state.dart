part of 'client_bloc.dart';

@immutable
class ClientState {
  final bool existClient;
  final List<ClientsModel>? clients;

  const ClientState({this.existClient = false, this.clients});
  ClientState copyWith({
    bool? existClient,
    List<ClientsModel>? clients
    }) =>
      ClientState(
        existClient : existClient ?? this.existClient,
        clients     : clients     ?? this.clients,
      );
}
