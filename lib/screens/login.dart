import 'dart:async';
import 'package:app_artistica/bloc/category/category_bloc.dart';
import 'package:app_artistica/bloc/user/user_bloc.dart';
import 'package:app_artistica/components/button.dart';
import 'package:app_artistica/components/gif_loading.dart';
import 'package:app_artistica/components/input.dart';
import 'package:app_artistica/database/db_provider.dart';
import 'package:app_artistica/main.dart';
import 'package:app_artistica/services/auth_service.dart';
import 'package:app_artistica/services/call_supplementary_data.dart';
import 'package:app_artistica/services/service_method.dart';
import 'package:app_artistica/services/services.dart';
import 'package:app_artistica/utils/save_image_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final bool stateLoginAuth;
  const LoginScreen({Key? key, this.stateLoginAuth = false}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  final LocalAuthentication _auth = LocalAuthentication();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController userName = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  bool hidePassword = true;
  bool accessAuth = true;
  String? fullPaths;
  int? difference;

  @override
  void initState() {
    super.initState();
    initPlatformState();

    if ( widget.stateLoginAuth ) {
      _startAuth();
    }
  }

  Future<void> initPlatformState() async {
    Map<String, dynamic> deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        await prefs!.setString('idDivice', deviceData['androidId']);
        print('idDivice ${deviceData['androidId']}');
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        await prefs!.setString(
            'idDivice', deviceData['identifierForVendor'].toString());
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
    if (!mounted) return;
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{'androidId': build.androidId};
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{'identifierForVendor': data.identifierForVendor};
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
        body: Stack(children: <Widget>[
      // const Formtop(),
      // const FormButtom(),
      Center(
          child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Form(
                  key: formKey,
                  child: Column(children: [
                    const Text(
                      "ARTISTICA",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    InputComponent(
                      textInputAction: TextInputAction.next,
                      controllerText: userName,
                      onEditingComplete: () => node.nextFocus(),
                      validator: (value) {
                        if (value.isNotEmpty) {
                          return null;
                        } else {
                          return 'Ingrese su correo';
                        }
                      },
                      keyboardType: TextInputType.text,
                      icon: Icons.person,
                      labelText: "Correo",
                    ),
                    InputComponent(
                        textInputAction: TextInputAction.done,
                        controllerText: userPassword,
                        onEditingComplete: () => formComplete(context),
                        validator: (value) {
                          if (value.isNotEmpty) {
                            return null;
                          } else {
                            return 'Ingrese su contraseña';
                          }
                        },
                        keyboardType: TextInputType.text,
                        icon: Icons.lock,
                        labelText: "Contraseña",
                        obscureText: hidePassword,
                        onTap: () =>
                            setState(() => hidePassword = !hidePassword),
                        iconOnTap: hidePassword
                            ? Icons.lock_outline
                            : Icons.lock_open_sharp),
                    const Divider(),
                    ButtonComponent(
                        text: 'Iniciar Sesión',
                        onPressed: () => formComplete(context)),
                  ]))))
    ]));
  }

  formComplete(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      sendForm();
    }
  }
  sendForm() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final userBloc = BlocProvider.of<UserBloc>(context, listen: false);
    final categoryBloc = BlocProvider.of<CategoryBloc>(context,listen: false);
    showLoading(context,'AGUARDE PORFAVOR');
    final Map<String, dynamic> data = {
      "correo":userName.text.trim(),
      "password":userPassword.text.trim()
    };
    var response = await serviceMethod( context, 'post', data, seviceAuth(), false, null );
    if (response != null) {
      // Token hay que guardarlo en un lugar seguro
      await authService.loginCustomer(
        response,
        userName.text.trim(),
        userPassword.text.trim());
        await prefs!.setString('listCategories',"[]");
        await prefs!.setString('listProducts',"[]");
        callInfoSupplementary( context );
      if ( !widget.stateLoginAuth ) {
        DBProvider.db.database;
        userBloc.add(UpdateUserAcount(userName.text.trim()));

        var imageProduct = await saveImage('assets/images/newproduct.png', 'imageProduct.png');
        await prefs!.setString('imageProduct', imageProduct);
          
        ;
        return Navigator.pushReplacementNamed(context, 'slider');
        
      }else{

        return Navigator.pushReplacementNamed(context, 'navigator');
      }
    }
  }

  Future<void> _startAuth() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    String user = await authService.readCredentialUser();
    String password = await authService.readCredentialPassword();
    setState(()  {
      // userNit.text = nit;
      userName.text = user;
      userPassword.text = password;
    });
    if (prefs!.containsKey('autentificaction')) {
      if (prefs!.getBool('autentificaction')!) {
        bool _isAuthenticated = false;
        AndroidAuthMessages _androidMsg = const AndroidAuthMessages(
            signInTitle: 'app_artistica',
            biometricHint: 'Verificar Identidad',
            cancelButton: 'atras');
        try {
          _isAuthenticated = await _auth.authenticate(
              localizedReason: 'Por favor pon tu huella',
              useErrorDialogs: false,
              stickyAuth: false,
              androidAuthStrings: _androidMsg);
        } on PlatformException catch (e) {
          // EasyLoading.showInfo(e.message);
        }
        if (_isAuthenticated) {

          sendForm();
        }
      }
    }

  }
}