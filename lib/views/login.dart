import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlatButton(
          onPressed: () {
            Navigator.pushNamed(context, "dashboard");
          },
          child: Text("Go To Dash")),
    );
  }
}
