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
                  margin: EdgeInsets.only(left: 15),
                  child: Password(
                    imgURL:
                        "https://cdn1.iconfinder.com/data/icons/logotypes/32/youtube-512.png",
                    description: "Cool Password",
                    encPassword: "l;ahsdgljnadbdoSEFL;KJ",
                    name: "YouTube",
                    userName: "johnny_doe",
                  ),
                )
              ],
            )));
  }
}
