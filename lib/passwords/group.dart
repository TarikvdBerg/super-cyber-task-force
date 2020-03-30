import 'package:SCTFPasswordManager/core/api.dart';
import 'package:SCTFPasswordManager/core/models.dart';
import 'package:SCTFPasswordManager/passwords/password.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class PasswordGroup extends StatefulWidget {
  final List<Password> passwordList;
  final PasswordGroupModel passwordGroup;

  PasswordGroup({Key key, this.passwordList, this.passwordGroup})
      : super(key: key);

  _PasswordGroupState createState() => _PasswordGroupState();
}

class _PasswordGroupState extends State<PasswordGroup> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    API api = Provider.of<API>(context);

    return Container(
      color: Theme.of(context).primaryColorDark,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: ExpansionPanelList(
        animationDuration: Duration(milliseconds: 300),
        expansionCallback: (int index, bool isExpanded) {
          setState(
            () {
              this.isExpanded = !this.isExpanded;
            },
          );
        },
        children: <ExpansionPanel>[
          ExpansionPanel(
            canTapOnHeader: true,
            isExpanded: isExpanded,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return Container(
                margin: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  this.widget.passwordGroup.name,
                  style: Theme.of(context).textTheme.headline5,
                ),
              );
            },
            body: Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: FutureBuilder(
                future: api.fetchAllPasswords(),
                builder: (BuildContext context, AsyncSnapshot<List<PasswordModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return SnackBar(content: Text(snapshot.error));
                  }

                  List<Password> pwList = []; 
                  snapshot.data.forEach((element) {
                    if (element.group == this.widget.passwordGroup.id) {
                      pwList.add(
                        Password(model: element)
                      );
                    }
                  });

                  return Wrap(
                    spacing: 15,
                    runSpacing: 20,
                    children: pwList,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
