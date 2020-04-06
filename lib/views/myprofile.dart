import 'package:SCTFPasswordManager/core/api.dart';
import 'package:SCTFPasswordManager/core/models.dart';
import 'package:SCTFPasswordManager/sidebar/sidebar.dart';
import 'package:SCTFPasswordManager/views/editprofile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final double sizeBetweenEntries = 15;

class MyProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    API api = Provider.of<API>(context);

    return FutureBuilder(
      future: api.fetchUser(),
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
                          ],
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(snapshot.data.firstName,
                                style: TextStyle(
                                    fontSize: 20,
                                    decoration: TextDecoration.underline)),
                            SizedBox(
                              height: sizeBetweenEntries,
                            ),
                            Text(
                              snapshot.data.lastName,
                              style: TextStyle(
                                  fontSize: 20,
                                  decoration: TextDecoration.underline),
                            ),
                            SizedBox(
                              height: sizeBetweenEntries,
                            ),
                            Text(
                              snapshot.data.eMail,
                              style: TextStyle(
                                  fontSize: 20,
                                  decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                child: EditProfileView(model: snapshot.data));
                          },
                          child: Text('Edit'),
                        )
                      ],
                    )
                  ],
                )),
              ],
            ),
          ),
        );
      },
    );
  }
}
