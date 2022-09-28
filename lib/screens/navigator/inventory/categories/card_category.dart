import 'package:app_artistica/components/containers.dart';
import 'package:app_artistica/components/icon_rounded.dart';
import 'package:app_artistica/database/category_model.dart';
import 'package:flutter/material.dart';

class CardCategory extends StatelessWidget {
  final Function() delete;
  final Function() edit;
  final CategoriesModel category;
  const CardCategory(
      {Key? key,
      required this.delete,
      required this.edit,
      required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContainerComponent(
        child: Row(
      children: <Widget>[
        SizedBox(height: MediaQuery.of(context).size.height * 0.08),
        SizedBox(width: MediaQuery.of(context).size.width * 0.01),
        IconRoundedComponent(
            icon: Icons.delete_outline_outlined,
            onTap: delete,
            colorIcon: Colors.red),
        SizedBox(width: MediaQuery.of(context).size.width * 0.01),
        IconRoundedComponent(
            icon: Icons.edit_outlined,
            onTap: edit,
            colorIcon: Colors.blueAccent),
        SizedBox(width: MediaQuery.of(context).size.width * 0.01),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(category.nombre!),
          ),
        ),
      ],
    ));
  }
}
