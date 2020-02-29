import 'package:SCTFPasswordManager/passwords/password.dart';
import 'package:flutter/material.dart';

class PasswordGroup extends StatefulWidget {
  final List<Password> passwordList;
  final String groupName;

  PasswordGroup({
    Key key,
    this.passwordList,
    this.groupName,
  }) : super(key: key);

  _PasswordGroupState createState() => _PasswordGroupState();
}

class _PasswordGroupState extends State<PasswordGroup> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(this.widget.groupName, style: Theme.of(context).textTheme.headline4,),
                  IconButton(
                      icon: Icon(Icons.keyboard_arrow_down),
                      onPressed: () {
                        print("Cool");
                      })
                ],
              ),
              Divider(
                color: Color(0xFFBEBEBE),
                thickness: 8,
                height: 8,
              )
            ],
          ),
          Container(
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width - 300,
            child: Wrap(
              spacing: 15,
              runSpacing: 20,
              children: <Widget>[
                Password(
                  userName: "User1",
                  encPassword: "TSE",
                  description: "Test",
                  imgURL:
                      "https://cdn1.iconfinder.com/data/icons/logotypes/32/youtube-512.png",
                  name: "Youtube",
                ),
                Password(
                  userName: "User1",
                  encPassword: "TSE",
                  description: "Test",
                  imgURL:
                      "https://cdn1.iconfinder.com/data/icons/logotypes/32/youtube-512.png",
                  name: "Youtube",
                ),
                Password(
                  userName: "User1",
                  encPassword: "TSE",
                  description: "Test",
                  imgURL:
                      "https://cdn1.iconfinder.com/data/icons/logotypes/32/youtube-512.png",
                  name: "Youtube",
                ),
                Password(
                  userName: "User1",
                  encPassword: "TSE",
                  description: "Test",
                  imgURL:
                      "https://cdn1.iconfinder.com/data/icons/logotypes/32/youtube-512.png",
                  name: "Youtube",
                ),
                Password(
                  userName: "User1",
                  encPassword: "TSE",
                  description: "Test",
                  imgURL:
                      "https://cdn1.iconfinder.com/data/icons/logotypes/32/youtube-512.png",
                  name: "Youtube",
                ),
                Password(
                  userName: "User1",
                  encPassword: "TSE",
                  description: "Test",
                  imgURL:
                      "https://cdn1.iconfinder.com/data/icons/logotypes/32/youtube-512.png",
                  name: "Youtube",
                ),
                Password(
                  userName: "User1",
                  encPassword: "TSE",
                  description: "Test",
                  imgURL:
                      "https://cdn1.iconfinder.com/data/icons/logotypes/32/youtube-512.png",
                  name: "Youtube",
                ),
              ],
            ),
          )
        ],
      );
  }
}
