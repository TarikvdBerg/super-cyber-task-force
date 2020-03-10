import 'package:SCTFPasswordManager/passwords/form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddSinglePassword extends StatefulWidget {


  _AddSinglePasswordState createState() => _AddSinglePasswordState();
}

class _AddSinglePasswordState extends State<AddSinglePassword> {
  final _addSinglePasswordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: <Widget>[
            Text("Add Password", style: Theme.of(context).textTheme.headline3),
            PasswordForm(
                formKey: _addSinglePasswordFormKey),
            ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                  child: Text("Cancel"),
                  color: Theme.of(context).errorColor,
                  onPressed: () {
                    print("Cancel Pressed");
                  },
                ),
                FlatButton(
                  child: Text("Add"),
                  color: Theme.of(context).buttonColor,
                  onPressed: () {
                    print("Add Pressed");
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}