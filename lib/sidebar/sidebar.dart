import 'package:SCTFPasswordManager/core/api.dart';
import 'package:SCTFPasswordManager/core/models.dart';
import 'package:SCTFPasswordManager/passwords/add_password.dart';
import 'package:SCTFPasswordManager/groups/add_group.dart';
import 'package:SCTFPasswordManager/sidebar/actionbutton.dart';
import 'package:SCTFPasswordManager/sidebar/navigationbutton.dart';
import 'package:SCTFPasswordManager/sidebar/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class SideBar extends StatefulWidget {
  final UserModel model;

  SideBar({Key key, this.model}) : super(key: key);

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
                    context, ModalRoute.withName("login"));
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
    API api = Provider.of<API>(context);
    return Container(
      color: Theme.of(context).primaryColorDark,
      width: 250,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          // If the passed model is null, retrieve user info. Else pass the local version
          // of the User Model.
          this.widget.model == null
              ? FutureBuilder(
                  future: api.fetchUser("12622302-864a-4b4b-a024-3f0a0586b025"),
                  builder: (BuildContext context,
                      AsyncSnapshot<UserModel> snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }

                    return SideBarProfile(model: snapshot.data);
                  })
              : SideBarProfile(model: this.widget.model),
          Divider(color: Theme.of(context).dividerColor),
          Container(
            margin: EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 99,
            child: Column(children: <Widget>[
              NavigationButton(
                  title: "My Passwords",
                  iconData: Icons.security,
                  pressedAction: () {
                    String targetRoute = "dashboard";
                    bool isNewRouteSameAsCurrent = false;
                    Navigator.popUntil(context, (route) {
                      if (route.settings.name == targetRoute) {
                        isNewRouteSameAsCurrent = true;
                      }
                      return true;
                    });

                    if (!isNewRouteSameAsCurrent) {
                      Navigator.pushNamed(context, targetRoute);
                    }
                  }),

              NavigationButton(
                title: "Add Password",
                iconData: Icons.add,
                pressedAction: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddSinglePassword();
                      });
                },
              ),
              NavigationButton(
                title: "Add Group",
                iconData: Icons.add,
                pressedAction: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddGroupForm();
                      });
                },
              ),
              NavigationButton(
                  title: "My Profile",
                  iconData: Icons.face,
                  pressedAction: () {
                    String targetRoute = "account";
                    bool isNewRouteSameAsCurrent = false;
                    Navigator.popUntil(context, (route) {
                      if (route.settings.name == targetRoute) {
                        isNewRouteSameAsCurrent = true;
                      }
                      return true;
                    });

                    if (!isNewRouteSameAsCurrent) {
                      Navigator.pushNamed(context, targetRoute);
                    }
                  }), //NavigationButton(title: "Add group", iconData: Icons.group_add , targetURI: "AddGroup",),
              //NavigationButton(title: "Remove group", iconData: Icons.remove_circle , targetURI: "RemoveGroup",),
              //NavigationButton(title: "Edit group", iconData: Icons.edit , targetURI: "EditGroup",),
              Spacer(),
              ActionButton(
                title: "Log Out",
                iconData: Icons.exit_to_app,
                iconColor: Theme.of(context).iconTheme.color,
                action: confirmLogOut,
              ),
            ]),
          )
        ],
      ),
    );
  }
}
