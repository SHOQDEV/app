import 'dart:io';

import 'package:app_artistica/bloc/client/client_bloc.dart';
import 'package:app_artistica/bloc/invoice/invoice_bloc.dart';
import 'package:app_artistica/bloc/user/user_bloc.dart';
import 'package:app_artistica/components/header_pages.dart';
import 'package:app_artistica/components/headers.dart';
import 'package:app_artistica/components/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context, listen: true).state;
    final clientBloc = BlocProvider.of<ClientBloc>(context, listen: true).state;
    final invoiceBloc = BlocProvider.of<InvoiceBloc>(context, listen: true).state;
    final show = BlocProvider.of<InvoiceBloc>(context, listen: true);
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(children: <Widget>[
            const ComponentHeader(stateBack: false, text: 'Perfil'),
            Expanded(
                child: SingleChildScrollView(
                    child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    // Material(
                    //   elevation: 5.0,
                    //   borderRadius: BorderRadius.circular(50.0),
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(50.0),
                    //     child: Image.file(File(userBloc.imageUser!),
                    //         width: 60, height: 60, fit: BoxFit.cover),
                    //   ),
                    // ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          userBloc.companyName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
                SectiontitleComponent(
                    title: 'Mis Transacciones',
                    subTitle: !invoiceBloc.existInvoice
                        ? 'Sin transacciones'
                        : '${invoiceBloc.invoices!.length} transacciones',
                    icon: Icons.calendar_today,
                     onTap: () {
                      //  show.add(ShowInvoices());
                       if(invoiceBloc.existInvoice){
                         Navigator.pushNamed(context, 'invoice');
                       }}),
                SectiontitleComponent(
                    title: 'Mis Clientes',
                    subTitle: !clientBloc.existClient
                        ? 'Sin clientes'
                        : '${clientBloc.clients!.length} clientes',
                    icon: Icons.people_alt_outlined,
                    onTap: () => Navigator.pushNamed(context, 'client')),
                SectiontitleComponent(
                    title: 'Configuración',
                    subTitle: 'Configuración de app_artistica',
                    icon: Icons.settings,
                    onTap: () => Navigator.pushNamed(context, 'settigs')),
              ],
            )))
          ])));
  }
}
