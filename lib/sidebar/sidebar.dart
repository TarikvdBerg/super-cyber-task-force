import 'package:SCTFPasswordManager/sidebar/profile.dart';
import 'package:SCTFPasswordManager/sidebar/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SideBar extends StatefulWidget {
  final String userName;
  final String eMail;

  SideBar({
    Key key,
    this.userName,
    this.eMail
  }) : super(key: key);

  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColorDark,
      width: 250,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          SideBarProfile(userName: this.widget.userName, eMail: this.widget.eMail),
          Divider(
            color: Theme.of(context).dividerColor
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 99,
            child: Column(children: <Widget>[
              NavigationButton(title: "My Passwords", iconData: Icons.security),
              NavigationButton(title: "Add Password", iconData: Icons.add),
              NavigationButton(title: "My Profile", iconData: Icons.face),
              Spacer(),
              NavigationButton(title: "Log Out", iconData: Icons.subdirectory_arrow_left, targetURI: "login",)
            ]),
          )
        ],
      ),
    );
  }
}