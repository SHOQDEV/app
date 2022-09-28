import 'dart:convert';

import 'package:app_artistica/bloc/client/client_bloc.dart';
import 'package:app_artistica/bloc/invoice/invoice_bloc.dart';
import 'package:app_artistica/bloc/product/product_bloc.dart';
import 'package:app_artistica/bloc/product_sold/product_sold_bloc.dart';
import 'package:app_artistica/bloc/selected_product/selected_product_bloc.dart';
import 'package:app_artistica/components/animate.dart';
import 'package:app_artistica/components/gif_loading.dart';
import 'package:app_artistica/components/header_pages.dart';
import 'package:app_artistica/components/headers.dart';
import 'package:app_artistica/components/button.dart';
import 'package:app_artistica/components/input.dart';
import 'package:app_artistica/components/section_title.dart';
import 'package:app_artistica/database/client_model.dart';
import 'package:app_artistica/database/invoice_model.dart';
// import 'package:app_artistica/database/db_provider.dart';
import 'package:app_artistica/dialogs/dialog_action.dart';
import 'package:app_artistica/models/detail_invoice.dart';
import 'package:app_artistica/screens/navigator/cart/billing/credit_card.dart';
import 'package:app_artistica/screens/navigator/cart/billing/new_client_dialog.dart';
import 'package:app_artistica/screens/navigator/cart/billing/number_document.dart';
import 'package:app_artistica/screens/result_screen/success_screen.dart';
import 'package:app_artistica/services/auth_service.dart';
import 'package:app_artistica/services/service_method.dart';
import 'package:app_artistica/services/services.dart';
import 'package:app_artistica/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:app_artistica/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:intl/number_symbols_data.dart' show numberFormatSymbols;
import 'package:search_choices/search_choices.dart';

class DetailCard extends StatefulWidget {
  const DetailCard({Key? key}) : super(key: key);
  @override
  _NewInvoice createState() => _NewInvoice();
}

class _NewInvoice extends State<DetailCard> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController documentController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController typeDocumentInvoice = TextEditingController();
  TextEditingController textControllerDiscount= MoneyMaskedTextController(initialValue: 0.00, leftSymbol: 'Bs.');
  
  TextEditingController numberTargetController = TextEditingController(text: '0');
  bool isContact = false;
  String? selectedConfigAppTextNumero;
  String? selectedConfigAppTextNombre;
  String? selectedConfigAppTextCodigo;
  String? typeDocumentInvoiceText;
  int? paymentMethodInvoice;
  bool btnFacturar = false;
  bool paymentTarjet = false;
  String moneyLocalText = '';
  String moneyLocalTextFIN = '';
  num moneyLocal = 0.0;
  int moneyLocalId = 0;
  int? number;
  bool stateAlert = false;
  String titleAlert = '';
  ClientsModel? clientsModel;
  bool sinNombreState = false;
  bool nameClientStatic = false;
  bool stateTypeDocument = true;
  bool discountState = false;


String? selectedValueSingleMenu;

List<DropdownMenuItem> items = [];

  @override
  void initState() {
    super.initState();
    number = prefs!.getString('paymentCurrencyText')!.length;
    if (prefs!.getString('paymentCurrencyText')!.substring(number! - 2, number! - 1) != 'S') {
      if (prefs!.getString('paymentCurrencyText')!.substring(number! - 1, number) == 'A' ||
          prefs!.getString('paymentCurrencyText')!.substring(number! - 1, number) == 'E' ||
          prefs!.getString('paymentCurrencyText')!.substring(number! - 1, number) == 'I' ||
          prefs!.getString('paymentCurrencyText')!.substring(number! - 1, number) == 'O' ||
          prefs!.getString('paymentCurrencyText')!.substring(number! - 1, number) == 'U') {
        moneyLocalTextFIN = prefs!.getString('paymentCurrencyText')! + 'S';
      } else {
        moneyLocalTextFIN = prefs!.getString('paymentCurrencyText')! + 'ES';
      }
    } else {
      moneyLocalTextFIN = prefs!.getString('paymentCurrencyText')!;
    }
    setState(() {
      moneyLocalText = prefs!.getString('paymentCurrencyText')!;
      moneyLocal = prefs!.getDouble('exchangeRate')!;
      moneyLocalId = prefs!.getInt('paymentCurrencyId')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    final selectedProductBloc = BlocProvider.of<SelectedProductBloc>(context,listen: true).state;
    return Scaffold(
        body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Column(children: <Widget>[
          const ComponentHeader(stateBack: true, text: 'Facturar'),
          Expanded(
              child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  NumberDocument(
                      paymentAmount: selectedProductBloc.totalCount,
                      node: node,
                      documentController: documentController,
                      nameController: nameController,
                      typeDocumentInvoice: typeDocumentInvoice,
                      clientModelGenerate:( val ) =>setState( () => clientsModel = val),
                      ),
                  const SizedBox(height: 20.0),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Text('Monto total:',style: TextStyle(fontWeight: FontWeight.bold)),
                      Spacer(),
                      Text('${ NumberFormat.decimalPattern(getCurrentLocale()).format(selectedProductBloc.totalCount )} Bs.',
                        style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  SectiontitleSwitchWidget(
                        widget: discountState?
                          InputComponentNoIcon(
                          textInputAction: TextInputAction.next,
                          labelText: 'Descuento adicional',
                          inputFormatters: [
                            // ignore: deprecated_member_use
                            // WhitelistingTextInputFormatter.digitsOnly,
                          ],
                          controllerText: textControllerDiscount,
                          onChanged:(s){
                            setState(() {
                              textControllerDiscount = MoneyMaskedTextController(
                                initialValue:double.parse(textControllerDiscount.text
            .trim()
            .substring(3)
            .replaceAll(RegExp('[.]'), '')
            .replaceAll(RegExp('[,]'), '.')),
                                leftSymbol: 'Bs.');
                            });
                          },
                          keyboardType: TextInputType.number,
                          onEditingComplete: () =>node.nextFocus(),
                          validator: (value) {
                            if (isNumericSupZero(value)) {
                              return null;
                            } else {
                              return 'Ingrese un descuento';
                            }
                          },
                        ):
                        const Text('Agregar un descuento adicional'),
                        valueSwitch: discountState,
                        onChangedSwitch: (v) {
                          setState(() {
                            discountState = v;
                            textControllerDiscount = MoneyMaskedTextController(leftSymbol: 'Bs.');
                          });
                        }
                      ),
                  Visibility(
                      visible: paymentTarjet,
                      child: CreditCard(
                          cardExpiration: documentController.text,
                          typeDocumentInvoice: typeDocumentInvoice,
                          cardHolder: nameController.text.trim(),
                          numberTargetController: numberTargetController)),
                  const SizedBox(height: 20.0),
                  
                 if( discountState )
                  Row(
                    children: [
                      const Text('Descuento Agregado:',style: TextStyle(fontWeight: FontWeight.bold)),
                      const Spacer(),
                      Text('${ textControllerDiscount.text } Bs.',
                        style: const TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      const Text('Moneda configurada a pagar:',style: TextStyle(fontWeight: FontWeight.bold)),
                      const Spacer(),
                      Text(moneyLocalText,
                        style: const TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Visibility(
                    visible: moneyLocal.toString() == '1.0' ? false : true,
                    child:  Row(
                    children: [
                      const Text('Tipo de cambio configurado:',style: TextStyle(fontWeight: FontWeight.bold)),
                      const Spacer(),
                      Text('$moneyLocal',
                        style: const TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      const Text('En total monto a pagar es:',style: TextStyle(fontWeight: FontWeight.bold)),
                      const Spacer(),
                      Text('${NumberFormat.decimalPattern(getCurrentLocale()).format(
                        (selectedProductBloc.totalCount / moneyLocal)-double.parse(textControllerDiscount.text
            .trim()
            .substring(3)
            .replaceAll(RegExp('[.]'), '')
            .replaceAll(RegExp('[,]'), '.'))
                        )} $moneyLocalTextFIN',
                        style: const TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                ],
              ),
            ),
          )),
          ButtonComponent(text: 'Facturar', onPressed: () => validarCampos()),
        ]),
      ));
  }
  String getCurrentLocale() {
    const locale = Locale('es', 'ES');
    final joined = "${locale.languageCode}_${locale.countryCode}";
    if (numberFormatSymbols.keys.contains(joined)) {
      return joined;
    }
    return locale.languageCode;
  }

  validarCampos() {
    final selectedProductBloc = BlocProvider.of<SelectedProductBloc>(context,listen: false).state;
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      if (documentController.text == '') {
        return callDialogAction(context, 'Deves ingresar datos del cliente');
      }
      if (nameController.text.trim() == '') {
          return callDialogAction(context, 'Deves ingresar datos del cliente');
      }
      if (typeDocumentInvoice.text.trim() == '') {
        return callDialogAction(context, 'Selecciona el tipo de documento del cliente');
      }
      if (paymentMethodInvoice == null) {
        return callDialogAction(context, 'Selecciona el método de pago');
      }
      if(discountState){
        if(double.parse(textControllerDiscount.text
            .trim()
            .substring(3)
            .replaceAll(RegExp('[.]'), '')
            .replaceAll(RegExp('[,]'), '.')) >= selectedProductBloc.totalCount){
          return callDialogAction(context, 'El descuento no puede ser superior al monto total');
        }
      }
      if (paymentTarjet) {
        if (numberTargetController.text.length != 8) {
          return callDialogAction(context, 'Revise el número de tarjeta');
        } else {
          searchClient();
        }
      } else {
        searchClient();
      }
    }
  }

  searchClient() {
    final clientBloc = BlocProvider.of<ClientBloc>(context, listen: false).state.clients;
    
    if (clientBloc!.where((e) => e.numberDocument.toString() == documentController.text && e.typeDocument.toString() == typeDocumentInvoice.text).isNotEmpty) {
      ClientsModel client = clientBloc.firstWhere((e) => e.numberDocument.toString() == documentController.text && e.typeDocument.toString() == typeDocumentInvoice.text);
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return ComponentAnimate(
                child: DialogTwoAction(
                    message: '¿Los datos de la factura son correctos?',
                    messageCorrect: 'Facturar',
                    actionCorrect: () {
                      Navigator.pop(context);
                      facturar(client);
                    }));
          });
    } else {
      // return showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return ComponentAnimate(
      //           child: DialogNewClient(
      //         nameClient: nameController.text.trim(),
      //         documentClient: documentController.text,
      //         typeDocument: int.parse(typeDocumentInvoice.text),
      //         correct: (ClientsModel client)  {
      //           // Navigator.pop(context);
      //           // return showDialog(
      //           //     context: context,
      //           //     builder: (BuildContext context) {
      //           //       return ComponentAnimate(
      //           //           child: DialogTwoAction(
      //           //               message:
      //           //                   '¿Los datos de la factura son correctos?',
      //           //               messageCorrect: 'Facturar',
      //           //               actionCorrect: () {
      //           //                 Navigator.pop(context);
      //           //                 facturar(client);
      //           //               }));
      //           //     });
      //         },
      //       ));
      //     });
    }
  }

  facturar(ClientsModel client) async {
  //   final authService = Provider.of<AuthService>(context, listen: false);
  //   final selectedProductBloc = BlocProvider.of<SelectedProductBloc>(context,listen: false).state;
  //  showLoading(context,'AGUARDE PORFAVOR');
  //   String productData = ProductDetail.encodeProductDetail(productDetail);
  //   productDetail = [];
  //   List invoicesList = json.decode(productData);
  //   final Map<String, dynamic> data = {
  //     "cliente": {
  //       "nit": int.parse(await authService.readCredentialNit()),
  //       "usuario": await authService.readCredentialUser(),
  //       "password": await authService.readCredentialPassword(),
  //       // "imeimac": prefs!.getString('idDivice'),
  //       "codigo_documentos_sector_id": 35,
  //       "sucursal": 0,
  //       "pos": 0,
  //       "actividadEconomica": '1',
  //       "imeimac": "56:3C:43:56:C7:B8"
  //     },
  //     "factura": {
  //       "cabecera": {
  //         "nombreRazonSocial": nameController.text.trim(),
  //         "correoElectronico": "eerpbo@gmail.com",
  //         "codigoTipoDocumentoIdentidad": int.parse(typeDocumentInvoice.text.trim()),
  //         "numeroDocumento": documentController.text.trim(),
  //         "complemento": "",
  //         "codigoCliente": "${nameController.text.trim()}-${documentController.text.trim()}",
  //         "codigoMetodoPago": paymentMethodInvoice,
  //         "numeroTarjeta": int.parse(numberTargetController.text),
  //         "montoTotal": discountState? (selectedProductBloc.totalCount - double.parse(textControllerDiscount.text
  //           .trim()
  //           .substring(3)
  //           .replaceAll(RegExp('[.]'), '')
  //           .replaceAll(RegExp('[,]'), '.'))):selectedProductBloc.totalCount,
  //         "montoTotalSujetoIva": discountState? (selectedProductBloc.totalCount - double.parse(textControllerDiscount.text
  //           .trim()
  //           .substring(3)
  //           .replaceAll(RegExp('[.]'), '')
  //           .replaceAll(RegExp('[,]'), '.'))):selectedProductBloc.totalCount,
  //         "codigoMoneda": moneyLocalId,
  //         "tipoCambio": moneyLocal,
  //         "montoTotalMoneda": discountState?num.parse((selectedProductBloc.totalCount - double.parse(textControllerDiscount.text
  //           .trim()
  //           .substring(3)
  //           .replaceAll(RegExp('[.]'), '')
  //           .replaceAll(RegExp('[,]'), '.'))/ moneyLocal).toStringAsFixed(2)):
  //           (selectedProductBloc.totalCount/moneyLocal),
  //         "montoGiftCard": 0.00,
  //         "descuentoAdicional": discountState?double.parse(textControllerDiscount.text
  //           .trim()
  //           .substring(3)
  //           .replaceAll(RegExp('[.]'), '')
  //           .replaceAll(RegExp('[,]'), '.')):0.00,
  //         "codigoExcepcion": 1,
  //         "cafc": null,
  //         "usuario": "a.baspineiro",
  //         "codigoDocumentoSector": 35,
  //         "tipoFacturaDocumento": 1,
  //         "fechaCafc": "2021-11-04 00:29:20.100",
  //         "numeroFacturaCafc": null
  //       },
  //       "detalle": invoicesList
  //     }
  //   };
  //   var response = await serviceMethod( context, 'post', data, await service(context, 'serviceSendInvoice') );
  //   if (response != null) {
  //     return getPublicity( client, response );
  //   }
  }
  getPublicity( ClientsModel client, response )async{
    // final authService = Provider.of<AuthService>(context, listen: false);
    // final invoiceBloc = BlocProvider.of<InvoiceBloc>(context, listen: false);
    // await Permission.storage.request();
    // final Map<String, dynamic> data = {
    //   "cliente": {"nit": await authService.readCredentialNit()}
    // };
    // var responsePublicity = await serviceMethod(context, 'post', data, await service(context, 'serviceGetPublicity'));
    // if (responsePublicity != null) {
    //   final res = json.decode(response.data);
    //   //CREAR LA FACTURA
    //   final invoiceModel = InvoicesModel(
    //     clientId:client.id,
    //     codeTypePayment:paymentMethodInvoice.toString(),
    //     numberTarjet: int.parse(numberTargetController.text),
    //     codeCoin: moneyLocalId.toString(),
    //     exchangeRate : double.parse(moneyLocal.toString()),
    //     date: DateTime.parse(res['facturaElectronicaCompraVentaBon']['cabecera']['fechaEmision']),
    //     countOverrideOrReverse: 1,
    //     reasonOverrideCode: 0,
    //     fileInvoice:'',
    //     totalAmount: double.parse(res['facturaElectronicaCompraVentaBon']['cabecera']['montoTotal']),
    //     totalAmountSubjectToIva: double.parse(res['facturaElectronicaCompraVentaBon']['cabecera']['montoTotalSujetoIva']),
    //     totalAmountCurrency: double.parse(res['facturaElectronicaCompraVentaBon']['cabecera']['montoTotalMoneda']),
    //     amountGiftCard: double.parse(res['facturaElectronicaCompraVentaBon']['cabecera']['montoGiftCard']),
    //     additionalDiscount: double.parse(res['facturaElectronicaCompraVentaBon']['cabecera']['descuentoAdicional']),
    //     address: res['facturaElectronicaCompraVentaBon']['cabecera']['direccion'],
    //     telephone: res['facturaElectronicaCompraVentaBon']['cabecera']['telefono'],
    //     municipality: res['facturaElectronicaCompraVentaBon']['cabecera']['municipio'],
    //     invoiceNumber: res['facturaElectronicaCompraVentaBon']['cabecera']['numeroFactura'],
    //     cuf: res['facturaElectronicaCompraVentaBon']['cabecera']['cuf'],
    //     legend: res['facturaElectronicaCompraVentaBon']['cabecera']['leyenda'],
    //     urlQr: res['url_qr'],
    //     publicity:json.decode(responsePublicity.data)['Publicidad'].replaceAll('\\n', '\n'),
    //     companyName:prefs!.getString('companyName'));
    //     await DBProvider.db.newInvoicesModel(invoiceModel)
    //     .then((value) => DBProvider.db.getInvoicesModelById(value)
    //     .then((value2) {
    //       invoiceBloc.add(UpdateInvoices(value2));
    //       return registerSale( value2 , client);
    //     }));
        
    // }
  }
  registerSale(InvoicesModel invoiceModel, ClientsModel client) async {
    // final invoiceBloc = BlocProvider.of<InvoiceBloc>(context, listen: false);
    // final selectedProductBloc = BlocProvider.of<SelectedProductBloc>(context, listen: false);
    // final productSoldBloc = BlocProvider.of<ProductSoldBloc>(context, listen: false);
    // final productBloc = BlocProvider.of<ProductBloc>(context, listen: false);
    // //CREAR REGISTRO DE VENTA
    // for (var i = 0; i < selectedProductBloc.state.selectedProducts!.length; i++) {
    //   ProductsModel product = productBloc.state.products!.firstWhere((e) => e.id==selectedProductBloc.state.selectedProducts![i].productId);
    //   final saleProductsModel = SoldProductsModel(
    //     productId:    selectedProductBloc.state.selectedProducts![i].productId,
    //     invoiceId:    invoiceModel.id,
    //     discount:     selectedProductBloc.state.selectedProducts![i].discount,
    //     typeDiscount: selectedProductBloc.state.selectedProducts![i].typeDiscount,
    //     quantity:     selectedProductBloc.state.selectedProducts![i].quantity,
    //     price:        selectedProductBloc.state.selectedProducts![i].price);
    //   await DBProvider.db.newSoldProductsModel(saleProductsModel)
    //   .then((value) => DBProvider.db.getSoldProductsModelById(value)
    //   .then((value2) => productSoldBloc.add(UpdateSoldProducts(value2))));
    //   //ACTUALIZAR PRODUCTO
    //   final productsModel = ProductsModel(
    //       id: product.id,
    //       categoryId: product.categoryId,
    //       image: product.image,
    //       title: product.title,
    //       price: product.price,
    //       quantity: product.quantity,
    //       stockMin: product.stockMin,
    //       barCode: product.barCode,
    //       typeProduct: product.typeProduct,
    //       codeUnitMeasurement: product.codeUnitMeasurement,
    //       souldOut: product.souldOut! + selectedProductBloc.state.selectedProducts![i].quantity!,
    //       codeSin: product.codeSin,
    //       codeActivityEconomic: product.codeActivityEconomic,
    //       hashCodeHomologation: product.hashCodeHomologation);
    //   await DBProvider.db.updateProduct(productsModel);
    //   productBloc.add(UpdateProductsById(productsModel));
    // }
    // await DBProvider.db.deleteALLSelectProduct();
    // selectedProductBloc.add( ClearSelectedProducts ());
    // selectedProductBloc.add( ClearTotalAcount() );
    // invoiceBloc.add(ShowInvoices());
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => SuccessScreen(
    //           invoice: invoiceModel,
    //           client: client)),
    // );
  }
}

