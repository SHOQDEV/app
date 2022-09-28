part of 'product_sold_bloc.dart';

@immutable
abstract class ProductSoldEvent {}

class UpdateSoldProducts extends ProductSoldEvent {
  final SoldProductsModel productSold;

  UpdateSoldProducts(this.productSold);
}

class UpdateAllSoldProducts extends ProductSoldEvent {
  final List<SoldProductsModel> soldProducts;

  UpdateAllSoldProducts(this.soldProducts);
}