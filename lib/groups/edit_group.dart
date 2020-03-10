import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditGroup extends StatelessWidget {
  const EditGroup({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 4,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          width: 300.0,
          height: 200.0,
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Text('Edit group',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.headline1.color,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  )),
              EditGroupForm()
            ],
          ),
        ),
      ),
    );
  }
}

class EditGroupForm extends StatefulWidget {
  @override
  EditGroupFormState createState() {
    return EditGroupFormState();
  }
}

class EditGroupFormState extends State<EditGroupForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
                labelText: 'Group name', prefixIcon: Icon(Icons.email)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a group new name';
              }
              return null;
            },
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "dashboard");
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color,
                        decoration: TextDecoration.underline),
                  )),
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')));
                  }
                  Navigator.pushNamed(context, "dashboard");
                },
                textColor: Theme.of(context).textTheme.bodyText1.color,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1.0)),
                child: Text(
                  'Edit group',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
