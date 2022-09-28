import 'package:app_artistica/bloc/category/category_bloc.dart';
import 'package:app_artistica/components/animate.dart';
import 'package:app_artistica/dialogs/dialog_one_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectorOptions extends StatefulWidget {
  final String title;
  final String subtitle;
  final List options;
  final int? defect;
  final Function(String, String, int?) values;
  const SelectorOptions(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.options,
      this.defect,
      required this.values})
      : super(key: key);

  @override
  _SelectorOptionsState createState() => _SelectorOptionsState();
}

typedef ColorCallback = void Function(Color color);

class _SelectorOptionsState extends State<SelectorOptions> {
  TextEditingController textControllernombreCategory = TextEditingController();
  String? selectCategory;
  String? categorySelectforProduct;
  @override
  void initState() {
    super.initState();

    setState(() {
      selectCategory = widget.subtitle;
      if(widget.defect != null){
        selectCategory = widget.options.firstWhere((e) => e.id == widget.defect).nombre;
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    var listalista = [];
    for (var item in widget.options) {
      if (item.id != 0) {
        listalista.add(item.nombre);
      }
    }
    listalista.sort((a, b) {
      return a.compareTo(b);
    });
    List moment = listalista;
    listalista = [];
    if (widget.title == 'Categoría:') {
      listalista.add('CREAR CATEGORÍA');
    }
    for (var item in moment) {
      listalista.add(item);
    }
    return Column(
      children: [
        Container(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              widget.title,
              style: const TextStyle(
                // color:Colors.red,
                fontWeight: FontWeight.w600,
              ),
            )),
             DropdownButton(
          itemHeight : widget.title != 'Homologación:'?kMinInteractiveDimension:80,
          isExpanded: true,
          hint: Text(selectCategory!),
          focusColor: const Color(0xffD89E49),
           iconSize: 24,
           elevation: 16,
          items: listalista.map(
            (val) {
              return DropdownMenuItem<String>(
                  value: val,
                  child: Text(val));
            },
          ).toList(),
          onChanged: (val) {
            if (val == 'CREAR CATEGORÍA') {
              createCategory();
            } else {
              setState(() => selectCategory = val.toString());
            }
            if ('Homologación:' == widget.title) {
              for (var i = 0; i < widget.options.length; i++) {
                if (widget.options[i].nombre == val) {
                  widget.values(
                      val.toString(), widget.options[i].id, widget.options[i].activitieEconomic);
                  break;
                }
              }
            } else {
              //CategorÍaS Y UNIDAD DE MEDIDA
              for (var i = 0; i < widget.options.length; i++) {
                if (widget.options[i].nombre == val) {
                  widget.values(val.toString(), widget.options[i].id, null);
                  break;
                }
              }
            }
          },
        ),
      ],
    );
  }
  createCategory(){
    final categoryBloc = BlocProvider.of<CategoryBloc>(context, listen: false);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return ComponentAnimate(
              child: DialogOneInputAction(
                  controllerText: textControllernombreCategory,
                  message: 'Añadir categoría',
                  title: 'Categoría',
                  textCapitalization: TextCapitalization.characters,
                  validator: (value) {
                    if (value.isNotEmpty) {
                      if(categoryBloc.state.categories!.where((e) => (e.nombre == textControllernombreCategory.text.trim().toUpperCase())).isEmpty && value.trim().toUpperCase()!='TODOS'){
                        return null;
                      }else{
                        return 'Existe una categoría con un nombre similar';
                      }
                    } else {
                        return 'Ingrese nombre de la categoría';
                    }
                  },
                  messageCorrect: 'Crear',
                  actionCorrect: (nombreCategory) async {
                    // final categoriesModel = CategoriesModel(
                    //   nombre: nombreCategory.text.trim().toUpperCase());
                    // await DBProvider.db.newCategoriesModel(categoriesModel)
                    // .then((value) => DBProvider.db.getCategoriesModelById(value)
                    // .then((value2) => categoryBloc.add(UpdateCategories(value2))));
                    // Navigator.of(context).pop();
                  }));
        });
  }
}
