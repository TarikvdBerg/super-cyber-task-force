import 'package:SCTFPasswordManager/core/api.dart';
import 'package:SCTFPasswordManager/core/models.dart';
import 'package:SCTFPasswordManager/sidebar/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final double sizeBetweenEntries = 15;

class EditProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    API api = Provider.of<API>(context);

    return FutureBuilder(
        future: api.fetchUser("12622302-864a-4b4b-a024-3f0a0586b025"),
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          return Scaffold(
              body: Container(
            color: Theme.of(context).primaryColor,
            child: Row(
              children: <Widget>[
                SideBar(model: snapshot.data),
                SizedBox(width: 10),
                Container(
                    color: Colors.pink,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'My Account',
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.person, size: 200),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'First name',
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: sizeBetweenEntries,
                                ),
                                Text(
                                  'Last name',
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: sizeBetweenEntries,
                                ),
                                Text(
                                  'Email',
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: sizeBetweenEntries,
                                ),
                                Text(
                                  'Password',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Niels',
                                    style: TextStyle(
                                        fontSize: 20,
                                        decoration: TextDecoration.underline)),
                                SizedBox(
                                  height: sizeBetweenEntries,
                                ),
                                Text(
                                  'Marion',
                                  style: TextStyle(
                                      fontSize: 20,
                                      decoration: TextDecoration.underline),
                                ),
                                SizedBox(
                                  height: sizeBetweenEntries,
                                ),
                                Text(
                                  'gayguy18@bigchungus.com',
                                  style: TextStyle(
                                      fontSize: 20,
                                      decoration: TextDecoration.underline),
                                ),
                                SizedBox(
                                  height: sizeBetweenEntries,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, "MyAccount");
                                },
                                child: Text(
                                  'Back my Account',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .color,
                                      decoration: TextDecoration.underline),
                                )),
                            RaisedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "editProfile");
                              },
                              child: Text('save'),
                            )
                          ],
                        )
                      ],
                    )),
              ],
            ),
          ));
        });
  }
}
