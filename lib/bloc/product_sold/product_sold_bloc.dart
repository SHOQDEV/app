import 'package:bloc/bloc.dart';
import 'package:app_artistica/database/sale_product_model.dart';
import 'package:meta/meta.dart';

part 'product_sold_event.dart';
part 'product_sold_state.dart';

class ProductSoldBloc extends Bloc<ProductSoldEvent, ProductSoldState> {
  ProductSoldBloc() : super(const ProductSoldState()) {

    on<UpdateSoldProducts>  ( ( event,emit )  => _onUpdateSoldProducts( event ));

    on<UpdateAllSoldProducts>((event, emit) {
      if(event.soldProducts.isEmpty){
        emit( state.copyWith( existProductSoldSold: false ) );
      }else{
        emit( state.copyWith( existProductSoldSold: true,soldProducts:event.soldProducts ) );
      }
    });

  }

  _onUpdateSoldProducts( UpdateSoldProducts event )async {
    List<SoldProductsModel> soldProducts = state.existProductSoldSold?[ ...state.soldProducts!, event.productSold ]:[ event.productSold ];
    emit(state.copyWith(existProductSoldSold: true, soldProducts : soldProducts));
  }
  
}
