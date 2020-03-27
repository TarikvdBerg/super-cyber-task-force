import 'package:SCTFPasswordManager/core/models.dart';
import 'package:SCTFPasswordManager/passwords/group.dart';
import 'package:SCTFPasswordManager/sidebar/sidebar.dart';
import 'package:SCTFPasswordManager/core/api.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class PasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    API api = Provider.of<API>(context);
    api.authenticate("NielsVM", "Develop1");
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
                    FutureBuilder<List<PasswordGroupModel>>(
                      future: api.fetchAllGroups(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return PasswordGroup();
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ]),
                )
              ],
            )));
  }
}
