import 'package:app_artistica/components/animate.dart';
import 'package:app_artistica/dialogs/dialog_back.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_artistica/screens/configureApp/change_password.dart';
import 'package:app_artistica/screens/configureApp/terms_conditions.dart';
import 'package:theme_provider/theme_provider.dart';

class ModalInsideModal extends StatefulWidget {
  const ModalInsideModal({Key? key}) : super(key: key);
  @override
  _ModalInsideModalState createState() => _ModalInsideModalState();
}

class _ModalInsideModalState extends State<ModalInsideModal> with TickerProviderStateMixin {
  TabController? tabController;
  String title = 'ACTUALIZAR CONTRASEÑA';
  double valueHeigth = 2;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
              backgroundColor:
                  ThemeProvider.themeOf(context).data.scaffoldBackgroundColor,
              leading: const Text(''),
              middle: Text(
                title,
                // ignore: deprecated_member_use
                style: TextStyle(
                    color: ThemeProvider.themeOf(context).data.accentColor),
              )),
          child: SizedBox(
            height: MediaQuery.of(context).size.height <
                    MediaQuery.of(context).size.width
                ? MediaQuery.of(context).size.height
                : MediaQuery.of(context).size.height / valueHeigth,
            child: DefaultTabController(
                initialIndex: 1,
                length: 3,
                child: TabBarView(
                  controller: tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    TabScreenChangePwd(nextScreen: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {
                        valueHeigth = 1;
                        title = 'POLÍTICA DE PRIVACIDAD';
                      });
                      tabController!.animateTo(tabController!.index + 1);
                    }),
                    TabScreenTermAndConditions(nextScreen: () => Navigator.pop(context)),
                  ],
                )),
          )),
    );
  }

  Future<bool> _onBackPressed() async {
    return await showDialog(
      context: context,
      builder: (context) => const ComponentAnimate(child: DialogBack()));
  }
}
