
import 'package:SCTFPasswordManager/core/api.dart';
import 'package:SCTFPasswordManager/core/models.dart';
import 'package:flutter/material.dart';

class DebugView extends StatefulWidget {

  _DebugViewState createState() => _DebugViewState();
}


class _DebugViewState extends State<DebugView> {
  API api = API();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: FlatButton(child: Text("API Call"), onPressed: () {
        this.api.createUser(UserModel(
           displayName: "Niels van Marion",
           eMail: "n.n@n.nl",
           firstName: "Niels",
           lastName: "van Marion",
           userName: "NielsVM"
        ));
      },),)
    );
  }
}