part of 'user_bloc.dart';

@immutable
class UserState {

  final String companyName;
  final String? imageUser;
  final String? nit;
  final String? user;


  final String paymentCurrencyText;
  final double exchangeRate;


  const UserState({
    this.companyName = '',
    this.imageUser,
    this.nit,
    this.user,

    this.paymentCurrencyText ='BOLIVIANO',
    this.exchangeRate=1.0

  });
  UserState copyWith({
    String? companyName,
    String? imageUser,
    String? imageProduct,
    String? imageService,
    String? nit,
    String? user,
    String? paymentCurrencyText,
    double? exchangeRate

  }) => UserState(
    companyName            :   companyName              ??   this.companyName,
    imageUser              :   imageUser                ??   this.imageUser,
    nit                    :   nit                      ??   this.nit,
    user                   :   user                     ??   this.user,
    paymentCurrencyText    :   paymentCurrencyText      ??   this.paymentCurrencyText,
    exchangeRate           :   exchangeRate             ??   this.exchangeRate,
  );
  
}
