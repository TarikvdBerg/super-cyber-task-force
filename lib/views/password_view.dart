import 'package:SCTFPasswordManager/passwords/group.dart';
import 'package:SCTFPasswordManager/passwords/password.dart';
import 'package:SCTFPasswordManager/sidebar/sidebar.dart';
import 'package:flutter/material.dart';

class PasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Theme.of(context).primaryColor,
            child: Row(
              children: <Widget>[
                SideBar(userName: "John Doe", eMail: "john.doe@gmail.com"),
                SingleChildScrollView(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: PasswordGroup(groupName: "Cool Password Group"))
                )
              ],
            )));
  }
}
