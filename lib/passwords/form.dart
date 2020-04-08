import 'package:SCTFPasswordManager/core/api.dart';
import 'package:SCTFPasswordManager/core/cache.dart';
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
  TextEditingController _passwordNameController;
  TextEditingController _passwordDescriptionController;
  TextEditingController _passwordUsernameController;
  TextEditingController _passwordPasswordController;
  TextEditingController _passwordRepeatPasswordController;
  
  String currentGroup;

  DateTime _expiryDateTime;

  bool _obscurePassword = true;
  bool _obscureRepeatPassword = true;

  @override
  void initState() {
    // Populate the text controllers with a value if the password is provided.
    _passwordNameController = TextEditingController(
        text:
            this.widget.password != null ? this.widget.password.encName : null);
    _passwordDescriptionController = TextEditingController(
        text: this.widget.password != null
            ? this.widget.password.encDescription
            : null);
    _passwordUsernameController = TextEditingController(
        text: this.widget.password != null
            ? this.widget.password.encUsername
            : null);
    _passwordPasswordController = TextEditingController(
        text: this.widget.password != null
            ? this.widget.password.encPassword
            : null);
    _passwordRepeatPasswordController = TextEditingController(
        text: this.widget.password != null
            ? this.widget.password.encPassword
            : null);

    if (this.widget.password.group != null) {
      currentGroup = this.widget.password.group;
    }

    super.initState();
  }

  @override
  void dispose() {
    _passwordNameController.dispose();
    _passwordDescriptionController.dispose();
    _passwordUsernameController.dispose();
    _passwordPasswordController.dispose();
    _passwordRepeatPasswordController.dispose();
    super.dispose();
  }

  void groupChanged(dynamic inp) {
    this.widget.password.group = inp;
  }

  @override
  Widget build(BuildContext context) {
    Cache api = Provider.of<Cache>(context);

    return Form(
      key: this.widget.formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _passwordNameController,
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
              this.widget.password.encName = value;
            },
          ),
          TextFormField(
            controller: _passwordDescriptionController,
            decoration: InputDecoration(
              labelText: "Password Description",
            ),
            onSaved: (value) {
              this.widget.password.encDescription = value;
            },
          ),
          TextFormField(
            controller: _passwordUsernameController,
            decoration: InputDecoration(labelText: "Username"),
            validator: (value) {
              if (value == null || value == "") {
                return "The password cannot be empty";
              }

              return null;
            },
            onSaved: (value) {
              this.widget.password.encUsername = value;
            },
          ),
          TextFormField(
            controller: _passwordPasswordController,
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
              this.widget.password.encPassword = value;
            },
          ),
          TextFormField(
            controller: _passwordRepeatPasswordController,
            decoration: InputDecoration(
              labelText: "Repeat Password",
              suffixIcon: IconButton(
                icon: Icon(_obscureRepeatPassword
                    ? Icons.visibility_off
                    : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _obscureRepeatPassword = !_obscureRepeatPassword;
                  });
                },
              ),
            ),
            obscureText: _obscureRepeatPassword,
            validator: (value) {
              if (value == null || value == "") {
                return "The repeat password cannot be empty";
              }

              if (value != _passwordPasswordController.text) {
                return "Repeat password must be the same as the password.";
              }

              return null;
            },
          ),
          TextFormField(
            readOnly: true,
            decoration: InputDecoration(
              labelText: "Expiration Date",
              suffixIcon: Icon(Icons.calendar_today),
            ),
            onTap: () {
              showDatePicker(
                  context: context,
                  initialDate: _expiryDateTime == null
                      ? DateTime.now()
                      : _expiryDateTime,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(3000),
                  builder: (context, child) {
                    return Column(
                      children: <Widget>[
                        Container(height: 450, width: 700, child: child),
                      ],
                    );
                  }).then((pickedDate) {
                setState(() {
                  _expiryDateTime = pickedDate;
                });
              });
            },
          ),
          FutureBuilder<List<PasswordGroupModel>>(
            future: api.fetchAllGroups(),
            builder: (BuildContext context,
                AsyncSnapshot<List<PasswordGroupModel>> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              List<DropdownMenuItem<dynamic>> itemList = [];
              snapshot.data.forEach((element) {
                itemList.add(DropdownMenuItem(
                    value: element.id, child: Text(element.name)));
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
                    api.updatePassword(this.widget.password);
                  } else if (this.widget.state == "create") {
                    api.createPassword(this.widget.password);
                  }
                  Navigator.pop(context);
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
