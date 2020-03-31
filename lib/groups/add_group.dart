import 'package:SCTFPasswordManager/groups/groupform.dart';
import 'package:SCTFPasswordManager/core/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class AddGroupForm extends StatefulWidget {


  _AddGroupFormState createState() => _AddGroupFormState();
}

class _AddGroupFormState extends State<AddGroupForm> {
  final _addGroupFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Group'),
      content: Container(
        width: 400,
        height: 300,
        child: ListView(
          children: <Widget>[
            GroupForm(
                formKey: _addGroupFormKey, group: PasswordGroupModel(), state: "create"),
          ],
        ),
      ),
    );
  }
}