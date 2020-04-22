import 'package:SCTFPasswordManager/core/tools.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({
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
                Text('Reset password',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.headline1.color,
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                    )),
                SizedBox(height: 20),
                Text('Please enter your email, if the email is correct you\'ll receive an e-mail shortly',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.headline2.color,
                    fontSize: 20,
                  )
                ),
                SizedBox(height: 20),
                PasswordResetForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordResetForm extends StatefulWidget {
  @override
  PasswordResetFormState createState() {
    return PasswordResetFormState();
  }
}

class PasswordResetFormState extends State<PasswordResetForm> {
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
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                  onPressed: () {Navigator.pop(context);},
                  child: Text(
                    'Back to login',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color,
                        decoration: TextDecoration.underline),
                  )),

              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    showSnackbar('Password is being reset. Please check your email inbox.', context);
                  }
                  Navigator.pop(context);
                },
                textColor: Theme.of(context).textTheme.bodyText1.color,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1.0)),
                child: Text(
                  'Reset Password',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
