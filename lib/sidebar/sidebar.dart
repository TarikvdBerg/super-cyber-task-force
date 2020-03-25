import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:SCTFPasswordManager/sidebar/profile.dart';
import 'package:SCTFPasswordManager/sidebar/navigationbutton.dart';
import 'package:SCTFPasswordManager/sidebar/actionbutton.dart';

class SideBar extends StatefulWidget {
  final String userName;
  final String eMail;

  SideBar({Key key, this.userName, this.eMail}) : super(key: key);

  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  void confirmLogOut(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Are you sure?"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                return Navigator.popUntil(
                  context,
                  ModalRoute.withName("login"),
                );
              },
              child: const Text("Log out"),
            ),
            FlatButton(
              onPressed: () {
                return Navigator.pop(context, "password");
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void confirmLogOutAllDevices(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Log out everywhere"),
          content: const Text(
              "Are you sure you want to log out on all devices you're currently logged into?"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                print("TODO: Implement logOutEverywhere functionality");
              },
              child: const Text("Log out"),
            ),
            FlatButton(
              onPressed: () {
                return Navigator.pop(context, "password");
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColorDark,
      width: 250,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          SideBarProfile(
              userName: this.widget.userName, eMail: this.widget.eMail),
          Divider(color: Theme.of(context).dividerColor),
          Container(
            margin: EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 99,
            child: Column(children: <Widget>[
              NavigationButton(title: "My Passwords", iconData: Icons.security),
              NavigationButton(title: "Add Password", iconData: Icons.add),
              NavigationButton(title: "My Profile", iconData: Icons.face),
              //NavigationButton(title: "Add group", iconData: Icons.group_add , targetURI: "AddGroup",),
              //NavigationButton(title: "Remove group", iconData: Icons.remove_circle , targetURI: "RemoveGroup",),
              //NavigationButton(title: "Edit group", iconData: Icons.edit , targetURI: "EditGroup",),
              Spacer(),
              ActionButton(
                title: "Log Out Everywhere",
                iconData: Icons.exit_to_app,
                action: confirmLogOutAllDevices,
              ),
              ActionButton(
                title: "Log Out",
                iconData: Icons.exit_to_app,
                action: confirmLogOut,
              ),
            ]),
          )
        ],
      ),
    );
  }
}
