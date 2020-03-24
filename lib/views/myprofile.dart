import 'package:SCTFPasswordManager/sidebar/sidebar.dart';
import 'package:flutter/material.dart';

final double sizeBetweenEntries = 15;

class MyProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Theme.of(context).primaryColor,
      child: Row(
        children: <Widget>[
          SideBar(userName: "John Doe", eMail: "john.doe@gmail.com"),
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
                            fontSize: 20, decoration: TextDecoration.underline),
                      ),
                      SizedBox(
                        height: sizeBetweenEntries,
                      ),
                      Text(
                        'gayguy18@bigchungus.com',
                        style: TextStyle(
                            fontSize: 20, decoration: TextDecoration.underline),
                      ),
                      SizedBox(
                        height: sizeBetweenEntries,
                      ),
                      Text(
                        '***********',
                        style: TextStyle(
                            fontSize: 20, decoration: TextDecoration.underline),
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
                      Navigator.pushNamed(context, "editProfile");
                    },
                    child: Text('Edit'),
                  )
                ],
              )
            ],
          )),
        ],
      ),
    ));
  }
}
