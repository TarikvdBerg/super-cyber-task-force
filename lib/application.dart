import 'package:SCTFPasswordManager/sidebar/sidebar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SCTFPasswordManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SCTF Password Manager',
        theme: ThemeData(
            primaryColor: Color(0xFF131313),
            primaryColorLight: Color(0xFF212121),
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
            )),
        home: Scaffold(
            body: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: SideBar(userName: "John Doe", eMail: "john.doe@isp.com"),
            )
          ],
        )));
  }
}
