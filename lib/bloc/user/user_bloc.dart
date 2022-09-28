import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState()) {
    on<UpdateUser>((event, emit) => emit( state.copyWith( companyName:event.companyName) ));
    on<UpdateImageUser>((event, emit) => emit( state.copyWith( imageUser:event.imageUser) ));
    on<UpdateUserAcount>((event, emit) => emit( state.copyWith( user:event.user)));
    on<UpdateExchange>((event, emit) => emit( state.copyWith( paymentCurrencyText:event.paymentCurrencyText, exchangeRate:event.exchangeRate)));
  }
}
