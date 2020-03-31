import 'package:SCTFPasswordManager/core/api.dart';
import 'package:SCTFPasswordManager/core/models.dart';
import 'package:SCTFPasswordManager/groups/groupform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditGroup extends StatefulWidget {
  final PasswordGroupModel group;

  EditGroup({this.group});

  _EditGroupState createState() => _EditGroupState();
}

class _EditGroupState extends State<EditGroup> {
  GlobalKey _editGroupFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Group'),
      content: Container(
        width: 400,
        height: 300,
        child: ListView(
          children: <Widget>[
            GroupForm(
                formKey: _editGroupFormKey, group: this.widget.group, state: "update"),
          ],
        ),
      ),
    );
  }
}
