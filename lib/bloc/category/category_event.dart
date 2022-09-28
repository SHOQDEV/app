part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}


class UpdateCategories extends CategoryEvent {
  final CategoriesModel category;

  UpdateCategories(this.category);
}




class UpdateAllCategories extends CategoryEvent {
  final List<CategoriesModel> categories;

  UpdateAllCategories(this.categories);
}

class UpdateCategoriesById extends CategoryEvent {
  final CategoriesModel category;

  UpdateCategoriesById(this.category);
}

class RemoveCategory extends CategoryEvent {
  final CategoriesModel category;

  RemoveCategory(this.category);
}

class DeleteAllCategories extends CategoryEvent {

  DeleteAllCategories();
}