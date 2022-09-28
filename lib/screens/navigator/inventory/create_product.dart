import 'dart:io';

import 'package:app_artistica/bloc/category/category_bloc.dart';
import 'package:app_artistica/bloc/product/product_bloc.dart';
import 'package:app_artistica/bloc/selected_product/selected_product_bloc.dart';
import 'package:app_artistica/components/animate.dart';
import 'package:app_artistica/components/gif_loading.dart';
import 'package:app_artistica/components/header_pages.dart';
import 'package:app_artistica/components/image_input.dart';
import 'package:app_artistica/components/input.dart';
import 'package:app_artistica/components/button.dart';
import 'package:app_artistica/components/icon_rounded.dart';
import 'package:app_artistica/components/scann_bar_code.dart';
import 'package:app_artistica/components/selector_options.dart';
import 'package:app_artistica/database/product_model.dart';
import 'package:app_artistica/dialogs/dialog_action.dart';
import 'package:app_artistica/main.dart';
import 'package:app_artistica/services/call_supplementary_data.dart';
import 'package:app_artistica/services/service_method.dart';
import 'package:app_artistica/services/services.dart';
import 'package:app_artistica/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:http_parser/http_parser.dart';

class CreateProductScreen extends StatefulWidget {
  final ProductsModel? product;
  const CreateProductScreen({Key? key, this.product})
      : super(key: key);

  @override
  _CreateProductScreenState createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController textControllerName = TextEditingController();
  TextEditingController textControllerDescription = TextEditingController();
  TextEditingController textControllerPrice = MoneyMaskedTextController(leftSymbol: 'Bs.');
  TextEditingController textControllerQuantity = MoneyMaskedTextController(precision: 0, decimalSeparator: '');
  bool newImage = false;
  bool stateAlert = false;
  String titleAlert = '';
  String? idCategorySelect;
  int stockMin = 1;
  File? _imageFile = File(prefs!.getString('imageProduct')!);
  String codebar = '0';

  @override
  void initState() {
    super.initState();

    if(widget.product != null){
      setState(() {

        textControllerName = TextEditingController(text: widget.product!.nombre);
        textControllerDescription = TextEditingController(text: widget.product!.descripcion);
        textControllerPrice = MoneyMaskedTextController( initialValue: widget.product!.precio!, leftSymbol: 'Bs.');
        textControllerQuantity = MoneyMaskedTextController(
            initialValue: double.parse(widget.product!.cantidad.toString()),
            precision: 0,
            decimalSeparator: '');
        idCategorySelect = widget.product!.categoriaId;
        codebar = widget.product!.codbarras!;
        // _imageFile = File(widget.product!.img!);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final categoryBloc = BlocProvider.of<CategoryBloc>(context).state;
    final node = FocusScope.of(context);
    return Scaffold(
              body: Padding(
                padding:
                    const EdgeInsets.fromLTRB(15,30,15,0),
                child: Column(
                  children: [
                    ComponentHeader(
                        stateBack: true,
                        text: widget.product == null
                            ? 'Nuevo Producto'
                            : '${widget.product!.nombre}'),
                    if(!newImage)
                    ImageInputComponent(
                        child: widget.product!=null?
                          Image.network(
                            widget.product!.img!,
                            width: 180,
                          height: 180,
                          fit: BoxFit.cover,
                          gaplessPlayback: true):
                         Image.file(
                          File(_imageFile!.path),
                          width: 180,
                          height: 180,
                          fit: BoxFit.cover,
                          gaplessPlayback: true,
                        ),
                        onPressed: (File value) => setState(() {
                              _imageFile = value;
                              newImage = true;
                            })),
                    if(newImage)
                    ImageInputComponent(
                        child: Image.file(
                          File(_imageFile!.path),
                          width: 180,
                          height: 180,
                          fit: BoxFit.cover,
                          gaplessPlayback: true,
                        ),
                        onPressed: (File value) => setState(() {
                              _imageFile = value;
                              newImage = true;
                            })),
                    const SizedBox(height: 30),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                InputComponentNoIcon(
                                  textInputAction: TextInputAction.next,
                                  labelText: 'Nombre del producto',
                                  controllerText: textControllerName,
                                  textCapitalization: TextCapitalization.sentences,
                                  keyboardType: TextInputType.text,
                                  onEditingComplete: () => node.nextFocus(),
                                  validator: (value) {
                                    if (value.length < 2) {
                                      return 'Ingrese el nombre del producto';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                InputComponentNoIcon(
                                  textInputAction: TextInputAction.next,
                                  labelText: 'Descripción del producto',
                                  controllerText: textControllerDescription,
                                  textCapitalization: TextCapitalization.sentences,
                                  keyboardType: TextInputType.text,
                                  onEditingComplete: () => node.nextFocus(),
                                  validator: (value) {
                                    if (value.length < 2) {
                                      return 'Ingrese una descripción del producto';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(height: 20),
                                SelectorOptions(
                                  subtitle: 'Selecciona una categoría para tu producto',
                                  title: 'Categoría:',
                                  options: categoryBloc.categories!,
                                  // defect: widget.product == null? null
                                  //     : categoryBloc.categories!.firstWhere((e) => e.id == widget.product!.product!.categoryId!).id,
                                  values: (nameSelect, idSelect, idAlternative) {
                                    setState(() {
                                      idCategorySelect = idSelect;
                                    });
                                  },
                                ),
                                InputComponentNoIcon(
                                  textInputAction: TextInputAction.next,
                                  labelText: 'Precio del producto',
                                  inputFormatters: [
                                    // ignore: deprecated_member_use
                                    // WhitelistingTextInputFormatter.digitsOnly,
                                  ],
                                  controllerText: textControllerPrice,
                                  keyboardType: TextInputType.number,
                                  onEditingComplete: () =>node.nextFocus(),
                                  validator: (value) {
                                    if (isNumericSupZero(value)) {
                                      return null;
                                    } else {
                                      return 'Ingrese el precio del producto';
                                    }
                                  },
                                ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          child: InputComponentNoIcon(
                                            textInputAction:
                                                TextInputAction.next,
                                            inputFormatters: [
                                              // ignore: deprecated_member_use
                                              // WhitelistingTextInputFormatter.digitsOnly,
                                            ],
                                            labelText: 'Cantidad',
                                            controllerText: textControllerQuantity,
                                            keyboardType: TextInputType.number,
                                            onEditingComplete: () => node.nextFocus(),
                                            validator: (value) {
                                              if (isNumericInt(value)) {
                                                return null;
                                              } else {
                                                return 'Ingrese la cantidad del producto';
                                              }
                                            },
                                          )),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          const Text('Cantidad mínima'),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconRoundedComponent(
                                                  onTap: () => {
                                                        if (stockMin > 1)
                                                          setState(
                                                              () => stockMin--)
                                                      },
                                                  icon: Icons.remove),
                                              const SizedBox(width: 10),
                                              Text('$stockMin'),
                                              const SizedBox(width: 10),
                                              IconRoundedComponent(
                                                  onTap: () => setState(
                                                      () => stockMin++),
                                                  icon: Icons.add),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Column(
                                        children: [
                                          ScannBarCodeComponent(
                                              barcode: (String value) =>
                                                  setState(
                                                      () => codebar = value),
                                              icon: Icons.line_weight),
                                          const SizedBox(
                                            height: 5.0,
                                          ),
                                          const Text('Código de barras'),
                                        ],
                                      ),
                                      if (codebar != '0') Text(codebar),
                                    ],
                                  ),
                                ButtonComponent(
                                    text: 'GUARDAR',
                                    onPressed: () => widget.product == null
                                        ? validar(context)
                                        : editProduct(context)),
                              ],
                            )),
                      ),
                    )
                  ],
                )));
  }

  validar(BuildContext context) async {
    final productBloc = BlocProvider.of<ProductBloc>(context, listen: false).state;
    formKey.currentState!.validate();
    if (idCategorySelect == null) {
      return callDialogAction(context, 'Debes de seleccionar una CategorÍa');
    }
    if (productBloc.existProduct) {
      if (productBloc.products!.where((e) => e.nombre == textControllerName.text).isNotEmpty) {
        return callDialogAction(context, 'Existe un producto con el nombre ${textControllerName.text}');
      }
    }
    if (textControllerName.text.isEmpty) {
      return callDialogAction(
          context, 'Tu producto debe tener un nombre');
    }
    if (textControllerPrice.text.isEmpty) {
      return callDialogAction(
          context, 'Tu producto debe tener un precio');
    }
    if (textControllerQuantity.text.isEmpty) {
      return callDialogAction(context,
          'Tu un producto debe tener una cantidad');
    }
    if (stockMin > int.parse( textControllerQuantity.text.replaceAll(RegExp('[.]'), ''))) {
      return callDialogAction(context, 'La cantidad mínima supera la cantidad');
    }
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return ComponentAnimate(
              child: DialogTwoAction(
                  message:
                      'Está seguro de crear el producto',
                  messageCorrect: 'Crear',
                  actionCorrect: () => saveProduct( context )));
        });
  }

  saveProduct( BuildContext context ) async {
      FormData formData = FormData.fromMap({
          'nombre':textControllerName.text.trim(),
          'cantidad': int.parse(textControllerQuantity.text.replaceAll(RegExp('[.]'), '')),
          'precio': double.parse(textControllerPrice.text.substring(3).replaceAll(RegExp('[.]'), '').replaceAll(RegExp('[,]'), '.')),
          'vendidos':0,
          'categoria': idCategorySelect,
          'descripcion': textControllerDescription.text.trim(),
          'codbarras':codebar,
          'archivo': 
          await MultipartFile.fromFile(
            _imageFile!.path,
            filename: 'newproduct-${textControllerName.text.trim()}',
            contentType: MediaType("image", "jpeg"),
          ),
      });

    showLoading(context,'AGUARDE PORFAVOR');
    
    var response = await serviceMethod(context, 'postFile', null, serviceProduct(null),true,formData);
    if (response != null) {
      final productBloc = BlocProvider.of<ProductBloc>(context,listen: false);
      // INGRESAR DATOS A LA TABLA products_ff
      final productsModel = ProductsModel(
        precio: double.parse(response.data['precio'].toString()),
        cantidad: response.data['cantidad'],
        codbarras: response.data['codbarras'],
        vendidos:0,
        id: response.data['_id'],
        nombre: response.data['nombre'],
        categoriaId: response.data['categoria']['_id'],
        descripcion: response.data['descripcion'],
        img: response.data['img'],
        updatedAt: response.data['updatedAt']);
      productBloc.add(UpdateProducts(productsModel));
      Navigator.pop(context);
      await showSuccessful(context, 'SE CREO CORRECTAMENTE EL PRODUCTO', () {
        callInfoSupplementary( context );
        Navigator.pushReplacementNamed(context, 'navigator');
      });
    }
  }

  editProduct(BuildContext context) async {
    final productBloc = BlocProvider.of<ProductBloc>(context,listen: false);
    final selectedProductBloc = BlocProvider.of<SelectedProductBloc>(context,listen: false);
    FormData formData = FormData.fromMap({
        'nombre':textControllerName.text.trim(),
        'cantidad': int.parse(textControllerQuantity.text.replaceAll(RegExp('[.]'), '')),
        'precio': double.parse(textControllerPrice.text.substring(3).replaceAll(RegExp('[.]'), '').replaceAll(RegExp('[,]'), '.')),
        'vendidos':0,
        'categoria': idCategorySelect,
        'descripcion': textControllerDescription.text.trim(),
        'codbarras':codebar,
        'archivo': 
        await MultipartFile.fromFile(
          _imageFile!.path,
          filename: 'newproduct-${textControllerName.text.trim()}',
          contentType: MediaType("image", "jpeg"),
        ),
    });
    showLoading(context,'AGUARDE PORFAVOR');
    
    var response = await serviceMethod(context, 'putFile', null, serviceProduct(widget.product!.id),true,formData);
    if (response != null) {
      setState(() {
        widget.product!.categoriaId = idCategorySelect;
        widget.product!.nombre = textControllerName.text;
        widget.product!.descripcion = textControllerDescription.text;
        widget.product!.precio = double.parse(textControllerPrice.text
            .substring(3)
            .replaceAll(RegExp('[.]'), '')
            .replaceAll(RegExp('[,]'), '.'));
        widget.product!.cantidad = int.parse(textControllerQuantity.text.replaceAll(RegExp('[.]'), ''));
        widget.product!.codbarras = codebar;
      });
      productBloc.add(UpdateProductsById(widget.product!));
      // for (final item in selectedProductBloc.state.selectedProducts!.where((e) => e.productId == widget.product!.id)) {
      //   setState(() {
      //     item.price = widget.product!.precio;
      //   });
      //   selectedProductBloc.add(UpdateSelectedProductById(item));
      //   selectedProductBloc.add(CalculateTotalCount());
      // }
      Navigator.pop(context);
      await showSuccessful(context, 'SE CREO EDITO EL PRODUCTO', () {
        callInfoSupplementary( context );
        Navigator.pushReplacementNamed(context, 'navigator');
      });
    }
  }
}
