import 'package:bloc/bloc.dart';
import 'package:app_artistica/database/invoice_model.dart';
import 'package:meta/meta.dart';

part 'invoice_event.dart';
part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  InvoiceBloc() : super(const InvoiceState()) {
    on<UpdateInvoices>  ( ( event,emit )  => _onUpdateInvoices(event));

    on<ShowInvoices>  ( ( event,emit )  => _onShowInvoices(event));

    on<UpdateInvoicesById>  ( ( event,emit )  => _onUpdateInvoicesById( event ));

    on<UpdateAllInvoices>((event, emit) {
      if(event.invoices.isEmpty){
        emit( state.copyWith( existInvoice: false ) );
      }else{
        emit( state.copyWith( existInvoice: true,invoices:event.invoices ) );
      }
    });

    on<UpdateInvoicesFacturado>((event, emit) => emit( state.copyWith( stateFacturado: event.stateFacturado ) ));

    on<UpdateInvoicesAnulado>((event, emit) => emit( state.copyWith( stateAnulado: event.stateAnulado ) ));

    on<UpdateStateDate>((event, emit) => emit( state.copyWith( stateDate: event.stateDate ) ));

    on<UpdateDate>((event, emit) => emit( state.copyWith( listDates: event.listDate ) ));

  }
  _onUpdateInvoices( UpdateInvoices event )async {
    List<InvoicesModel> invoices = state.existInvoice?[ ...state.invoices !, event.invoice ]:[ event.invoice ];
    emit(state.copyWith(existInvoice: true, invoices : invoices));
  }

  _onUpdateInvoicesById( UpdateInvoicesById event )async {
    if( !state.existInvoice) return;
    List<InvoicesModel> invoices = state.invoices!;
    invoices[invoices.indexWhere((e) => e.id == event.invoice.id)] = event.invoice;
    emit(state.copyWith(invoices: invoices));
  }

  _onShowInvoices( ShowInvoices event )async {
    List<InvoicesModel> showInvoices = [];

    if(!state.existInvoice)return;

    if(!state.stateDate){
      if(state.stateFacturado && state.stateAnulado){
        showInvoices = state.invoices!.reversed.toList();
      }
      if(!state.stateFacturado && state.stateAnulado){
        showInvoices = state.invoices!.where((e) => e.countOverrideOrReverse == 2 || e.countOverrideOrReverse == 4).toList().reversed.toList();
      }
      if(state.stateFacturado && !state.stateAnulado){
        showInvoices = state.invoices!.where((e) => e.countOverrideOrReverse == 1 || e.countOverrideOrReverse == 3).toList().reversed.toList();
      }
    }else{
      if(state.stateFacturado && state.stateAnulado){
        if(state.listDates!.isNotEmpty){
          showInvoices = state.invoices!.where((e) => state.listDates!.contains(DateTime.parse(e.date.toString().substring(0, 10)))).toList().reversed.toList();
        }else{
          showInvoices = state.invoices!.reversed.toList();
        }
      }
      if(!state.stateFacturado && state.stateAnulado){
        if(state.listDates!.isNotEmpty){
          showInvoices = state.invoices!.where((e) => state.listDates!.contains(DateTime.parse(e.date.toString().substring(0, 10))) && e.countOverrideOrReverse == 2 || e.countOverrideOrReverse == 4).toList().reversed.toList();
        }else{
          showInvoices = state.invoices!.where((e) => e.countOverrideOrReverse == 2 || e.countOverrideOrReverse == 4).toList().reversed.toList();
        }
      }
      if(state.stateFacturado && !state.stateAnulado){
        if(state.listDates!.isNotEmpty){
          showInvoices = state.invoices!.where((e) => state.listDates!.contains(DateTime.parse(e.date.toString().substring(0, 10))) && e.countOverrideOrReverse == 1 || e.countOverrideOrReverse == 3).toList().reversed.toList();
        }else{
          showInvoices = state.invoices!.where((e) => e.countOverrideOrReverse == 1 || e.countOverrideOrReverse == 3).toList().reversed.toList();
        }
      }

    }
    emit(state.copyWith(existInvoice: true, showInvoices : showInvoices));
  }
}
