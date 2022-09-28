import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'app_state_event.dart';
part 'app_state_state.dart';

class AppStateBloc extends Bloc<AppStateEvent, AppStateState> {
  AppStateBloc() : super(const AppStateState()) {
    on<UpdateCategorieId>((event, emit) => emit( state.copyWith( selectedCategoryId:event.selectedCategoryId) ));
  }
}
