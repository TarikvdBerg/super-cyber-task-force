import 'package:SCTFPasswordManager/core/api.dart';
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
  TextEditingController _groupNameController;
  
  String currentGroup;

  @override
  void initState() {
    _groupNameController = TextEditingController(
        text:
            this.widget.group != null ? this.widget.group.name : null);

    if (this.widget.group != null) {
      currentGroup = this.widget.group.name;
    }

    super.initState();
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    API api = Provider.of<API>(context);

    return Form(
      key: this.widget.formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _groupNameController,
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
              this.widget.group.name = value;
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
                  API api = Provider.of<API>(context, listen: false);
                  if (this.widget.state == "update") {
                    api.updateGroup(this.widget.group);
                  } else if (this.widget.state == "create") {
                    api.createGroup(this.widget.group);
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