import 'package:SCTFPasswordManager/passwords/password.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PasswordGroup extends StatefulWidget {
  final List<Password> passwordList;
  final String groupName;
  bool isExpanded = true;

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
        color: Theme.of(context).primaryColorDark,
        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: ExpansionPanelList(
          animationDuration: Duration(milliseconds: 300),
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              this.widget.isExpanded = !isExpanded;
            });
          },
          children: <ExpansionPanel>[
            ExpansionPanel(
                canTapOnHeader: true,
                isExpanded: this.widget.isExpanded,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Container(
                      margin: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        this.widget.groupName,
                        style: Theme.of(context).textTheme.headline5,
                      ));
                },
                body: Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Wrap(
                      spacing: 15,
                      runSpacing: 20,
                      children: this.widget.passwordList),
                ))
          ],
        ));
  }
}
