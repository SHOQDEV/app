part of 'app_state_bloc.dart';

@immutable
class AppStateState {

  final String? selectedCategoryId;


  const AppStateState({
    this.selectedCategoryId = '0',

  });
  AppStateState copyWith({
    String? selectedCategoryId

  }) => AppStateState(
    selectedCategoryId            :   selectedCategoryId              ??   this.selectedCategoryId
  );

}
