
import 'package:app_artistica/bloc/app_state/app_state_bloc.dart';
import 'package:app_artistica/bloc/category/category_bloc.dart';
import 'package:app_artistica/bloc/product/product_bloc.dart';
import 'package:app_artistica/bloc/selected_product/selected_product_bloc.dart';
import 'package:app_artistica/components/animate.dart';
import 'package:app_artistica/components/header_pages.dart';
import 'package:app_artistica/components/input.dart';
import 'package:app_artistica/components/button.dart';
import 'package:app_artistica/database/category_model.dart';
import 'package:app_artistica/dialogs/dialog_action.dart';
import 'package:app_artistica/dialogs/dialog_one_input.dart';
import 'package:app_artistica/screens/navigator/inventory/categories/card_category.dart';
import 'package:app_artistica/services/call_supplementary_data.dart';
import 'package:app_artistica/services/service_method.dart';
import 'package:app_artistica/services/services.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_provider/theme_provider.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({Key? key}) : super(key: key);
  @override
  _ScreenCategoryState createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameCategory = TextEditingController();
  final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
  bool expandido = false;
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final categoryBloc = BlocProvider.of<CategoryBloc>(context,listen: true).state;
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15,30,15,0),
        child: Column(
          crossAxisAlignment : CrossAxisAlignment.start,
          children: <Widget>[
            const ComponentHeader(stateBack: true, text: 'Categorias'),
                  Form(
                        key: formKey,
                        child: ExpansionTileCard(
                          contentPadding: const EdgeInsets.symmetric( vertical: 10),
                          expandedColor: ThemeProvider.themeOf(context).data.scaffoldBackgroundColor,
                          key: cardA,
                          leading: CircleAvatar(
                              backgroundColor: ThemeProvider.themeOf(context).data.primaryColorLight,
                              child: const Icon(Icons.add, color: Colors.white)),
                          title: const Text('Añadir Nueva Categoría'),
                          onExpansionChanged: (expands) {
                            if (expands) {
                              focusNode.requestFocus();
                              setState(() => expandido = true);
                              nameCategory.text = '';
                            } else {
                              setState(() => expandido = false);
                            }
                          },
                          children: <Widget>[
                           Padding(
                                padding: const EdgeInsets.only(left: 20, right: 20),
                                child:InputComponentNoIcon(
                                  focusNode: focusNode,
                                  textInputAction: TextInputAction.done,
                                  labelText: 'Nombre de la categoría',
                                  controllerText: nameCategory,
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  keyboardType: TextInputType.text,
                                  onEditingComplete: () => createCategory(),
                                  validator: (value) {
                                    if (value.isNotEmpty) {
                                      if(!categoryBloc.existCategory){
                                        return null;
                                      }else{
                                        if(categoryBloc.categories!.where((e) => (e.nombre == nameCategory.text.trim().toUpperCase())).isEmpty && value.trim().toUpperCase()!='TODOS'){
                                          return null;
                                        }else{
                                          return 'Existe una categoría con un nombre similar';
                                        }
                                      }
                                    } else {
                                        return 'Ingrese nombre de la categoría';
                                    }
                                  },
                                )),
                            ButtonBar(
                              alignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                ButtonWhiteComponent(
                                  text: 'CANCELAR',
                                  onPressed: () => cardA.currentState?.collapse(),
                                ),
                                ButtonComponent(
                                  text: 'GUARDAR',
                                  onPressed: () => createCategory(),
                                ),
                              ],
                            ),
                          ],
                      )),
            Text('${categoryBloc.categories!.where((e) => e.id != '0').length} Categorias:',style: const TextStyle(fontWeight: FontWeight.bold)),
            Expanded(child: 
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  for (CategoriesModel category in categoryBloc.categories!)
                    if(category.id != '0')
                      CardCategory(
                        delete: () => deleteCategory(category),
                        edit: () => editCategory(category),
                        category: category,
                      )
                ],
              ),
            ),)
          ],
        ),
      )
    );
  }

  createCategory() async {
    final categoryBloc = BlocProvider.of<CategoryBloc>(context,listen: false);
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      final Map<String, dynamic> data = {
        "nombre":nameCategory.text.trim().toUpperCase()
      };
      var response = await serviceMethod( context, 'post', data, serviceCategory(null), true, null );
      if (response != null) {
        final categoriesModel = CategoriesModel(
          id: response.data['_id'],
          nombre: response.data['nombre'],
          updatedAt: response.data['updatedAt']);
        categoryBloc.add(UpdateCategories(categoriesModel));
        callInfoSupplementary( context );
        return cardA.currentState?.collapse();
      }
    }
  }

  editCategory(CategoriesModel category) async {
    final categoryBloc = BlocProvider.of<CategoryBloc>(context,listen: false);
    setState(() => nameCategory.text = category.nombre!);
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return ComponentAnimate(
              child: DialogOneInputAction(
                  controllerText:nameCategory,
                  title:'categoría',
                  message:'EDITAR ${category.nombre}',
                  textCapitalization:TextCapitalization.characters,
                  validator: (value) {
                    if (value.isNotEmpty) {
                      if(categoryBloc.state.categories!.where((e) => (e.nombre == nameCategory.text.trim().toUpperCase())).isEmpty && value.trim().toUpperCase()!='TODOS'){
                        return null;
                      }else{
                        return 'Existe una categoría con un nombre similar';
                      }
                    } else {
                        return 'Ingrese nombre de la categoría';
                    }
                  },
                  messageCorrect:'Editar',
                  actionCorrect:(nameCategory)=>seviceUpdate(nameCategory.text.trim(),category),
                  ));
        });
  }
  seviceUpdate(String nameCategory,CategoriesModel category)async{
    final categoryBloc = BlocProvider.of<CategoryBloc>(context,listen: false);
    final Map<String, dynamic> data = {
      "nombre":nameCategory
    };
    var response = await serviceMethod( context, 'put', data, serviceCategory(category.id), true, null );
    if (response != null) {
      category.nombre = response.data['nombre'];
      category.updatedAt = response.data['updatedAt'];
      categoryBloc.add(UpdateCategoriesById(category));
      callInfoSupplementary( context );
      Navigator.of(context).pop();
    }
  }
  deleteCategory(CategoriesModel category) async {
    await showDialog(
    context: context,
    builder: (BuildContext context) {
      return ComponentAnimate(
          child:DialogTwoAction(
            message: '¿Desea eliminar la categoría ${category.nombre}?',
            messageCorrect:'Eliminar',
          actionCorrect:() => seviceDelete(category)
          ));
    });
  }
  seviceDelete(CategoriesModel category)async{
    final selectedProductBloc = BlocProvider.of<SelectedProductBloc>(context,listen: false);
    final productBloc = BlocProvider.of<ProductBloc>(context,listen: false);
    final appStateBloc = BlocProvider.of<AppStateBloc>(context,listen: false);
    final categoryBloc = BlocProvider.of<CategoryBloc>(context,listen: false);
    var response = await serviceMethod( context, 'delete', null, serviceCategory(category.id), true, null );
    if(response != null){
      categoryBloc.add(RemoveCategory(category));
      if(productBloc.state.existProduct){
        for (final product in productBloc.state.products!.where((e) => e.categoriaId == category.id)) {
          if(selectedProductBloc.state.existSelectedProduct){
            for (final selectedProduct in selectedProductBloc.state.selectedProducts!.where((e) => e.productId == product.id)) {
              selectedProductBloc.add(RemoveSelectedProduct(selectedProduct));
              selectedProductBloc.add(CalculateTotalCount());
            }
          }
          productBloc.add(RemoveProduct(product));
        }
      }
      appStateBloc.add(UpdateCategorieId('0'));
      callInfoSupplementary( context );
      Navigator.of(context).pop();
    }
  }
}
