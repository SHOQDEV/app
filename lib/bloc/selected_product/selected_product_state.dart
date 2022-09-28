part of 'selected_product_bloc.dart';

@immutable
class SelectedProductState {

  final bool existSelectedProduct;
  final List<SelectedProductsModel>? selectedProducts;


  final double totalCount;

  const SelectedProductState({
    this.existSelectedProduct = false,
    this.selectedProducts,
    this.totalCount = 0.0

  });
  SelectedProductState copyWith({
    bool?                         existSelectedProduct,
    List<SelectedProductsModel>?  selectedProducts,
    double?                       totalCount,
  }) => SelectedProductState(
    existSelectedProduct          :   existSelectedProduct        ??  this.existSelectedProduct,
    selectedProducts              :   selectedProducts            ??  this.selectedProducts,
    totalCount                    :   totalCount                  ??  this.totalCount
  );

}
