import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Register page',
      theme: ThemeData(
            primaryColorDark: Color(0xFF131313),
            primaryColor: Color(0xFF212121),
            primaryColorLight: Color(0xFF484848),
            dividerColor: Color(0xBEBEBEBE),
            buttonColor: Color(0xFF008B7A),
            iconTheme: IconThemeData(color: Color(0xFFBEBEBE)),
            textTheme: TextTheme(
              headline1: TextStyle(color: Color(0XFFBEBEBE)),
              headline2: TextStyle(color: Color(0XFFBEBEBE)),
              headline3: TextStyle(color: Color(0XFFBEBEBE)),
              headline4: TextStyle(color: Color(0XFFBEBEBE)),
              headline5: TextStyle(color: Color(0XFFBEBEBE)),
              headline6: TextStyle(color: Color(0XFFBEBEBE)),
              bodyText1: TextStyle(color: Color(0XFFBEBEBE)),
              bodyText2: TextStyle(color: Color(0XFFBEBEBE)),
            )),
      home: Scaffold(
        body: Container(
          width: 460,
          color: Theme.of(context).primaryColorDark,
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
          )
        )
      )
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  RegisterFormState createState(){
    return RegisterFormState();
  }
}

class RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Email adress'
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a email adress';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Username'
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a username';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Password'
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a password';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Repeat password'
            ),
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
                if (_formKey.currentState.validate()){
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
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

