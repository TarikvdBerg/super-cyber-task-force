import 'package:SCTFPasswordManager/core/models.dart';
import 'package:flutter/material.dart';

class PasswordForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final PasswordModel password;

  const PasswordForm({Key key, this.formKey, this.password});

  _PasswordFormState createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  TextEditingController _passwordTextController = TextEditingController();
  DateTime _expiryDateTime;

  void groupChanged(dynamic inp) {
    // TODO: Implement me
    print("Password Group Changed");
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: this.widget.formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              initialValue: this.widget.password != null ? this.widget.password.encName : "",
              autofocus: true,
              decoration: InputDecoration(
                labelText: "Password Name",
              ),
            ),
            TextFormField(
              initialValue: this.widget.password != null ? this.widget.password.encDescription : "",
              autofocus: true,
              decoration: InputDecoration(
                labelText: "Password Description",
              ),
            ),
            TextFormField(
              initialValue: this.widget.password != null ? this.widget.password.encPassword : "",
              autofocus: true,
              decoration: InputDecoration(
                labelText: "Password",
              ),
            ),
            TextFormField(
              initialValue: this.widget.password != null ? this.widget.password.encPassword : "",
              autofocus: true,
              decoration: InputDecoration(
                labelText: "Repeat Password",
              ),
            ),
            TextFormField(
                readOnly: true,
                controller: _passwordTextController,
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
                          lastDate: DateTime(3000))
                      .then((pickedDate) {
                    setState(() {
                      _expiryDateTime = pickedDate;
                      _passwordTextController.text =
                          _expiryDateTime.toString();
                    });
                  });
                }),
            DropdownButtonFormField(
              onChanged: groupChanged,
              items: <DropdownMenuItem>[
                DropdownMenuItem(
                  value: "Group 1",
                  child: Text("Group 1"),
                ),
                DropdownMenuItem(
                  value: "Group 2",
                  child: Text("Group 2"),
                ),
                DropdownMenuItem(
                  value: "Group 3",
                  child: Text("Group 3"),
                ),
                DropdownMenuItem(
                  value: "Group 4",
                  child: Text("Group 4"),
                )
              ],
            )
          ],
        ));
  }
}
