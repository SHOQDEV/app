import 'package:app_artistica/bloc/category/category_bloc.dart';
import 'package:app_artistica/bloc/client/client_bloc.dart';
import 'package:app_artistica/bloc/invoice/invoice_bloc.dart';
import 'package:app_artistica/bloc/product/product_bloc.dart';
import 'package:app_artistica/bloc/product_sold/product_sold_bloc.dart';
import 'package:app_artistica/bloc/selected_product/selected_product_bloc.dart';
import 'package:app_artistica/bloc/user/user_bloc.dart';
import 'package:app_artistica/database/db_provider.dart';
import 'package:app_artistica/screens/login.dart';
import 'package:app_artistica/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final userBloc = BlocProvider.of<UserBloc>(context, listen: false);
    final categoryBloc = BlocProvider.of<CategoryBloc>(context, listen: false);
    final productBloc = BlocProvider.of<ProductBloc>(context, listen: false);
    final clientBloc = BlocProvider.of<ClientBloc>(context,listen: false);
    final selectedProductBloc = BlocProvider.of<SelectedProductBloc>(context,listen: false);
    final productSoldBloc = BlocProvider.of<ProductSoldBloc>(context,listen: false);
    final invoiceBloc = BlocProvider.of<InvoiceBloc>(context,listen: false);
    
    
    

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readAccessToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) return const Text('');

            if (snapshot.data == '') {
              Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const LoginScreen( stateLoginAuth : false ),
                        transitionDuration: const Duration(seconds: 0)));
              });
            } else {
              // userBloc.add(UpdateUser(prefs!.getString('companyName')!));
              // userBloc.add(UpdateImageUser(prefs!.getString('imageUser')!));
              //categorias
              // DBProvider.db.getALLCategoriesModel().then((res) => categoryBloc.add(UpdateAllCategories(res)));
              // DBProvider.db.getALLProductsModel().then((res) => productBloc.add(UpdateAllProducts(res)));
              DBProvider.db.getALLClientsModel().then((res) => clientBloc.add(UpdateAllClients(res)));
              DBProvider.db.getALLSelectedProductsModel().then((res) {
                selectedProductBloc.add(UpdateAllSelectedProducts(res));
                selectedProductBloc.add(CalculateTotalCount());
              });
              DBProvider.db.getALLSoldProductsModel().then((res) => productSoldBloc.add(UpdateAllSoldProducts(res)));
              DBProvider.db.getALLInvoicesModel().then((res) {
                invoiceBloc.add(UpdateAllInvoices(res));
                invoiceBloc.add(ShowInvoices());
              });
              
              
              Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const LoginScreen( stateLoginAuth : true ),
                        transitionDuration: const Duration(seconds: 0)));
              });
            }
            return Container();
          },
        ),
      ),
    );
  }
}
