import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:SCTFPasswordManager/core/hashing.dart';
import 'package:SCTFPasswordManager/core/api.dart';
import 'package:provider/provider.dart';
import 'package:SCTFPasswordManager/core/cache.dart';

class LoginView extends StatelessWidget {
  const LoginView({
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
                Text('Login to SCTF Password manager',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.headline1.color,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    )),
                LoginForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _loginForm = GlobalKey<FormState>();

  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Cache api = Provider.of<Cache>(context);

    return Form(
      key: _loginForm,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
              decoration: const InputDecoration(
                icon: Icon(Icons.person_outline),
                labelText: 'Username',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter your username";
                }
                return null;
              }),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscureText,
            decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'Password',
                suffixIcon: IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: this._toggle)),
            validator: (value) {
              if (value.isEmpty) {
                return "Please enter your password";
              }
              return null;
            },
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "register");
                  },
                  child: Text(
                    'Create account',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color,
                        decoration: TextDecoration.underline),
                  )),
              FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "resetpassword");
                  },
                  child: Text('Reset password', style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    decoration: TextDecoration.underline),

                  )),
              RaisedButton(
                onPressed: () async {
                  if (_loginForm.currentState.validate()) {

                    var hashedpassword = pbkdf12(_usernameController.text, _passwordController.text);
                    try {
                      print(_usernameController.text + _passwordController.text);

                      var api_return = await api.authenticate(_usernameController.text, _passwordController.text);
                      Navigator.pushNamed(context, "dashboard");
                      _loginForm.currentState.reset();
                      _usernameController.clear();
                      _passwordController.clear();



                    }
                    catch (e){
                      print(_usernameController.text + _passwordController.text);

                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Username or password was incorrect')));
                      _loginForm.currentState.reset();
                      _usernameController.clear();
                      _passwordController.clear();
                    }
                  }

                },
                textColor: Theme.of(context).textTheme.bodyText1.color,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1.0)),
                child: Text(
                  'Login',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
