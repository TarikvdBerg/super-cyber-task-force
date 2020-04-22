import 'dart:async';

import 'package:SCTFPasswordManager/core/cache.dart';
import 'package:SCTFPasswordManager/core/exceptions.dart';
import 'package:SCTFPasswordManager/core/models.dart';
import 'package:SCTFPasswordManager/core/tools.dart';
import 'package:SCTFPasswordManager/passwords/password.dart';
import 'package:SCTFPasswordManager/sidebar/sidebar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:SCTFPasswordManager/passwords/group.dart';

class PasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Cache api = Provider.of<Cache>(context);
    return Scaffold(
        body: Container(
            color: Theme.of(context).primaryColor,
            child: Row(
              children: <Widget>[
                FutureBuilder(
                    future: api.fetchUser(),
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
                          if (snapshot.error
                              is RequestNotAuthenticatedException) {
                            showSnackbar(
                                "The current authentication informaion is invalid. Please logout and log back in.",
                                context);
                          }
                          if (snapshot.error is ServerErrorException) {
                            showSnackbar(
                                "The server encountered an error while retrieving information. Please try again later.",
                                context);
                          }
                          if (snapshot.error is TimeoutException) {
                            showSnackbar(
                                "The server took too long to respond. Please try again later.",
                                context);
                          }
                          return Container();
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
