import 'dart:async';
import 'package:app_artistica/services/call_supplementary_data.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:app_artistica/bloc/contact/contact_bloc.dart';
import 'package:app_artistica/bloc/selected_product/selected_product_bloc.dart';
import 'package:app_artistica/bloc/user/user_bloc.dart';
import 'package:app_artistica/components/animate.dart';
import 'package:app_artistica/dialogs/dialog_back.dart';
import 'package:app_artistica/provider/app_state.dart';
import 'package:app_artistica/screens/configureApp/modal_inside_modal.dart';
import 'package:app_artistica/screens/navigator/cart/cart_screen.dart';
import 'package:app_artistica/screens/navigator/inventory/inventory_page.dart';
import 'package:app_artistica/screens/navigator/profile/my_profile_screen.dart';
import 'package:app_artistica/screens/navigator/shop/shopping.dart';
import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:badges/badges.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';

class NavigatorBar extends StatefulWidget {
  const NavigatorBar({Key? key}) : super(key: key);
  @override
  _NavigatorBar createState() => _NavigatorBar();
}

class _NavigatorBar extends State<NavigatorBar> {
  List<Widget> pageList = <Widget>[
    const ScreenShopping(),
    const CartScreen(),
    const CategoriesScreen(),
    const MyProfileScreen(),
  ];
  int pageIndex = 0;
  int currentIndex = 0;

  @override
  void initState() {
    // final userBloc = BlocProvider.of<UserBloc>(context, listen: false).state;
    // if(userBloc.companyName == ''){
    //   _showModalInside();
    // }
    _askPermissions();
    super.initState();
  }

  Future<void> _askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      refreshContacts();
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }
  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }
   void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      const snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      const snackBar = SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
  Future<void> refreshContacts() async {
    final contactBloc = BlocProvider.of<ContactBloc>(context, listen: false);
    final contacts = (await ContactsService.getContacts(withThumbnails: false, iOSLocalizedLabels: true));
    contactBloc.add(UpdateContact(contacts));
  }



  @override
  Widget build(BuildContext context) {
    final selectedProductBloc = BlocProvider.of<SelectedProductBloc>(context, listen: true).state;
    final appState = Provider.of<AppState>(context, listen: true);
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          body: pageList.elementAt(appState.selectedIndexScreen),
          bottomNavigationBar: BubbleBottomBar(
            backgroundColor: ThemeProvider.themeOf(context).data.backgroundColor,
            hasNotch: true,
            opacity: .3,
            currentIndex: appState.selectedIndexScreen,
            onTap: (index) {
              callInfoSupplementary( context );
              appState.updateSelectedIndexScreenId(index!);
              },
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            elevation: 50,
            items: <BubbleBottomBarItem>[

              BubbleBottomBarItem(
                  backgroundColor: ThemeProvider.themeOf(context).data.primaryColorLight,
                  icon: Image.asset("assets/icons/001-store.png",
                      fit: BoxFit.contain,
                      width: MediaQuery.of(context).size.width * 0.07,
                      color: Colors.grey),
                  activeIcon: Image.asset("assets/icons/001-store.png",
                      fit: BoxFit.contain,
                      width: MediaQuery.of(context).size.width * 0.07,
                      color: ThemeProvider.themeOf(context).data.primaryColorLight),
                  title: Text("Tienda",
                      style: TextStyle(
                          color: ThemeProvider.themeOf(context)
                              .data
                              .primaryColorLight))),


              BubbleBottomBarItem(
                  backgroundColor: ThemeProvider.themeOf(context).data.primaryColorLight,
                  icon: selectedProductBloc.existSelectedProduct? 

                      selectedProductBloc.selectedProducts!.isNotEmpty?Badge(
                          position: BadgePosition.topEnd(top: -10, end: -10),
                          animationDuration: const Duration(milliseconds: 300),
                          animationType: BadgeAnimationType.slide,
                          badgeContent: Text('${selectedProductBloc.selectedProducts!.length}',
                              style: const TextStyle(color: Colors.white)),
                          child: Image.asset("assets/icons/001-cart.png",
                              fit: BoxFit.contain,
                              width: MediaQuery.of(context).size.width * 0.07,
                              color: Colors.grey),
                        ):Image.asset("assets/icons/001-cartEmpty.png",
                          fit: BoxFit.contain,
                          width: MediaQuery.of(context).size.width * 0.07,
                          color: Colors.grey)
                      : Image.asset("assets/icons/001-cartEmpty.png",
                          fit: BoxFit.contain,
                          width: MediaQuery.of(context).size.width * 0.07,
                          color: Colors.grey),
                  activeIcon: selectedProductBloc.existSelectedProduct? 
                      selectedProductBloc.selectedProducts!.isNotEmpty?Badge(
                          position: BadgePosition.topEnd(top: -10, end: -10),
                          animationDuration: const Duration(milliseconds: 300),
                          animationType: BadgeAnimationType.slide,
                          badgeContent: Text('${selectedProductBloc.selectedProducts!.length}',
                              style: const TextStyle(color: Colors.white)),
                          child: Image.asset("assets/icons/001-cart.png",
                              fit: BoxFit.contain,
                              width: MediaQuery.of(context).size.width * 0.07,
                              color: ThemeProvider.themeOf(context).data.primaryColorLight),
                        ):Image.asset("assets/icons/001-cartEmpty.png",
                          fit: BoxFit.contain,
                          width: MediaQuery.of(context).size.width * 0.07,
                          color: ThemeProvider.themeOf(context).data.primaryColorLight)
                      : Image.asset("assets/icons/001-cartEmpty.png",
                          fit: BoxFit.contain,
                          width: MediaQuery.of(context).size.width * 0.07,
                          color: ThemeProvider.themeOf(context).data.primaryColorLight),
                  title: Text("Carrito",
                      style: TextStyle(
                          color: ThemeProvider.themeOf(context)
                              .data
                              .primaryColorLight))),



              BubbleBottomBarItem(
                  backgroundColor: ThemeProvider.themeOf(context).data.primaryColorLight,
                  icon: Image.asset("assets/icons/011-box.png",
                      fit: BoxFit.contain,
                      width: MediaQuery.of(context).size.width * 0.07,
                      color: Colors.grey),
                  activeIcon: Image.asset("assets/icons/011-box.png",
                      fit: BoxFit.contain,
                      width: MediaQuery.of(context).size.width * 0.07,
                      color: ThemeProvider.themeOf(context).data.primaryColorLight),
                  title: Text("Inventario",
                      style: TextStyle(
                          color: ThemeProvider.themeOf(context).data.primaryColorLight))),
              BubbleBottomBarItem(
                  backgroundColor: ThemeProvider.themeOf(context).data.primaryColorLight,
                  icon: Image.asset("assets/icons/contact.png",
                      fit: BoxFit.contain,
                      width: MediaQuery.of(context).size.width * 0.07,
                      color: Colors.grey),
                  activeIcon: Image.asset("assets/icons/contact.png",
                      fit: BoxFit.contain,
                      width: MediaQuery.of(context).size.width * 0.07,
                      color: ThemeProvider.themeOf(context).data.primaryColorLight),
                  title: Text("Perfil",
                      style: TextStyle(
                          color: ThemeProvider.themeOf(context).data.primaryColorLight))),
            ],
          ),
        ));
  }

  Future<bool> _onBackPressed() async {
    return await showDialog(
        context: context,
        builder: (context) => const ComponentAnimate(child: DialogBack()));
  }

  _showModalInside() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return showBarModalBottomSheet(
      enableDrag:false,
      expand: false,
      context: context,
      builder: (context) => const ModalInsideModal(),
    );
  }
}
