import 'package:SCTFPasswordManager/views/debug.dart';
import 'package:SCTFPasswordManager/views/register.dart';
import 'package:SCTFPasswordManager/views/login.dart';
import 'package:SCTFPasswordManager/views/password_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SCTFPasswordManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SCTF Password Manager',
        theme: ThemeData(
          brightness: Brightness.dark,
            primaryColorDark: Color(0xFF131313),
            primaryColor: Color(0xFF212121),
            primaryColorLight: Color(0xFF484848),
            dividerColor: Color(0xBEBEBEBE),
            buttonColor: Color(0xFF008B7A),
            iconTheme: IconThemeData(color: Color(0xFFBEBEBE)),
            textTheme: TextTheme(
              headline1: TextStyle(color: Color(0XFFBEBEBE)),
              headline2: TextStyle(color: Color(0XFFBEBEBE)),
              headline3: TextStyle(color: Color(0XFFBEBEBE)),
              headline4: TextStyle(color: Color(0XFFBEBEBE)),
              headline5: TextStyle(color: Color(0XFFBEBEBE)),
              headline6: TextStyle(color: Color(0XFFBEBEBE)),
              bodyText1: TextStyle(color: Color(0XFFBEBEBE)),
              bodyText2: TextStyle(color: Color(0XFFBEBEBE)),
            ),
            cardColor: Color(0xFF212121)
            ),
        initialRoute: "login",
        routes: {
          "login": (context) => LoginView(),
          'register': (context) => RegisterView(),
          "dashboard": (context) => PasswordView(),
          "dbg": (context) => DebugView(),
        },
        home: Scaffold(),
        );
  }
}
