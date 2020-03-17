import 'package:SCTFPasswordManager/core/cache.dart';
import 'package:flutter/material.dart';

class DebugView extends StatelessWidget {
  final Cache c = Cache();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: <Widget>[
          Text("Debug Page"),
          FlatButton(
            onPressed: () {
            },
            child: Text("Store In DB"),
            color: Theme.of(context).buttonColor,
          ),
        ],
      ),
    );
  }
}
