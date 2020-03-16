import 'package:SCTFPasswordManager/core/tables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DebugView extends StatelessWidget {
  const DebugView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: <Widget>[
          Text("Debug Page"),
          FlatButton(
            onPressed: () {
              Provider.of<LocalPasswordDatabase>(context, listen: false).usersDao.insertUser(
                  User(
                      id: "null",
                      username: "null",
                      email: "null",
                      firstname: "null",
                      lastname: "null",
                      displayname: "null"));
            },
            child: Text("Store In DB"),
            color: Theme.of(context).buttonColor,
          ),
        ],
      ),
    );
  }
}
