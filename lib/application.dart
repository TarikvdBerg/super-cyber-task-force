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
            primaryColorLight: Color(0xFF212121)),
        home: Scaffold(
            body: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: SideBar(),
            )
          ],
        )));
  }
}
