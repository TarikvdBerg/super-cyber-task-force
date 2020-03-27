import 'package:SCTFPasswordManager/core/models.dart';
import 'package:flutter/material.dart';

class GroupForm extends StatefulWidget {
  final GlobalKey<FormState> groupFormKey;
  final PasswordGroupModel group;

  const GroupForm({Key key, this.groupFormKey, this.group});

  _GroupFormState createState() => _GroupFormState();
}

class _GroupFormState extends State<GroupForm> {
  TextEditingController _passwordTextController = TextEditingController();
  DateTime _expiryDateTime;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: this.widget.groupFormKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              autofocus: true,
              decoration: InputDecoration(
                labelText: "Group name",
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
                      _passwordTextController.text = _expiryDateTime.toString();
                    });
                  });
                }),
          ],
        ));
  }
}
