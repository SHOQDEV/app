part of 'client_bloc.dart';

@immutable
abstract class ClientEvent {}

class UpdateClients extends ClientEvent {
  final ClientsModel client;

  UpdateClients(this.client);
}
class UpdateAllClients extends ClientEvent {
  final List<ClientsModel> clients;

  UpdateAllClients(this.clients);
}
class RemoveClient extends ClientEvent {
  final ClientsModel client;

  RemoveClient(this.client);
}

class UpdateClientsById extends ClientEvent {
  final ClientsModel client;

  UpdateClientsById(this.client);
}