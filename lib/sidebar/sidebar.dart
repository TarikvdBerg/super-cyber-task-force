import 'package:SCTFPasswordManager/sidebar/profile.dart';
import 'package:SCTFPasswordManager/sidebar/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      width: 250,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          SideBarProfile(),
          Divider(
            color: Color(0xFFBEBEBE),
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
              NavigationButton(title: "Log Out", iconData: Icons.subdirectory_arrow_left)
            ]),
          )
        ],
      ),
    );
  }
}