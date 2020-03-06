import 'package:SCTFPasswordManager/core/api.dart';
import 'package:SCTFPasswordManager/core/models.dart';
import 'package:flutter/material.dart';

class DebugView extends StatefulWidget {
  _DebugViewState createState() => _DebugViewState();
}

class _DebugViewState extends State<DebugView> {
  API api = API();

  dynamic res;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Wrap(
      children: <Widget>[
        
      ],
    )));
  }
}
