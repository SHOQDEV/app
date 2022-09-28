import 'dart:math';

import 'package:app_artistica/components/containers.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class MenuIconRoundedComponent extends StatelessWidget {
  final bool discount;
  final Function(int) onTap;
  final IconData icon;
  final double angle;
  final Color? colorIcon;
  const MenuIconRoundedComponent(
      {Key? key,
      required this.discount,
      required this.onTap,
      required this.icon,
      this.angle = 90 * pi / 1,
      this.colorIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List items = [
      {'id': 1, 'name': discount ? 'Eliminar descuento' : 'Agregar descuento'},
      {'id': 2, 'name': 'Eliminar producto'}
    ];
    return Padding(
      padding: const EdgeInsets.all(5),
      child:PopupMenuButton(
      offset: const Offset(-35, 0),
      color: ThemeProvider.themeOf(context).data.scaffoldBackgroundColor,
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Transform.rotate(
            angle: angle,
            child: Icon(
              icon,
              color: colorIcon ?? ThemeProvider.themeOf(context).data.hintColor,
            ),
          ),
        ),
      ),
      itemBuilder: (context) {
        return List.generate(2, (index) {
          return PopupMenuItem(
            value: items[index]['id'],
            child: Text( items[index]['name'] ),
          );
        });
      },
      onSelected: (dynamic index) => onTap(index),
    ));
  }
}



class MenuFilterRoundedComponent extends StatefulWidget {
  final Function(int) onTap;
  final bool serieOrImeiState;
  const MenuFilterRoundedComponent(
      {Key? key,
      required this.onTap,
      this.serieOrImeiState = false})
      : super(key: key);

  @override
  _MenuFilterRoundedComponentState createState() =>
      _MenuFilterRoundedComponentState();
}

class _MenuFilterRoundedComponentState
    extends State<MenuFilterRoundedComponent> {
  List items = [
    {
      'name': 'Filtrar facturas anuladas',
      'icon': Icons.clear,
      'select': true
    },
    {'name': 'Filtrar facturas facturadas', 'icon': Icons.check, 'select': true},
    {
      'name': 'Exportar a Excel',
      'icon': Icons.wallet_giftcard_outlined,
      'select': false
    },
  ];
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
        
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        
        color: ThemeProvider.themeOf(context).data.scaffoldBackgroundColor,
        offset: const Offset(50, 50),
        child: ContainerRoundedComponent(
        child: Icon(
            Icons.density_medium,
            color: ThemeProvider.themeOf(context).data.hintColor,
        )),
        itemBuilder: (context) {
          return List.generate(items.length, (index) {
            return PopupMenuItem(
              height: 3,
              value: index,
              child: Container(
                  padding: const EdgeInsets.all(2),
                  height: 33,
                  child: Material(
                      color: items[index]['select']
                          ? ThemeProvider.themeOf(context).data.primaryColorLight
                          : ThemeProvider.themeOf(context)
                              .data
                              .scaffoldBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          const SizedBox(width: 10.0),
                          Icon(items[index]['icon'],
                              // ignore: deprecated_member_use
                              color: Theme.of(context).accentColor),
                          const SizedBox(width: 10.0),
                          Text(items[index]['name'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  // ignore: deprecated_member_use
                                  color: Theme.of(context).accentColor)),
                          const SizedBox(width: 10.0),
                        ],
                      ))),
            );
          });
        },
        onSelected: (dynamic index) {
          if (index!=2) {
            setState(() {
              items[index]['select'] = !items[index]['select'];
            });
          }
          widget.onTap(index);
        });
  }
}
