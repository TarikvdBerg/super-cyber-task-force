import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RemoveGroup extends StatelessWidget {
  const RemoveGroup({
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
          height: 180.0,
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Text('Remove group',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.headline1.color,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  )),
              RemoveGroupForm()
            ],
          ),
        ),
      ),
    );
  }
}

class RemoveGroupForm extends StatefulWidget {
  @override
  RemoveGroupFormState createState() {
    return RemoveGroupFormState();
  }
}

class RemoveGroupFormState extends State<RemoveGroupForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
              'Are you sure you want to delete <group> and all the passwords inside?'),
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
                  'Confirm',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
