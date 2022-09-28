import 'package:bloc/bloc.dart';
import 'package:app_artistica/database/selected_product_model.dart';
import 'package:meta/meta.dart';

part 'selected_product_event.dart';
part 'selected_product_state.dart';

class SelectedProductBloc extends Bloc<SelectedProductEvent, SelectedProductState> {
  SelectedProductBloc() : super(const SelectedProductState()) {
    on<UpdateSelectedProducts>  ( ( event,emit )  => _onUpdateSelectedProducts(event));

    on<UpdateSelectedProductById>  ( ( event,emit )  => _onUpdateSelectedProductById( event ));

    on<RemoveSelectedProduct>  ( ( event,emit )  => _onRemoveSelectedProduct( event ));

    on<CalculateTotalCount>  ( ( event,emit )  => _onCalculateTotalCount( event ));

    on<ClearTotalAcount>  ( ( event,emit )  => emit( state.copyWith( totalCount: 0.0 ) ));

    on<UpdateAllSelectedProducts>((event, emit) {
      if(event.selectedProducts.isEmpty){
        emit( state.copyWith( existSelectedProduct: false ) );
      }else{
        emit( state.copyWith( existSelectedProduct: true,selectedProducts:event.selectedProducts ) );
      }
    });



    on<ClearSelectedProducts>  ( ( event,emit )  => emit( state.copyWith( existSelectedProduct: false, selectedProducts:[] ) ));
  }
  _onUpdateSelectedProducts( UpdateSelectedProducts event )async {
    List<SelectedProductsModel> selectedProducts = state.existSelectedProduct?[ ...state.selectedProducts!, event.selectedProducts ]:[ event.selectedProducts ];
    emit(state.copyWith(existSelectedProduct: true, selectedProducts : selectedProducts));
  }

  _onUpdateSelectedProductById( UpdateSelectedProductById event) async {
    if( !state.existSelectedProduct) return;
    List<SelectedProductsModel> selectedProducts = state.selectedProducts!;
    selectedProducts[selectedProducts.indexWhere((e) => e.id == event.selectedProducts.id)] = event.selectedProducts;
    emit(state.copyWith(selectedProducts: selectedProducts));
  }

  _onRemoveSelectedProduct( RemoveSelectedProduct event) async {
    final selectedProducts = state.selectedProducts!.where((e) => e.id != event.selectedProduct.id).toList();
    emit(state.copyWith(selectedProducts: selectedProducts));
  }


  _onCalculateTotalCount( CalculateTotalCount  event )async{
    double aux;
    double aux2 = 0.0;
    double aux3 = 0.0;
    if (!state.existSelectedProduct) return;
    for (final item in state.selectedProducts!) {
      if(item.typeDiscount == 'PORCENTAJE'){
        
        aux3 = ((item.discount! / 100) * (item.quantity! * item.price!)); //5.025

      }else{

        aux3 = item.discount!;

      }
      aux = (item.quantity! * item.price!) - aux3;
      aux2 = double.parse(aux2.toStringAsFixed(2)) +  double.parse(aux.toStringAsFixed(2));  
    }
    emit(state.copyWith(totalCount: double.parse(aux2.toStringAsFixed(2))));
  }

}