import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginForm,
      child: Column(
        children: <Widget>[
<<<<<<< HEAD
          TextFormField(
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
                    'create account',
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
                onPressed: () {
                  if (_loginForm.currentState.validate()) {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Loging to firstpass')));
                  }
                  Navigator.pushNamed(context, "dashboard");
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
=======
          FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, "dashboard");
              },
              child: Text("Go To Dash")),
          FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, "register");
              },
              child: Text("Go To Register Page")),
          FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, "dbg");
              },
              child: Text("Go To Debug Page")),
>>>>>>> feature/api
        ],
      ),
    );
  }
}

//class LoginView extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return
//      ButtonBar(
//      alignment: MainAxisAlignment.center,
//      children: <Widget>[
//        FlatButton(
//          onPressed: () {},
//          child: Text (
//            'create account',
//            style: TextStyle(color: Theme.of(context).textTheme.bodyText1.color, decoration: TextDecoration.underline),
//          )
//          ),
//      RaisedButton(
//         onPressed: () {},
//         textColor: Theme.of(context).textTheme.bodyText1.color,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
//         child: Text(
//           'Login',
//         ),
//        ),
//      ],
//    );
//  }
//}
