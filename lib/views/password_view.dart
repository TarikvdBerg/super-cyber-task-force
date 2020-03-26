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
                Container(
                  width: MediaQuery.of(context).size.width - 250,
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.topCenter,
                  child: ListView(children: <Widget>[
                    PasswordGroup(
                      groupName: "Cool Password Group",
                      passwordList: <Password>[
                      ],
                    ),
                    PasswordGroup(
                      groupName: "Cool Password Group",
                      passwordList: <Password>[
                      ],
                    ),
                  ]),
                )
              ],
            )));
  }
}
