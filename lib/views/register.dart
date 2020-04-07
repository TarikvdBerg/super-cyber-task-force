import 'package:SCTFPasswordManager/core/cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:SCTFPasswordManager/core/models.dart';
import 'package:SCTFPasswordManager/core/api.dart';
import 'package:provider/provider.dart';

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
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _passwordCheckController = TextEditingController();

  // Initially password is obscure
  bool _obscureTextPass = true;

  // Toggles the password show status
  void _togglePass() {
    setState(() {
      _obscureTextPass = !_obscureTextPass;
    });
  }

  bool _obscureTextCheck = true;

  // Toggles the password show status
  void _toggleCheck() {
    setState(() {
      _obscureTextCheck = !_obscureTextCheck;
    });
  }

  @override
  Widget build(BuildContext context) {
    Cache api = Provider.of<Cache>(context);
    return Form(
        key: _formKey,
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextFormField(
                controller: _firstnameController,
                decoration: const InputDecoration(
                    labelText: 'First Name', prefixIcon: Icon(Icons.hot_tub)),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastnameController,
                decoration: const InputDecoration(
                    labelText: 'Last name', prefixIcon: Icon(Icons.hot_tub)),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
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
                controller: _usernameController,
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
                controller: _passwordCheckController,
                obscureText: _obscureTextPass,
                decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                        icon: Icon(_obscureTextPass
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: this._togglePass)),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              TextFormField(
                obscureText: _obscureTextCheck,
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Repeat password',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                      icon: Icon(_obscureTextCheck
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: this._toggleCheck),
                ),
                validator: (value) {
                  if (value.isEmpty) return 'Please repeat the password';
                  if (value != _passwordCheckController.text)
                    return 'Password don\'t match';
                  return null;
                },
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Back to login',
                        style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1.color,
                            decoration: TextDecoration.underline),
                      )),
                  RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data')));
                        UserModel u = UserModel(userName: _usernameController.text,
                          eMail: _emailController.text, firstName: _firstnameController.text,
                          lastName: _lastnameController.text
                        );
                        api.createUser(u, _passwordController.text).catchError((error) => print(error.errorMessage()));
                      }
                      // Navigator.pushNamed(context, "login");
                    },
                    textColor: Theme.of(context).textTheme.bodyText1.color,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1.0)),
                    child: Text(
                      'Create account',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
