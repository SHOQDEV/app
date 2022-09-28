import 'package:bloc/bloc.dart';
import 'package:app_artistica/database/category_model.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {

  CategoryBloc() : super(const CategoryState()) {

    on<UpdateCategories>  ( ( event,emit )  => _onUpdateCategories( event ));

    on<UpdateCategoriesById>  ( ( event,emit )  => _onUpdateCategoriesById( event ));

    on<RemoveCategory>  ( ( event,emit )  => _onRemoveCategory( event ));

    on<DeleteAllCategories>  ( ( event,emit )  => emit( state.copyWith( existCategory: false, categories:[] ) ));

    on<UpdateAllCategories>((event, emit) {
      if( event.categories.isEmpty ){
        emit( state.copyWith( existCategory: false ) );
      }else{
        emit( state.copyWith( existCategory: true, categories:event.categories ) );
      }
    });
  }
  
  _onUpdateCategories( UpdateCategories event )async {
    List<CategoriesModel> categories = state.existCategory?[ ...state.categories!, event.category ]:[ event.category ];
    emit(state.copyWith(existCategory: true, categories : categories));
  }

  _onUpdateCategoriesById( UpdateCategoriesById event) async {
    if( !state.existCategory) return;
    List<CategoriesModel> categories = state.categories!;
    categories[categories.indexWhere((e) => e.id == event.category.id)] = event.category;
    emit(state.copyWith(categories: categories));
  }

  _onRemoveCategory( RemoveCategory event) async {
    final categories = state.categories!.where((e) => e.id != event.category.id).toList();
    emit(state.copyWith(categories: categories));
  }
}