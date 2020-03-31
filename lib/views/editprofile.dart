import 'package:SCTFPasswordManager/core/api.dart';
import 'package:SCTFPasswordManager/core/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final double sizeBetweenEntries = 15;
final RegExp mailRegex =
    RegExp(r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$");

class EditProfileView extends StatefulWidget {
  final UserModel model;

  EditProfileView({Key key, this.model});

  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  GlobalKey<FormState> _editUserFormkey = GlobalKey<FormState>();

  TextEditingController _passwordController;
  TextEditingController _passwordRepeatController;

  String inputPassword;

  @override
  void initState() {
    super.initState();

    this._passwordController = TextEditingController();
    this._passwordRepeatController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Edit Account Details"),
      content: Form(
        key: _editUserFormkey,
        child: Column(
          children: <Widget>[
            TextFormField(
                decoration: InputDecoration(labelText: "Username"),
                initialValue: this.widget.model.userName,
                readOnly: true,
                onSaved: (input) {}),
            TextFormField(
              decoration: InputDecoration(labelText: "First Name"),
              initialValue: this.widget.model.firstName,
              validator: (input) {
                if (input.isEmpty) {
                  return "First Name cannot be empty";
                }
                return null;
              },
              onSaved: (input) {
                this.widget.model.firstName = input;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Last Name"),
              initialValue: this.widget.model.lastName,
              validator: (input) {
                if (input.isEmpty) {
                  return "Last Name cannot be empty";
                }
                return null;
              },
              onSaved: (input) {
                this.widget.model.lastName = input;
              },
            ),
            TextFormField(
                decoration: InputDecoration(labelText: "EMail"),
                initialValue: this.widget.model.eMail,
                validator: (input) {
                  if (input.isEmpty) {
                    return "Email cannot be empty";
                  }

                  if (!mailRegex.hasMatch(input)) {
                    return "The provided email is not in a valid format";
                  }

                  return null;
                },
                onSaved: (input) {
                  this.widget.model.eMail = input;
                }),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                  labelText: "Password",
                  helperText: "Leave empty to keep the current password"),
              validator: (input) {
                if (input != _passwordRepeatController.text) {
                  return "The password and repeated password must be identical";
                }
                return null;
              },
              onSaved: (input) {
                inputPassword = input;
              },
            ),
            TextFormField(
              controller: _passwordRepeatController,
              decoration: InputDecoration(
                  labelText: "Repeat Password",
                  helperText: "Leave empty to keep the current password"),
              validator: (input) {
                if (input != _passwordController.text) {
                  return "The password and repeated password must be identical";
                }
                return null;
              },
              onSaved: (input) {
                return;
              },
            )
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
            color: Theme.of(context).errorColor),
        FlatButton(
            onPressed: () async {
              API api = Provider.of<API>(context, listen: false);
              if (!_editUserFormkey.currentState.validate()) {
                return;
              }
              _editUserFormkey.currentState.save();

              UserModel res = await api
                  .updateUser(this.widget.model, inputPassword);
              if (res != null) {
                Navigator.pop(context);
              }
            },
            child: Text("Save"),
            color: Theme.of(context).buttonColor)
      ],
    );
  }
}
