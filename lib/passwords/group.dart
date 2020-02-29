import 'package:SCTFPasswordManager/passwords/password.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      // width: 700,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(this.widget.groupName,
                  style: Theme.of(context).textTheme.headline5),
              Spacer(),
              IconButton(
                  icon: Icon(Icons.keyboard_arrow_down),
                  tooltip: "Collapse/Uncollapse Group",
                  onPressed: () {})
            ],
          ),
          Divider(color: Theme.of(context).dividerColor),
          Wrap(
            spacing: 15,
            runSpacing: 20,
            children: this.widget.passwordList
          ),
        ],
      ),
    );
  }
}
