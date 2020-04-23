import 'dart:async';

import 'package:SCTFPasswordManager/core/cache.dart';
import 'package:SCTFPasswordManager/core/encryption.dart';
import 'package:SCTFPasswordManager/core/exceptions.dart';
import 'package:SCTFPasswordManager/core/tools.dart';
import 'package:flutter/material.dart';
import 'package:SCTFPasswordManager/core/models.dart';
import 'package:provider/provider.dart';

class PasswordForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final PasswordModel password;
  final String state;

  const PasswordForm({Key key, this.formKey, this.password, this.state});

  _PasswordFormState createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  String currentGroup;

  DateTime _expiryDateTime;

  bool _obscurePassword = true;
  bool _obscureRepeatPassword = true;

  GlobalKey passwordInputKey = GlobalKey<FormFieldState>();
  GlobalKey passwordRepeatInputKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    if (this.widget.password.group != null) {
      currentGroup = this.widget.password.group;
    }

    super.initState();
  }

  void groupChanged(dynamic inp) {
    this.widget.password.group = inp;
  }

  @override
  Widget build(BuildContext context) {
    Cache api = Provider.of<Cache>(context);
    EncryptionManager encryptor = Provider.of<EncryptionManager>(context);
    return Form(
      key: this.widget.formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            initialValue: this.widget.password.encName == null ||
                    this.widget.password.encName == ""
                ? ""
                : encryptor.decrypt(this.widget.password.encName),
            // controller: _passwordNameController,
            decoration: InputDecoration(
              labelText: "Password Name",
            ),
            validator: (value) {
              if (value == null || value == "") {
                return "The name cannot be empty";
              }

              return null;
            },
            onSaved: (value) {
              this.widget.password.encName = encryptor.encrypt(value);
            },
          ),
          TextFormField(
            initialValue: this.widget.password.encPassword == null ||
                    this.widget.password.encPassword == ""
                ? ""
                : encryptor.decrypt(this.widget.password.encPassword),
            decoration: InputDecoration(
              labelText: "Password Description",
            ),
            onSaved: (value) {
              this.widget.password.encDescription = encryptor.encrypt(value);
            },
          ),
          TextFormField(
            initialValue: this.widget.password.encUsername == null ||
                    this.widget.password.encUsername == ""
                ? ""
                : encryptor.decrypt(this.widget.password.encUsername),
            decoration: InputDecoration(labelText: "Username"),
            validator: (value) {
              if (value == null || value == "") {
                return "The password cannot be empty";
              }

              return null;
            },
            onSaved: (value) {
              this.widget.password.encUsername = encryptor.encrypt(value);
            },
          ),
          TextFormField(
            key: passwordInputKey,
            initialValue: this.widget.password.encPassword == null ||
                    this.widget.password.encPassword == ""
                ? ""
                : encryptor.decrypt(this.widget.password.encPassword),
            decoration: InputDecoration(
              labelText: "Password",
              suffixIcon: IconButton(
                icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            obscureText: _obscurePassword,
            validator: (value) {
              if (value == null || value == "") {
                return "The password cannot be empty";
              }

              return null;
            },
            onSaved: (value) {
              this.widget.password.encPassword = encryptor.encrypt(value);
            },
          ),
          // TextFormField(
          //   initialValue: this.widget.password.encPassword == null ||
          //           this.widget.password.encPassword == ""
          //       ? ""
          //       : encryptor.decrypt(this.widget.password.encPassword),
          //   decoration: InputDecoration(
          //     labelText: "Repeat Password",
          //     suffixIcon: IconButton(
          //       icon: Icon(_obscureRepeatPassword
          //           ? Icons.visibility_off
          //           : Icons.visibility),
          //       onPressed: () {
          //         setState(() {
          //           _obscureRepeatPassword = !_obscureRepeatPassword;
          //         });
          //       },
          //     ),
          //   ),
          //   obscureText: _obscureRepeatPassword,
          //   validator: (value) {
          //     if (value == null || value == "") {
          //       return "The repeat password cannot be empty";
          //     }

          //     if (value != passwordInputKey.currentState.widget.) {
          //       return "Repeat password must be the same as the password.";
          //     }

          //     return null;
          //   },
          // ),
          // TextFormField(
          //   readOnly: true,
          //   decoration: InputDecoration(
          //     labelText: "Expiration Date",
          //     suffixIcon: Icon(Icons.calendar_today),
          //   ),
          //   onTap: () {
          //     showDatePicker(
          //         context: context,
          //         initialDate: _expiryDateTime == null
          //             ? DateTime.now()
          //             : _expiryDateTime,
          //         firstDate: DateTime.now(),
          //         lastDate: DateTime(3000),
          //         builder: (context, child) {
          //           return Column(
          //             children: <Widget>[
          //               Container(height: 450, width: 700, child: child),
          //             ],
          //           );
          //         }).then((pickedDate) {
          //       setState(() {
          //         _expiryDateTime = pickedDate;
          //       });
          //     });
          //   },
          // ),
          FutureBuilder<List<PasswordGroupModel>>(
            future: api.fetchAllGroups(),
            builder: (BuildContext context,
                AsyncSnapshot<List<PasswordGroupModel>> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              if (snapshot.hasError) {
                if (snapshot.error is RequestNotAuthenticatedException) {
                  showSnackbar(
                      "The current authentication credentials are invalid. Please logout and log back in.",
                      context);
                }

                if (snapshot.error is ServerErrorException) {
                  showSnackbar(
                      "The server encountered an error while processing your entry. Please try again later.",
                      context);
                }
                if (snapshot.error is TimeoutException) {
                  showSnackbar(
                      "The server took too long to respond. Please try again later.",
                      context);
                }

                return Text(
                    "Failed to retrieve groups, please close this popup and try again.");
              }

              List<DropdownMenuItem<dynamic>> itemList = [];
              snapshot.data.forEach((element) {
                itemList.add(DropdownMenuItem(
                    value: element.id, child: Text(encryptor.decrypt(element.name))));
              });

              return DropdownButtonFormField(
                  items: itemList, onChanged: groupChanged);
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
                  Cache api = Provider.of<Cache>(context, listen: false);
                  if (this.widget.state == "update") {
                    try {
                      api.updatePassword(this.widget.password);
                      Navigator.pop(context);
                    } on ModelDoesNotExistException {
                      showSnackbar(
                          "The entry you are trying to update does not exist, it might've been deleted. Refresh the application to get an up to date version of your information.",
                          context);
                    } on BadRequestException catch (e) {
                      showSnackbar(
                          'Something went wrong while updating your entry: \n' +
                              e.errorMessage(),
                          context);
                    } on ServerErrorException {
                      showSnackbar(
                          "The server encountered an error while processing your entry. Please try again later.",
                          context);
                    } on TimeoutException {
                      showSnackbar(
                          "The server took too long to respond. Please try again later.",
                          context);
                    }
                  } else if (this.widget.state == "create") {
                    try {
                      api.createPassword(this.widget.password);
                      Navigator.pop(context);
                    } on ModelDoesNotExistException {
                      showSnackbar(
                          "The entry you are trying to update does not exist, it might've been deleted. Refresh the application to get an up to date version of your information.",
                          context);
                    } on BadRequestException catch (e) {
                      showSnackbar(
                          'Something went wrong while updating your entry: \n' +
                              e.errorMessage(),
                          context);
                    } on ServerErrorException {
                      showSnackbar(
                          "The server encountered an error while processing your entry. Please try again later.",
                          context);
                    } on TimeoutException {
                      showSnackbar(
                          "The server took too long to respond. Please try again later.",
                          context);
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
