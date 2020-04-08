import 'package:SCTFPasswordManager/core/models.dart';
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
    return AlertDialog(
      title: Text('Add Password'),
      content: Container(
        width: 400,
        height: 300,
        child: ListView(
          children: <Widget>[
            PasswordForm(
                formKey: _addSinglePasswordFormKey, password: PasswordModel(), state: "create"),
          ],
        ),
      ),
    );
  }
}