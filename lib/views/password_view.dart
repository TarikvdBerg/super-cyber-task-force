import 'package:SCTFPasswordManager/core/models.dart';
import 'package:SCTFPasswordManager/passwords/password.dart';
import 'package:SCTFPasswordManager/sidebar/sidebar.dart';
import 'package:SCTFPasswordManager/core/api.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:SCTFPasswordManager/passwords/group.dart';

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
                FutureBuilder(
                    future:
                        api.fetchUser("12622302-864a-4b4b-a024-3f0a0586b025"),
                    builder: (BuildContext context,
                        AsyncSnapshot<UserModel> snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      }

                      return SideBar(model: snapshot.data);
                    }),
                Container(
                  width: MediaQuery.of(context).size.width - 250,
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.topCenter,
                  child: FutureBuilder<List<PasswordGroupModel>>(
                      future: api.fetchAllGroups(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<PasswordGroupModel>> snapshot) {
                        if (snapshot.hasError) {
                          print(snapshot.error);
                        }

                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }

                        List<PasswordGroup> itemList = [];
                        snapshot.data.forEach((element) {
                          itemList.add(PasswordGroup(
                              passwordList: <Password>[],
                              passwordGroup: element));
                        });

                        return ListView(children: itemList);
                      }),
                ),
              ],
            )));
  }
}
