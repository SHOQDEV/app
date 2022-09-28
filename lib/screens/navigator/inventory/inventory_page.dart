
import 'package:app_artistica/screens/navigator/inventory/create_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:theme_provider/theme_provider.dart';

import 'package:app_artistica/bloc/app_state/app_state_bloc.dart';
import 'package:app_artistica/bloc/category/category_bloc.dart';
import 'package:app_artistica/bloc/product/product_bloc.dart';
import 'package:app_artistica/components/header_pages.dart';
import 'package:app_artistica/components/selector_category.dart';
import 'package:app_artistica/screens/navigator/inventory/product_card.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);
  @override
  _ShoppingState createState() => _ShoppingState();
}

class _ShoppingState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    final categoryBloc = BlocProvider.of<CategoryBloc>(context, listen: true).state;
    final productBloc = BlocProvider.of<ProductBloc>(context, listen: true).state;
    final appStateBloc = BlocProvider.of<AppStateBloc>(context, listen: true).state;
    return Scaffold(
        floatingActionButton: createNewProductServiceOrCategorie(),
        body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const ComponentHeader(stateBack: false, text: 'Inventario'),
                    if (categoryBloc.existCategory)
                      if (categoryBloc.categories!.length > 1)
                        Column(
                          crossAxisAlignment : CrossAxisAlignment.start,
                          children: const [
                            Text("Categorías", style: TextStyle(fontWeight: FontWeight.bold)),
                            SelectorCategory(),
                          ],
                        ),
                    if (!productBloc.existProduct)
                      Expanded(
                          child: Center(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/inventory.png',
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: MediaQuery.of(context).size.width * 0.85,
                              gaplessPlayback: true,
                              fit: BoxFit.scaleDown,
                            ),
                            const Text('Aún no agregaste productos')
                          ],
                        ),
                      )),
                    
                    if (productBloc.existProduct)
                      if (productBloc.products!.isNotEmpty)
                    Text(
                      productBloc.products!.isNotEmpty
                          ? '${productBloc.products!.length} Productos'
                          : '0 Producto',
                      style: const TextStyle( fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    if (productBloc.existProduct)
                      if (productBloc.products!.isNotEmpty)
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment : CrossAxisAlignment.start,
                              children: <Widget>[
                                if (appStateBloc.selectedCategoryId == '0')
                                  for (final product in productBloc.products!)
                                    ProductCard(product: product),
                                if (appStateBloc.selectedCategoryId != '0')
                                  for (final product in productBloc.products!.where((e) => e.categoriaId == appStateBloc.selectedCategoryId))
                                    ProductCard(product: product),
                              ],
                            ),
                        )),
                  ])));
  }

  createNewProductServiceOrCategorie() {
    final categoryBloc = BlocProvider.of<CategoryBloc>(context, listen: false).state;
    return SpeedDial(
      animationSpeed: 75,
      elevation: 8.0,
      backgroundColor: ThemeProvider.themeOf(context).data.primaryColorLight,
      animatedIcon: AnimatedIcons.view_list,
      animatedIconTheme:
          const IconThemeData(color: Color(0xFFF2F2F2), size: 22.0),
      visible: true,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Image.asset(
            "assets/icons/stand.png",
            fit: BoxFit.contain,
            width: MediaQuery.of(context).size.width * 0.07,
          ),
          backgroundColor: Colors.white,
          onTap: () => Navigator.pushNamed(context, 'category'),
          label: 'Añadir Categorías',
          labelStyle:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          labelBackgroundColor:
              ThemeProvider.themeOf(context).data.primaryColorLight,
        ),
        if (categoryBloc.existCategory)
            SpeedDialChild(
              child: Image.asset(
                "assets/icons/box.png",
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width * 0.07,
              ),
              backgroundColor: Colors.white,
              onTap: () {
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateProductScreen()),
            );
              },
              label: 'Añadir Producto',
              labelStyle: const TextStyle(
                  color: Color(0xFFF2F2F2), fontWeight: FontWeight.w500),
              labelBackgroundColor: const Color(0xffD89E49),
            )
      ],
    );
  }
}
