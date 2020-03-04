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

_passwordFormField(String label, bool showPassword, handleShowHidePassword) => TextFormField(
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: IconButton(
      icon: Icon(Icons.lock),
      onPressed: () {},
    ),
    suffixIcon: IconButton(
      icon: showPassword ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
      onPressed: () => handleShowHidePassword(showPassword),
    ),
  ),
  obscureText: !showPassword,
  validator: (val) => val == null ? "Please enter a password" : "Password is empty",
);

class RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordShown = false;
  bool _passwordConfirmationShown = false;

  void _showHidePassword(bool show) {
    setState(() {
      this._passwordShown = !show;
    });
  }

  void _showHidePasswordConfirmation(bool show) {
    setState(() {
      this._passwordConfirmationShown = !show;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
                labelText: 'Email address', prefixIcon: Icon(Icons.email)),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a email address';
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
          _passwordFormField("Password", this._passwordShown, this._showHidePassword),
          _passwordFormField("Confirm password", this._passwordConfirmationShown, this._showHidePasswordConfirmation),
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
