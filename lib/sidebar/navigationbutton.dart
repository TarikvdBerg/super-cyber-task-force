import 'package:flutter/material.dart';

class NavigationButton extends StatefulWidget {
  final String title;
  final IconData iconData;
  final Function pressedAction;

  const NavigationButton({Key key, this.iconData, this.title, this.pressedAction})
      : super(key: key);

  _NavigationButtonState createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<NavigationButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: FlatButton(
        onPressed: this.widget.pressedAction,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        hoverColor: Theme.of(context).primaryColor,
        child: Row(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(this.widget.iconData,
                color: Theme.of(context).iconTheme.color),
          ),
          Text(this.widget.title, style: Theme.of(context).textTheme.headline6),
        ]),
      ),
    );
  }
}
