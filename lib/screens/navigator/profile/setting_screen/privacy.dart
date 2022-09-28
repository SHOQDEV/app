import 'package:app_artistica/components/header_pages.dart';
import 'package:app_artistica/components/headers.dart';
import 'package:app_artistica/components/terms_conditions.dart';
import 'package:flutter/material.dart';

class Privacy extends StatefulWidget {
  const Privacy({
    Key? key,
  }) : super(key: key);
  @override
  _PrivacyState createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Column(children: <Widget>[
              const ComponentHeader(
                  stateBack: true, text: 'Política de privacidad'),
              Expanded(
                  child: SingleChildScrollView(
                      child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: const WidgetTermConditions(),
              )))
            ])),
    );
  }
}
