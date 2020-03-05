import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, "dashboard");
              },
              child: Text("Go To Dash")),
          FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, "register");
              },
              child: Text("Go To Register Page")),
          FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, "dbg");
              },
              child: Text("Go To Debug Page")),
        ],
      ),
    );
  }
}
