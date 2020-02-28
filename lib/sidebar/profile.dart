import 'package:flutter/material.dart';

class SideBarProfile extends StatefulWidget {
  final String userName;
  final String eMail;

  const SideBarProfile({
    Key key,
    this.userName,
    this.eMail,
  }) : super(key: key);

  _SideBarProfileState createState() => _SideBarProfileState();
}

class _SideBarProfileState extends State<SideBarProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20, bottom: 15, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(this.widget.userName,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                )),
            Text(this.widget.eMail,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                  fontSize: 12
                )),
          ],
        )
      );
  }
}
