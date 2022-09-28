import 'package:app_artistica/components/gif_loading.dart';
import 'package:app_artistica/components/input.dart';
import 'package:app_artistica/components/button.dart';
import 'package:app_artistica/dialogs/dialog_action.dart';
import 'package:app_artistica/services/auth_service.dart';
import 'package:app_artistica/services/service_method.dart';
import 'package:app_artistica/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogUpdatePassword extends StatefulWidget {
  const DialogUpdatePassword({Key? key}) : super(key: key);
  @override
  _DialogUpdatePasswordState createState() => _DialogUpdatePasswordState();
}

class _DialogUpdatePasswordState extends State<DialogUpdatePassword> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController passwordOldcontroller = TextEditingController();
  TextEditingController passwordNewcontroller = TextEditingController();
  TextEditingController passwordConfirmcontroller = TextEditingController();
  bool hidePasswordOld = true;
  bool hidePasswordConfirm = true;
  bool hidePasswordNew = true;
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: SingleChildScrollView(
            child: Stack(
          // overflow: Overflow.visible,
          alignment: Alignment.topCenter,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              height: MediaQuery.of(context).size.width <
                      MediaQuery.of(context).size.height
                  ? MediaQuery.of(context).size.width * 0.8
                      : MediaQuery.of(context).size.width * 0.4,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Actualizar Contrasssseña'),
                    const Spacer(),
                    InputComponent(
                      textInputAction: TextInputAction.next,
                      controllerText: passwordOldcontroller,
                      onEditingComplete: () => node.nextFocus(),
                      validator: (value) {
                        if (value.isNotEmpty) {
                          return null;
                        } else {
                          return 'Ingrese su contraseña';
                        }
                      },
                      keyboardType: TextInputType.text,
                      labelText: "Antigua Contraseña",
                      obscureText: hidePasswordOld,
                      onTap: () => setState(() => hidePasswordOld = !hidePasswordOld),
                      iconOnTap: hidePasswordOld
                          ? Icons.lock_outline
                          : Icons.lock_open_sharp,
                      icon: Icons.lock,
                    ),
                    InputComponent(
                      textInputAction: TextInputAction.next,
                      controllerText: passwordNewcontroller,
                      onEditingComplete: () => node.nextFocus(),
                      validator: (value) {
                        if (value.isNotEmpty) {
                          if (value.length > 5) {
                            return null;
                          } else {
                            return 'Debe tener un mínimo de 6 caracteres.';
                          }
                        } else {
                          return 'Ingrese una contraseña';
                        }
                      },
                      keyboardType: TextInputType.text,
                      labelText: "Nueva Contraseña",
                      obscureText: hidePasswordNew,
                      onTap: () => setState(() => hidePasswordNew = !hidePasswordNew),
                      iconOnTap: hidePasswordNew
                          ? Icons.lock_outline
                          : Icons.lock_open_sharp,
                      icon: Icons.lock,
                    ),
                    const Spacer(),
                    InputComponent(
                      textInputAction: TextInputAction.done,
                      controllerText: passwordConfirmcontroller,
                      onEditingComplete: () => changePwd(),
                      validator: (value) {
                        if (value != passwordNewcontroller.text) {
                          return 'las contraseñas no coinciden';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.text,
                      labelText: "Confirmar contraseña",
                      obscureText: hidePasswordConfirm,
                      onTap: () => setState(
                          () => hidePasswordConfirm = !hidePasswordConfirm),
                      iconOnTap: hidePasswordConfirm
                          ? Icons.lock_outline
                          : Icons.lock_open_sharp,
                      icon: Icons.lock,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment : MainAxisAlignment.spaceEvenly,
                      children: [
                      ButtonWhiteComponent(
                        text: 'CANCELAR',
                        onPressed: () =>Navigator.pop(context),
                      ),
                      ButtonComponent(
                        text: 'CAMBIAR',
                        onPressed: () => changePwd()),
                    ],),
                    const Spacer()
                  ],
                ),
              ),
            ),
          ],
        )));
  }

  changePwd() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      if(passwordOldcontroller.text != await authService.readCredentialPassword()){
        return callDialogAction(context, 'La antigua contraseña es incorrecta');
      }else{
        showLoading(context,'AGUARDE PORFAVOR');
        final Map<String, dynamic> data = {
          "cliente": {
            "nit": await authService.readCredentialNit(),
            "usuario": await authService.readCredentialUser(),
            "password": await authService.readCredentialPassword(),
            "imeimac": "56:3C:43:56:C7:B8"
            // "imeimac": prefs.getString('idDivice')
          }
        };
      // var response = await serviceMethod(context,'post',data,await service(context, 'serviceChangePassword'));
      //   if (response != null) {
      //     authService.registerPassword(passwordNewcontroller.text);
      //     Navigator.pop(context);
      //     Navigator.pop(context);
      //   }
      }
    }
  }
}
