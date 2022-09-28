part of 'category_bloc.dart';

@immutable
class CategoryState {

  final bool existCategory;
  final List<CategoriesModel>? categories;
  final List<CategoriesModel>? selectedCategories;

  const CategoryState({
    this.existCategory = false,
    this.categories,
    this.selectedCategories

  });
  CategoryState copyWith({
    bool?                   existCategory,
    List<CategoriesModel>?  categories,
    List<CategoriesModel>?  selectedCategories
  }) => CategoryState(
    existCategory         :   existCategory       ??  this.existCategory,
    categories            :   categories          ??  this.categories,
    selectedCategories    :   selectedCategories  ??  this.selectedCategories,

  );
}
