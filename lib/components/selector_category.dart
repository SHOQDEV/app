import 'package:app_artistica/bloc/app_state/app_state_bloc.dart';
import 'package:app_artistica/bloc/category/category_bloc.dart';
import 'package:app_artistica/database/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_provider/theme_provider.dart';

class SelectorCategory extends StatelessWidget {
  const SelectorCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appStateBloc = BlocProvider.of<AppStateBloc>(context,listen: true);
    final categoryBloc = BlocProvider.of<CategoryBloc>(context,listen: true).state;
    List<CategoriesModel> listCategories =[];
    listCategories = categoryBloc.categories!;
    return DropdownButton(
      hint: Text(
        categoryBloc.categories!.firstWhere((element) => element.id == appStateBloc.state.selectedCategoryId).nombre!,
        style: TextStyle(color: ThemeProvider.themeOf(context).data.accentColor),
      ),
      isExpanded: true,
      items: listCategories.map(
        (CategoriesModel val) {
          return DropdownMenuItem<String>(
              value: val.id.toString(),
              child: Text(val.nombre!));
        },
      ).toList(),
      onChanged: (val) {
        appStateBloc.add(UpdateCategorieId('$val'));
      },
    );
  }
}
