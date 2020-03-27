import 'package:SCTFPasswordManager/core/models.dart';
import 'package:SCTFPasswordManager/groups/groupform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditGroup extends StatefulWidget {
  final PasswordGroupModel group;

  EditGroup({this.group});

  EditGroupFormState createState() => EditGroupFormState();
}

class EditGroupFormState extends State<EditGroup> {
  final editGroupFormKey = GlobalKey<FormState>();

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
            Text("Edit Group", style: Theme.of(context).textTheme.headline3),
            GroupForm(
                groupFormKey: editGroupFormKey),
            ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                  child: Text("Cancel"),
                  color: Theme.of(context).errorColor,
                  onPressed: () {},
                ),
                FlatButton(
                  child: Text("Edit"),
                  color: Theme.of(context).buttonColor,
                  onPressed: () {},
                )
              ],
            )
          ],
        ),
      )
    );
  }
}