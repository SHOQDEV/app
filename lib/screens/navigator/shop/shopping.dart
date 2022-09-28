import 'package:app_artistica/bloc/app_state/app_state_bloc.dart';
import 'package:app_artistica/bloc/product/product_bloc.dart';
import 'package:app_artistica/components/header_pages.dart';
import 'package:app_artistica/components/icon_rounded.dart';
import 'package:app_artistica/components/input.dart';
import 'package:app_artistica/components/scann_bar_code.dart';
import 'package:app_artistica/components/selector_category.dart';
import 'package:app_artistica/main.dart';
import 'package:flutter/material.dart';
import 'package:app_artistica/screens/navigator/shop/detail_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_provider/theme_provider.dart';

class ScreenShopping extends StatefulWidget {
  const ScreenShopping({Key? key}) : super(key: key);
  @override
  _ScreenShoppingState createState() => _ScreenShoppingState();
}

class _ScreenShoppingState extends State<ScreenShopping> {
  bool stateTODOS = true;

  TextEditingController searchController = TextEditingController();
  bool _isSearching = false;
  bool btnSearch = false;
  String searchQuery = "Search query";
  String? searchQueryMayuscula;
  String? codebar;

  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context, listen: true).state;
    final appStateBloc = BlocProvider.of<AppStateBloc>(context, listen: true).state;
    return Scaffold(
        body: SingleChildScrollView(
              child:
        Column(children: <Widget>[
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const ComponentHeader(stateBack: false, text: 'Tienda'),
              // const SizedBox(height: 10),
              Row(
                mainAxisAlignment : MainAxisAlignment.spaceBetween,
                children: [
                  if(!btnSearch)
                  IconRoundedComponent(
                    icon: Icons.search,
                    onTap: () => setState(()=> btnSearch = true)),
                  if(btnSearch)
                  Expanded(
                      child: InputComponent(
                    textInputAction: TextInputAction.next,
                    controllerText: searchController,
                    onEditingComplete: () => {},
                    onChanged: (v){
                      if(searchController.text == ''){
                        setState(() => _isSearching = false);
                      }else{
                        setState(() => _isSearching = true);
                      }
                    },
                    validator: (value) {},
                    keyboardType: TextInputType.text,
                    icon: Icons.search,
                    labelText: "Buscar...",
                  )),
                  if(btnSearch)
                  GestureDetector(
                    onTap: () => setState(()=> btnSearch = false),
                    child: Icon(Icons.clear,color: ThemeProvider.themeOf(context).data.hintColor),
                  ),
                  ScannBarCodeComponent(
                      barcode: (String value) {
                        // if (productBloc.products!.where((e) => e.barCode != '0' && e.barCode == value).isNotEmpty) {
                        //   Navigator.of(context).push(
                        //     MaterialPageRoute(
                        //       builder: (context) => EventDetailsPage(product: productBloc.products!.firstWhere((e) => e.barCode != '0' && e.barCode == value)),
                        //     ),
                        //   );
                        // }
                      },
                      icon: Icons.line_weight)
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "Categorías",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SelectorCategory(),
              const Text('Mis Productos',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          )),
      Column(
        children: [
          if (productBloc.existProduct)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: !_isSearching?Row(
                children: <Widget>[
                  if (appStateBloc.selectedCategoryId == '0')
                    for (final product in productBloc.products!)
                      DetailWidget(product: product),
                  if (appStateBloc.selectedCategoryId != '0')
                    for (final product in productBloc.products!.where(
                        (e) => e.categoriaId == appStateBloc.selectedCategoryId))
                      DetailWidget(product: product)
                ],
              ):Row(
                children: [
                  for (var product in productBloc.products!.where((e) => e.nombre!.toUpperCase().contains(searchController.text.toUpperCase())))
                  DetailWidget(product: product),
                ],
              ),
            ),
        ],
      )
    ])));
  }
}
