import 'package:bloc/bloc.dart';
import 'package:app_artistica/database/product_model.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductBloc() : super(const ProductsState()) {
    on<UpdateProducts>  ( ( event,emit )  => _onUpdateProducts(event));

    on<RemoveProduct> ( ((event, emit) =>  _onRemoveProduct(event)));

    on<UpdateProductsById> ( ((event, emit) =>  _onUpdateProductsById(event)));

    on<DeleteAllProducts>((event, emit) => emit( state.copyWith( existProduct: false, products:[] ) ));

    on<UpdateAllProducts>((event, emit) {
      if(event.products.isEmpty){
        emit( state.copyWith( existProduct: false ) );
      }else{
        emit( state.copyWith( existProduct: true,products:event.products ) );
      }
    });


  }


  _onUpdateProducts( UpdateProducts event )async {
    List<ProductsModel> products = state.existProduct?[ ...state.products!, event.product ]:[ event.product ];
    emit(state.copyWith(existProduct: true, products : products));
  }
  _onUpdateProductsById( UpdateProductsById event) async {
    if( !state.existProduct) return;
    List<ProductsModel> products = state.products!;
    products[products.indexWhere((e) => e.id == event.product.id)] = event.product;
    emit(state.copyWith(products: products));
  }
  _onRemoveProduct( RemoveProduct event) async {
    final products = state.products!.where((e) => e.id != event.product.id).toList();
    emit(state.copyWith(products: products));
  }
}
