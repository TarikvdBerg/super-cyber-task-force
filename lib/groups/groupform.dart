import 'dart:async';

import 'package:SCTFPasswordManager/core/cache.dart';
import 'package:SCTFPasswordManager/core/encryption.dart';
import 'package:SCTFPasswordManager/core/exceptions.dart';
import 'package:SCTFPasswordManager/core/tools.dart';
import 'package:flutter/material.dart';
import 'package:SCTFPasswordManager/core/models.dart';
import 'package:provider/provider.dart';

class GroupForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final PasswordGroupModel group;
  final String state;

  const GroupForm({Key key, this.formKey, this.group, this.state});

  _GroupFormState createState() => _GroupFormState();
}

class _GroupFormState extends State<GroupForm> {
  @override
  Widget build(BuildContext context) {
    Cache api = Provider.of<Cache>(context);
    EncryptionManager encryptor = Provider.of<EncryptionManager>(context);

    return Form(
      key: this.widget.formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            initialValue:
                this.widget.group.name == null || this.widget.group.name == ""
                    ? ""
                    : encryptor.decrypt(this.widget.group.name),
            decoration: InputDecoration(
              labelText: "Group Name",
            ),
            validator: (value) {
              if (value == null || value == "") {
                return "The name cannot be empty";
              }

              return null;
            },
            onSaved: (value) {
              this.widget.group.name = encryptor.encrypt(value);
            },
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Discard'),
                  color: Theme.of(context).errorColor),
              FlatButton(
                onPressed: () {
                  if (!this.widget.formKey.currentState.validate()) {
                    return;
                  }

                  this.widget.formKey.currentState.save();

                  // Save data
                  if (this.widget.state == "update") {
                    try {
                      api.updateGroup(this.widget.group);
                      Navigator.pop(context);
                    } on BadRequestException catch (e) {
                      String errors = e.errorMessage();
                      showSnackbar(
                          "Please fix the following errors: \n \t$errors",
                          context);
                    } on ServerErrorException {
                      showSnackbar(
                          "The server encountered an error, please try again later.",
                          context);
                    } on ModelDoesNotExistException {
                      showSnackbar(
                          "The group that should be updated doesn't exist anymore, refresh the application to fix this.",
                          context);
                    } on TimeoutException {
                      showSnackbar(
                          "The server took too long to respond, please try again later.",
                          context);
                    }
                  } else if (this.widget.state == "create") {
                    try {
                      api.createGroup(this.widget.group);
                      Navigator.pop(context);
                    } on BadRequestException catch (e) {
                      String errors = e.errorMessage();
                      showSnackbar(
                          "Please fix the following errors: \n \t$errors",
                          context);
                    } on ServerErrorException {
                      showSnackbar(
                          "The server encountered an error, please try again later.",
                          context);
                    } on ModelDoesNotExistException {
                      showSnackbar(
                          "The group that should be updated doesn't exist anymore, refresh the application to fix this.",
                          context);
                    } on TimeoutException {
                      showSnackbar(
                          "The server took too long to respond, please try again later.",
                          context);
                    } on ModelAlreadyExistsException {
                      showSnackbar(
                          "A group with this name already exists.", context);
                    }
                  }
                },
                child: Text("Save"),
                color: Theme.of(context).buttonColor,
              ),
            ],
          )
        ],
      ),
    );
  }
}
