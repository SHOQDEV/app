import 'dart:convert';
class ProductDetail {
  String? actividadEconomica, codigoProducto,descripcion,numeroSerie,numeroImei;
  num? precioUnitario,subTotal,montoDescuento;
  int? codigoProductoSin,cantidad,unidadMedida;
  ProductDetail(
    {
      this.descripcion,
      this.cantidad,
      this.precioUnitario,
      this.montoDescuento,
      this.subTotal,
      this.numeroSerie,
      this.numeroImei
    }
  );
    factory ProductDetail.fromJson(Map<String, dynamic> jsonData) {
      return ProductDetail(
      descripcion: jsonData['descripcion'],
      cantidad: jsonData['cantidad'],
      precioUnitario: jsonData['precioUnitario'],
      montoDescuento: jsonData['montoDescuento'],
      subTotal: jsonData['subTotal'],
      numeroSerie: jsonData['numeroSerie'],
      numeroImei: jsonData['numeroImei'],
      );
    }
    static Map<String, dynamic> toMap(ProductDetail productDetail) => {
        'descripcion':productDetail.descripcion,
        'cantidad': productDetail.cantidad,
        'precioUnitario':productDetail.precioUnitario,
        'montoDescuento':productDetail.montoDescuento,
        'subTotal': productDetail.subTotal,
        'numeroSerie': productDetail.numeroSerie,
        'numeroImei':productDetail.numeroImei,

    };
    static String encodeProductDetail(List<ProductDetail> productDetailes) => json.encode(
        productDetailes
            .map<Map<String, dynamic>>((productDetail) => ProductDetail.toMap(productDetail))
            .toList(),
    );


    static List<ProductDetail> decodeProductDetail(String productDetailes) =>
      (json.decode(productDetailes) as List<dynamic>)
          .map<ProductDetail>((item) => ProductDetail.fromJson(item))
          .toList();


}
List<ProductDetail> productDetail = <ProductDetail>[];
