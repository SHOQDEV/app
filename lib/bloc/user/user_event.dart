part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UpdateUser extends UserEvent {
  
  final String companyName;

  UpdateUser(this.companyName);
}

class UpdateImageUser extends UserEvent {
  
  final String imageUser;

  UpdateImageUser(this.imageUser);
}

class UpdateUserAcount extends UserEvent{

  final String user;

  UpdateUserAcount(this.user);
}


class UpdateExchange extends UserEvent{

  final String paymentCurrencyText;
  final double exchangeRate;

  UpdateExchange(this.paymentCurrencyText,this.exchangeRate);
}