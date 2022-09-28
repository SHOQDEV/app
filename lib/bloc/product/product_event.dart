part of 'product_bloc.dart';

@immutable
abstract class ProductsEvent {}

class UpdateProducts extends ProductsEvent {
  final ProductsModel product;

  UpdateProducts(this.product);
}


class UpdateAllProducts extends ProductsEvent {
  final List<ProductsModel> products;

  UpdateAllProducts(this.products);
}

class UpdateProductsById extends ProductsEvent {
  final ProductsModel product;

  UpdateProductsById(this.product);
}

class RemoveProduct extends ProductsEvent {
  final ProductsModel product;

  RemoveProduct(this.product);
}

class DeleteAllProducts extends ProductsEvent {

  DeleteAllProducts();
}

