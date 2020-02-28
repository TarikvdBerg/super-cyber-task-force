import 'package:flutter/material.dart';

class Password extends StatefulWidget {
  final String encPassword;
  final String name;
  final String userName;
  final String description;
  final String imgURL;

  Password({
    Key key,
    this.encPassword,
    this.name,
    this.userName,
    this.description,
    this.imgURL,
  }) : super(key: key);

  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 250,
        height: 150,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Image.network(this.widget.imgURL, height: 100),
                Text(this.widget.name),
                Text(this.widget.userName),
              ],
            ),
            Column(
              children: <Widget>[
                Align(
                    alignment: Alignment(0.97, -0.9),
                    child: IconButton(
                        icon: Icon(Icons.more_vert),
                        color: Theme.of(context).iconTheme.color,
                        tooltip: "More Actions",
                        onPressed: () {
                          print("Ïmplement me");
                        }))
              ],
            )
          ],
        ));
  }
}
