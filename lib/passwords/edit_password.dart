import 'package:SCTFPasswordManager/core/api.dart';
import 'package:SCTFPasswordManager/core/models.dart';
import 'package:SCTFPasswordManager/passwords/form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditSinglePassword extends StatefulWidget {
  final PasswordModel password;

  EditSinglePassword({this.password});

  _EditSinglePasswordState createState() => _EditSinglePasswordState();
}

class _EditSinglePasswordState extends State<EditSinglePassword> {
  GlobalKey _editPasswordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Password'),
      content: Container(
        width: 400,
        height: 300,
        child: ListView(
          children: <Widget>[
            PasswordForm(
                formKey: _editPasswordFormKey, password: this.widget.password, state: "update"),
          ],
        ),
      ),
    );
  }
}
