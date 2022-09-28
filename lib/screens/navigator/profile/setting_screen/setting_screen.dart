import 'dart:async';
import 'package:app_artistica/bloc/user/user_bloc.dart';
import 'package:app_artistica/components/animate.dart';
import 'package:app_artistica/components/header_pages.dart';
import 'package:app_artistica/components/section_title.dart';
import 'package:app_artistica/dialogs/dialog_action.dart';
import 'package:app_artistica/dialogs/dialog_update_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_artistica/main.dart';
import 'package:app_artistica/screens/navigator/profile/setting_screen/privacy.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  bool colorValue = false;
  bool autentificaction = false;
  String? fullPaths;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (ThemeProvider.themeOf(context).id.contains('dark')) {
        setState(() => colorValue = true);
      }
    });
  }

  bool status = true;
  bool sendNotifications = true;
  bool darkTheme = false;
  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context, listen: true).state;
    return Scaffold(
            body: Padding(
                padding:
                    const EdgeInsets.fromLTRB(15,30,15,0),
                child: Column(children: <Widget>[
                  const ComponentHeader(stateBack: true, text: 'Configuración'),
                  const SizedBox(height: 30),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Configuración de preferencias',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SectiontitleSwitchComponent(
                        title: 'Autenticación',
                        valueSwitch: autentificaction,
                        onChangedSwitch: (v) => guardar(v),
                      ),
                      SectiontitleSwitchComponent(
                        title: 'Tema Oscuro',
                        valueSwitch: colorValue,
                        onChangedSwitch: (v) => guardarColor(v),
                      ),
                      const Text(
                        'Configuración general',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SectiontitleComponent(
                          title: 'Políticas de Privacidad',
                          icon: Icons.info_outline,
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Privacy()),
                            );
                          }),
                      SectiontitleComponent(
                          title: 'Preguntas Frecuentes',
                          icon: Icons.help_outline_outlined,
                          onTap: () => launch(
                              'https://eerpbo.com/preguntas-frecuentes/')),
                      SectiontitleComponent(
                          title: 'Actualizar Contraseña de app_artistica',
                          icon: Icons.lock_open,
                          onTap: () => updatePassword()),
                      SectiontitleComponent(
                          title: 'Eliminar los datos de app_artistica',
                          icon: Icons.sensor_door_outlined,
                          onTap: () => closeSession()),
                      Center(
                        child: Column(
                          children: const [
                            Text(
                              'Mobile developer Moisés M. Ochoa P. C.',
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                            Text(
                              'Backend developer Jorge Escobar Lopez',
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                            Text(
                              'Engine E-ENGINE TM',
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                            Text(
                              'All Rights Reserved Enterprise Bolivia EERPBO',
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                            Text(
                              'app_artistica ®️, VERSIÓN 2.0.1 - 2022',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )))
                ])));
  }

  updatePassword() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return const ComponentAnimate(child: DialogUpdatePassword());
        });
  }

  closeSession() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return ComponentAnimate(
              child: DialogTwoAction(
                  message:
                      '¿Estás seguro de eliminar los datos de app_artistica?\n Esta acción eliminará los datos de app_artistica en tu teléfono',
                  actionCorrect: () async {
                    prefs!.getKeys();
                    for (String key in prefs!.getKeys()) {
                      prefs!.remove(key);
                    }
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  messageCorrect: 'Salir'));
        });
  }

  void guardarColor(v) async {
    setState(() => colorValue = v);
    if (colorValue) {
      ThemeProvider.controllerOf(context).setTheme('dark');
    }else{
      ThemeProvider.controllerOf(context).setTheme('light');
    }
  }

  void guardar(v) async {
    setState(() => autentificaction = v);
    await prefs!.setBool('autentificaction', v);
  }
}
