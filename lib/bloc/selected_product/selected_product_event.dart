part of 'selected_product_bloc.dart';

@immutable
abstract class SelectedProductEvent {}

class UpdateSelectedProducts extends SelectedProductEvent {
  final SelectedProductsModel selectedProducts;

  UpdateSelectedProducts(this.selectedProducts);
}


class UpdateAllSelectedProducts extends SelectedProductEvent {
  final List<SelectedProductsModel> selectedProducts;

  UpdateAllSelectedProducts(this.selectedProducts);
}


class UpdateSelectedProductById extends SelectedProductEvent {
  final SelectedProductsModel selectedProducts;

  UpdateSelectedProductById(this.selectedProducts);
}

class RemoveSelectedProduct extends SelectedProductEvent {
  final SelectedProductsModel selectedProduct;

  RemoveSelectedProduct(this.selectedProduct);
}

class ClearSelectedProducts extends SelectedProductEvent {

  ClearSelectedProducts();
}

class CalculateTotalCount extends SelectedProductEvent {

  CalculateTotalCount();
}

class ClearTotalAcount extends SelectedProductEvent {

  ClearTotalAcount();
}