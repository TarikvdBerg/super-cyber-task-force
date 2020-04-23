import 'dart:async';

import 'package:SCTFPasswordManager/core/cache.dart';
import 'package:SCTFPasswordManager/core/encryption.dart';
import 'package:SCTFPasswordManager/core/exceptions.dart';
import 'package:SCTFPasswordManager/core/models.dart';
import 'package:SCTFPasswordManager/core/tools.dart';
import 'package:SCTFPasswordManager/passwords/edit_password.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Password extends StatefulWidget {
  final PasswordModel model;

  Password({
    Key key,
    this.model
  }) : super(key: key);

  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  bool _hovered = false;
  GlobalKey _actionKey = GlobalKey();
  OverlayEntry pwOverlay;

  void setHover(bool state) {
    setState(() {
      this._hovered = state;
    });
  }

  void showPasswordDeleteDialog(BuildContext context, PasswordModel password) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete password"),
          content: const Text("Are you sure you want to remove this password?"),
          actions: <Widget>[
            FlatButton(
              child: const Text("Delete"),
              onPressed: () async {
                Cache api = Provider.of<Cache>(context, listen: false);
                try {
                  bool res = await api.deletePassword(password);
                  if (res) {
                    Navigator.pop(context);
                    return null;
                  }
                }
                on ModelDoesNotExistException {
                  showSnackbar("The entry you are trying to delete doesn't exist, refresh the application to get an up to date version of your information.", context);
                }
                on BadRequestException {
                  showSnackbar("Something went wrong while deleting the entry. Please try again later", context);
                }
                on ServerErrorException {
                  showSnackbar("The server encountered an error while processing your request. Please try again later.", context);
                }
                on TimeoutException {
                  showSnackbar("The server took too long to respond. Please try again later.", context);
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

  void showPasswordEditDialog(BuildContext context, PasswordModel password) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return EditSinglePassword(password: password);
      },
    );
  }

  showOverlay(BuildContext context, PasswordModel password) async {
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
                          // Copies the de-encrypted password to the clipboard.
                          pwOverlay.remove();
                        },
                        hoverColor: Theme.of(context).buttonColor,
                        child: Row(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.content_copy,
                                color: Theme.of(context).iconTheme.color),
                          ),
                          Text("Copy Password"),
                        ])),
                    FlatButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        onPressed: () {
                          pwOverlay.remove();
                          showPasswordEditDialog(context, password);
                        },
                        hoverColor: Theme.of(context).buttonColor,
                        color: Theme.of(context).primaryColor,
                        child: Row(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.edit,
                                color: Theme.of(context).iconTheme.color),
                          ),
                          Text("Edit Password"),
                        ])),
                    FlatButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        onPressed: () {
                          pwOverlay.remove();
                          showPasswordDeleteDialog(context, this.widget.model);
                        },
                        hoverColor: Theme.of(context).buttonColor,
                        child: Row(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.delete,
                                color: Theme.of(context).iconTheme.color),
                          ),
                          Text("Delete Password"),
                        ])),
                  ],
                ),
              ),
            )));

    overlayState.insert(pwOverlay);
  }

  @override
  Widget build(BuildContext context) {
    EncryptionManager encryptor = Provider.of<EncryptionManager>(context);

    return MouseRegion(
      onEnter: (PointerEnterEvent p) {
        setHover(true);
      },
      onExit: (PointerExitEvent p) {
        setHover(false);
      },
      child: Container(
          width: 250,
          height: 150,
          decoration: BoxDecoration(
              color: _hovered
                  ? Theme.of(context).buttonColor
                  : Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Image.network(this.widget.model.imgURL, height: 100),
                  Text(
                    encryptor.decrypt(this.widget.model.encName),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(encryptor.decrypt(this.widget.model.encUsername)),
                ],
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
                            showOverlay(context, this.widget.model);
                          }))
                ],
              )
            ],
          )),
    );
  }
}
