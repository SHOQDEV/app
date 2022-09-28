part of 'product_sold_bloc.dart';

@immutable
class ProductSoldState {

  final bool existProductSoldSold;
  final List<SoldProductsModel>? soldProducts;

  const ProductSoldState({
    this.existProductSoldSold = false,
    this.soldProducts

  });
  ProductSoldState copyWith({
    bool?                   existProductSoldSold,
    List<SoldProductsModel>?  soldProducts
  }) => ProductSoldState(
    existProductSoldSold          :   existProductSoldSold        ??  this.existProductSoldSold,
    soldProducts              :   soldProducts            ??  this.soldProducts,
  );

}
