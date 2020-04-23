import 'dart:async';

import 'package:SCTFPasswordManager/core/cache.dart';
import 'package:SCTFPasswordManager/core/encryption.dart';
import 'package:SCTFPasswordManager/core/exceptions.dart';
import 'package:SCTFPasswordManager/core/models.dart';
import 'package:SCTFPasswordManager/core/tools.dart';
import 'package:SCTFPasswordManager/passwords/password.dart';
import 'package:SCTFPasswordManager/groups/edit_group.dart';
import 'package:flutter/gestures.dart';
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
  GlobalKey _actionKey = GlobalKey();
  OverlayEntry pwOverlay;

  void showGroupDeleteDialog(BuildContext context, PasswordGroupModel group) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete group"),
          content: const Text(
              "Are you sure you want to delete this password group?"),
          actions: <Widget>[
            FlatButton(
              child: const Text("Delete"),
              onPressed: () async {
                Cache api = Provider.of<Cache>(context, listen: false);
                try {
                  bool res = await api.deleteGroup(group);
                  if (res) {
                    Navigator.pop(context);
                    return null;
                  }
                } on ModelDoesNotExistException {
                  return;
                } on BadRequestException {
                  showSnackbar(
                      "Something went wrong, please refresh your application and try again.",
                      context);
                } on ServerErrorException {
                  showSnackbar(
                      "The server encountered an error while deleting the group, please try again later.",
                      context);
                } on TimeoutException {
                  showSnackbar(
                      "The server took too long to respond, please try again later.",
                      context);
                }
              },
            ),
            FlatButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void showGroupEditDialog(BuildContext context, PasswordGroupModel group) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return EditGroup(group: group);
      },
    );
  }

  showOverlay(BuildContext context, PasswordGroupModel group) async {
    final RenderBox renderBoxRed = _actionKey.currentContext.findRenderObject();
    final pos = renderBoxRed.localToGlobal(Offset.zero);

    OverlayState overlayState = Overlay.of(context);
    pwOverlay = OverlayEntry(
        builder: (context) => Positioned(
            left: pos.dx,
            top: pos.dy,
            child: MouseRegion(
              onExit: (PointerExitEvent p) {
                pwOverlay.remove();
              },
              child: Container(
                color: Theme.of(context).primaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FlatButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        onPressed: () {
                          pwOverlay.remove();
                          showGroupEditDialog(context, group);
                        },
                        hoverColor: Theme.of(context).buttonColor,
                        color: Theme.of(context).primaryColor,
                        child: Row(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.edit,
                                color: Theme.of(context).iconTheme.color),
                          ),
                          Text("Edit Group"),
                        ])),
                    FlatButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        onPressed: () {
                          pwOverlay.remove();
                          showGroupDeleteDialog(
                              context, this.widget.passwordGroup);
                        },
                        hoverColor: Theme.of(context).buttonColor,
                        child: Row(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.delete,
                                color: Theme.of(context).iconTheme.color),
                          ),
                          Text("Delete group"),
                        ])),
                  ],
                ),
              ),
            )));

    overlayState.insert(pwOverlay);
  }

  @override
  Widget build(BuildContext context) {
    Cache api = Provider.of<Cache>(context);
    EncryptionManager encryptor = Provider.of<EncryptionManager>(context);

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
                child: Stack(children: <Widget>[
                  Text(
                    encryptor.decrypt(this.widget.passwordGroup.name),
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Column(
                    children: <Widget>[
                      Align(
                          alignment: Alignment(0.97, -0.9),
                          child: IconButton(
                              padding: EdgeInsets.all(0),
                              key: _actionKey,
                              icon: Icon(Icons.more_vert),
                              color: Theme.of(context).iconTheme.color,
                              tooltip: "More Actions",
                              onPressed: () {
                                showOverlay(context, this.widget.passwordGroup);
                              }))
                    ],
                  )
                ]),
              );
            },
            body: Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: FutureBuilder(
                future: api.fetchAllPasswords(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<PasswordModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    if (snapshot.error is RequestNotAuthenticatedException) {
                      showSnackbar(
                          "The current authentication informaion is invalid. Please logout and log back in.",
                          context);
                    }
                    if (snapshot.error is ServerErrorException) {
                      showSnackbar(
                          "The server encountered an error while retrieving information. Please try again later.",
                          context);
                    }
                    if (snapshot.error is TimeoutException) {
                      showSnackbar(
                          "The server took too long to respond. Please try again later.",
                          context);
                    }
                    return Container();
                  }

                  List<Password> pwList = [];
                  snapshot.data.forEach((element) {
                    if (element.group == this.widget.passwordGroup.id) {
                      pwList.add(Password(model: element));
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
          ),
        ],
      ),
    );
  }
}
