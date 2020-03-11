import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  final String title;
  final IconData iconData;
  final Color iconColor;
  final Function action;

  const ActionButton({Key key, this.iconData, this.title, this.action, this.iconColor})
      : super(key: key);

  _ActionButtonState createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: FlatButton(
        onPressed: () { this.widget.action(context); },
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        hoverColor: Theme.of(context).primaryColor,
        child: Row(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(
              this.widget.iconData,
              color: this.widget.iconColor != null ? this.widget.iconColor : Theme.of(context).iconTheme.color,
            ),
          ),
          Text(this.widget.title, style: Theme.of(context).textTheme.headline6),
        ]),
      ),
    );
  }
}
