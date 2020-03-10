import 'package:SCTFPasswordManager/core/models.dart';
import 'package:SCTFPasswordManager/passwords/form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditSinglePassword extends StatefulWidget {
  final PasswordModel password;

  EditSinglePassword({this.password});

  _EditSinglePasswordState createState() => _EditSinglePasswordState();
}

class _EditSinglePasswordState extends State<EditSinglePassword> {
  final _editPasswordFormKey = GlobalKey<FormState>();

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
            Text("Edit Password", style: Theme.of(context).textTheme.headline3),
            PasswordForm(
                formKey: _editPasswordFormKey, password: this.widget.password),
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
                  child: Text("Save"),
                  color: Theme.of(context).buttonColor,
                  onPressed: () {
                    print("Save Pressed");
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
