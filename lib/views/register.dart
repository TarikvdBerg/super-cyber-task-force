import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 480,
            height: 500,
            child: Column(
              children: <Widget>[
                Text('Register account',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.headline1.color,
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                    )),
                RegisterForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  RegisterFormState createState() {
    return RegisterFormState();
  }
}

class RegisterFormState extends State<RegisterForm> {
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
                labelText: 'Email adress', prefixIcon: Icon(Icons.email)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a email adress';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
                labelText: 'Username', prefixIcon: Icon(Icons.person)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a username';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
                labelText: 'Password', prefixIcon: Icon(Icons.lock)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a password';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
                labelText: 'Repeat password', prefixIcon: Icon(Icons.lock)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Password not the same';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Create account'),
            ),
          ),
        ],
      ),
    );
  }
}
