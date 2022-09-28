part of 'invoice_bloc.dart';

@immutable
class InvoiceState {

  final bool existInvoice;
  final List<InvoicesModel>? invoices;

  final List<InvoicesModel>? showInvoices;
  final bool stateDate;
  final bool stateFacturado;
  final bool stateAnulado;
  final List<DateTime>? listDates;

  const InvoiceState({
    this.existInvoice = false,
    this.invoices,
    this.showInvoices,
    this.stateDate = false,
    this.stateFacturado = true,
    this.stateAnulado = true,
    this.listDates

  });
  InvoiceState copyWith({
    bool?                   existInvoice,
    List<InvoicesModel>?  invoices,
    List<InvoicesModel>?  showInvoices,
    bool?                   stateDate,
    bool?                   stateFacturado,
    bool?                   stateAnulado,
    List<DateTime>?                   listDates,

  }) => InvoiceState(
    existInvoice         :   existInvoice        ??  this.existInvoice,
    invoices            :   invoices           ??  this.invoices,
    showInvoices            :   showInvoices           ??  this.showInvoices,
    stateDate            :   stateDate           ??  this.stateDate,
    stateFacturado            :   stateFacturado           ??  this.stateFacturado,
    stateAnulado            :   stateAnulado           ??  this.stateAnulado,
    listDates            :   listDates           ??  this.listDates,
  );}
