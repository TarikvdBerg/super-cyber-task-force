import 'package:SCTFPasswordManager/core/models.dart';
import 'package:flutter/material.dart';

class SideBarProfile extends StatefulWidget {
  final UserModel model;

  const SideBarProfile({
    Key key,
    this.model,
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
            Text(this.widget.model.displayName,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                )),
            Text(this.widget.model.eMail,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                  fontSize: 12
                )),
          ],
        )
      );
  }
}
