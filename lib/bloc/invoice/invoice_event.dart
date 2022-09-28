part of 'invoice_bloc.dart';

@immutable
abstract class InvoiceEvent {}



class UpdateInvoices extends InvoiceEvent {
  final InvoicesModel invoice;

  UpdateInvoices(this.invoice);
}


class UpdateAllInvoices extends InvoiceEvent {
  final List<InvoicesModel> invoices;

  UpdateAllInvoices(this.invoices);
}


class ShowInvoices extends InvoiceEvent {

  ShowInvoices();
}

class UpdateInvoicesFacturado extends InvoiceEvent {
  final bool stateFacturado;
  UpdateInvoicesFacturado(this.stateFacturado);
}

class UpdateInvoicesAnulado extends InvoiceEvent {
  final bool stateAnulado;
  UpdateInvoicesAnulado(this.stateAnulado);
}

class UpdateDate extends InvoiceEvent {
  final List<DateTime> listDate;
  UpdateDate(this.listDate);
}
class UpdateStateDate extends InvoiceEvent {
  final bool stateDate;
  UpdateStateDate(this.stateDate);
}

class UpdateInvoicesById extends InvoiceEvent {
  final InvoicesModel invoice;

  UpdateInvoicesById(this.invoice);
}