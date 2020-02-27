import 'package:flutter/material.dart';

class NavigationButton extends StatefulWidget {
  final String title;
  final IconData iconData;
  final String targetURI;

  const NavigationButton({Key key, this.iconData, this.title, this.targetURI})
      : super(key: key);

  void _navigate() {
    print("Navigation to " + targetURI);
  }

  _NavigationButtonState createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<NavigationButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: FlatButton(
            onPressed: () {},
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            hoverColor: Theme.of(context).primaryColorLight,
            child: Row(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Icon(this.widget.iconData, color: Color(0xFFBEBEBE)),
              ),
              Text(this.widget.title,
                  style: TextStyle(color: Color(0xFFBEBEBE), fontSize: 16))
            ])),
    );
  }
}
