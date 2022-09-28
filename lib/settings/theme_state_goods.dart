import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';
ligthGood(){
  return AppTheme(
              id: "light",
              description: "claro",
              data: ThemeData(
              brightness: Brightness.light,
                      // ignore: deprecated_member_use
                accentColorBrightness: Brightness.dark,
                      // ignore: deprecated_member_use
                buttonColor: const Color(0xffD89E49),
                indicatorColor: Colors.white,
                toggleableActiveColor:  Colors.white,
                splashColor: Colors.white24,
                splashFactory: InkRipple.splashFactory,
                errorColor: const Color(0xFFB00020),
                disabledColor: const Color(0xff1D1D25),
                hintColor: const Color(0xff1D1D25),

                primaryColorLight: const Color(0xffD89E49),
                primaryColorDark: const Color(0xff1D1D25),
                dialogBackgroundColor: const Color(0xfff2f2f2),
                inputDecorationTheme: const InputDecorationTheme(
                  hintStyle: TextStyle(
                      color: Color(0xff252F37), fontFamily: "Ubuntu"),
                ),
                scaffoldBackgroundColor: const Color(0xfff2f2f2),
                backgroundColor: const Color(0xfff2f2f2),
                primaryIconTheme: const IconThemeData(color: Colors.white),
                appBarTheme: const AppBarTheme(
                    // textTheme: TextTheme(
                    //   headline6: TextStyle(fontFamily: "Ubuntu", color: Colors.white),
                    //   button: TextStyle(color: Colors.green),
                    //   headline1: TextStyle(color: Colors.green),
                    //   bodyText2: TextStyle(color: Colors.green),

                    // ),
                    // brightness: Brightness.dark,
                    color: Color(0xffD89E49)),
                    
                bottomAppBarColor: Colors.orange,
                secondaryHeaderColor: const Color(0xff1D1D25),
                // sizeLetter(context),
                fontFamily: "Ubuntu",
                primaryColor: const Color(0xffD89E49),
                      // ignore: deprecated_member_use
                accentColor: const Color(0xff1D1D25),
                textTheme: const TextTheme(
                  
                  headline1:TextStyle(color: Colors.green,fontSize: 14),
                  headline2:TextStyle(color: Colors.green,fontSize: 14),
                  headline3:TextStyle(color: Colors.green,fontSize: 14),
                  headline4:TextStyle(color: Colors.green,fontSize: 14),
                  headline5:TextStyle(color: Colors.green,fontSize: 14),
                  headline6: TextStyle(color: Colors.green,fontSize: 14),
                  subtitle1: TextStyle(color: Colors.green,fontSize: 14),
                  subtitle2: TextStyle(color: Colors.green,fontSize: 14),
                  button: TextStyle(color: Colors.green,fontSize: 14),
                  bodyText1: TextStyle(color: Colors.green,fontSize: 14),
                  bodyText2: TextStyle(color: Colors.green,fontSize: 14),
                  caption: TextStyle(color: Colors.green,fontSize: 14),
                  overline: TextStyle(color: Colors.green,fontSize: 14),
                ).apply(
                  fontFamily: "Ubuntu",
                  bodyColor: const Color(0xff1D1D25),
                  displayColor: const Color(0xff1D1D25),

                ),
              ),
            );    
}
darkGood(){
  return AppTheme(
              id: "dark",
              description: "claro",
              data: ThemeData(
                primaryColorLight: const Color(0xffD89E49),
                primaryColorDark: const Color(0xff1D1D25),
                dialogBackgroundColor: const Color(0xff1D1D25),
                inputDecorationTheme: const InputDecorationTheme(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xfff2f2f2)),
                            ),
                  hintStyle: TextStyle(
                      color: Color(0xffD89E49), fontFamily: "Ubuntu"),
                ),
                canvasColor: const Color(0xff1D1D25),
                scaffoldBackgroundColor: const Color(0xff1D1D25),
                backgroundColor: const Color(0xff1D1D25),
                primaryIconTheme: const IconThemeData(color: Colors.white),
                disabledColor: const Color(0xfff2f2f2),
                hintColor: const Color(0xfff2f2f2),
                appBarTheme: const AppBarTheme(
                    // textTheme: TextTheme(
                    //   headline6: TextStyle(
                    //       fontFamily: "Ubuntu", color: Color(0xfff2f2f2)),
                    //   button: TextStyle(color: Colors.green),
                    //   headline1: TextStyle(color: Colors.green),
                    //   bodyText2: TextStyle(color: Colors.green),
                    // ),
                    // brightness: Brightness.dark,
                    color: Color(0xffD89E49)),
                bottomAppBarColor: Colors.green,
                secondaryHeaderColor: const Color(0xff1D1D25),
                fontFamily: "Ubuntu",
                primaryColor: const Color(0xffD89E49),
                      // ignore: deprecated_member_use
                accentColor: const Color(0xffF2f2f2),
                textTheme: const TextTheme(
                  headline1:TextStyle(color: Colors.green,fontSize: 14),
                  headline2:TextStyle(color: Colors.green,fontSize: 14),
                  headline3:TextStyle(color: Colors.green,fontSize: 14),
                  headline4:TextStyle(color: Colors.green,fontSize: 14),
                  headline5:TextStyle(color: Colors.green,fontSize: 14),
                  headline6: TextStyle(color: Colors.green,fontSize: 14),
                  subtitle1: TextStyle(color: Colors.green,fontSize: 14),
                  subtitle2: TextStyle(color: Colors.green,fontSize: 14),
                  button: TextStyle(color: Colors.green,fontSize: 14),
                  bodyText1: TextStyle(color: Colors.green,fontSize: 14),
                  bodyText2: TextStyle(color: Colors.green,fontSize: 14),
                  caption: TextStyle(color: Colors.green,fontSize: 14),
                  overline: TextStyle(color: Colors.green,fontSize: 14),
                ).apply(
                  fontFamily: "Ubuntu",
                  displayColor: const Color(0xfff2f2f2),
                  bodyColor: const Color(0xfff2f2f2),
                  decorationColor: const Color(0xfff2f2f2),
                ),
              ),
            );
}