part of 'product_bloc.dart';

@immutable
class ProductsState {

  final bool existProduct;
  final List<ProductsModel>? products;

  const ProductsState({
    this.existProduct = false,
    this.products

  });
  ProductsState copyWith({
    bool?                   existProduct,
    List<ProductsModel>?  products
  }) => ProductsState(
    existProduct          :   existProduct        ??  this.existProduct,
    products              :   products            ??  this.products,
  );

}