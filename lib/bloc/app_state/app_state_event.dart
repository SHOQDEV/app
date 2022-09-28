part of 'app_state_bloc.dart';

@immutable
abstract class AppStateEvent {}


class UpdateCategorieId extends AppStateEvent{

  final String selectedCategoryId;

  UpdateCategorieId(this.selectedCategoryId);
}