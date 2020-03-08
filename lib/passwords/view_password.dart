import 'package:SCTFPasswordManager/core/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditSinglePassword extends StatefulWidget {
  final PasswordModel password;

  EditSinglePassword({this.password});

  _EditSinglePasswordState createState() => _EditSinglePasswordState();
}

class _EditSinglePasswordState extends State<EditSinglePassword> {
  DateTime _expiryDateTime;

  final _editPasswordFormKey = GlobalKey<FormState>();
  TextEditingController _editPasswordTextController = TextEditingController();

  void groupChanged(dynamic inp) {
    // TODO: Implement me
    print("Password Group Changed");
  }

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
            Form(
                key: _editPasswordFormKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: this.widget.password.encName,
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: "Password Name",
                      ),
                    ),
                    TextFormField(
                      initialValue: this.widget.password.encDescription,
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: "Password Description",
                      ),
                    ),
                    TextFormField(
                      initialValue: this.widget.password.encPassword,
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                      ),
                    ),
                    TextFormField(
                      initialValue: this.widget.password.encPassword,
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: "Repeat Password",
                      ),
                    ),
                    TextFormField(
                        readOnly: true,
                        controller: _editPasswordTextController,
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
                              _editPasswordTextController.text =
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
                )),
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
