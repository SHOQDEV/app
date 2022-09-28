
import 'package:app_artistica/bloc/category/category_bloc.dart';
import 'package:app_artistica/bloc/product/product_bloc.dart';
import 'package:app_artistica/database/category_model.dart';
import 'package:app_artistica/database/product_model.dart';
import 'package:app_artistica/main.dart';
import 'package:app_artistica/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'service_method.dart';



void callInfoSupplementary( context )async{

    await callCategories(context);
    await callProducts(context);

}


callCategories( context ) async {
  final categoryBloc = BlocProvider.of<CategoryBloc>(context,listen: false);
  var response = await serviceMethod( context, 'get', null, serviceCategory(null), true, null );
  if ( response != null ) {
    if (prefs!.getString('listCategories') != response.data['id']) {
      print('ALGO CAMBIO EN LAS CATEGORIAS');
      prefs!.setString('listCategories', response.data['id']);
      List<CategoriesModel> categories = [];
      final categoriesModel = CategoriesModel(
        id:'0',
        nombre: 'TODOS',
        updatedAt: '');
      categories.add(categoriesModel);
      for (var item in response.data['categorias']) {
        final categoriesModel = CategoriesModel(
          id:item['_id'],
          nombre: item['nombre'], 
          updatedAt: item['updatedAt']);
        categories.add(categoriesModel);
      }
      categoryBloc.add(UpdateAllCategories(categories));
    }else{
      print('TODO SIGUE IGUAL EN LAS CATEGORIAS');
    }
  }
}

callProducts( context ) async {
  final productBloc = BlocProvider.of<ProductBloc>(context,listen: false);
  var response = await serviceMethod( context, 'get', null, serviceProduct(null), true, null );
  if ( response != null ) {
    if (prefs!.getString('listProducts') != response.data['id']) {
      print('ALGO CAMBIO EN LOS PRODUCTOS');
      prefs!.setString('listProducts', response.data['id']);
      List<ProductsModel> products = [];
      for (var item in response.data['productos']) {
        final productsModel = ProductsModel(
          precio: double.parse(item['precio'].toString()),
          cantidad: item['cantidad'],
          codbarras: item['codbarras'],
          vendidos: item['vendidos'],
          id:item['_id'],
          nombre:item['nombre'],
          categoriaId:item['categoria']['_id'],
          descripcion:item['descripcion'],
          img:item['img'],
          updatedAt:item['updatedAt']
          );
        products.add(productsModel);
      }
      productBloc.add(UpdateAllProducts(products));
    }else{
      print('TODO SIGUE IGUAL EN LOS PRODUCTOS');
    }
  }
}