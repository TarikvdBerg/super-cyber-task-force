import 'package:SCTFPasswordManager/core/api.dart';
import 'package:SCTFPasswordManager/core/models.dart';
import 'package:SCTFPasswordManager/groups/edit_group.dart';
import 'package:SCTFPasswordManager/groups/add_group.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Group extends StatefulWidget {
  final PasswordGroupModel model;

  Group({
    Key key,
    this.model
  }) : super(key: key);

  _GroupState createState() => _GroupState();
}

class _GroupState extends State<Group> {
  bool _hovered = false;
  GlobalKey _actionKey = GlobalKey();
  OverlayEntry pwOverlay;

  void setHover(bool state) {
    setState(() {
      this._hovered = state;
    });
  }

  void showGroupDeleteDialog(BuildContext context, PasswordGroupModel group) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete group"),
          content: const Text("Are you sure you want to remove this password group?"),
          actions: <Widget>[
            FlatButton(
              child: const Text("Delete"),
              onPressed: () async {
                API api = Provider.of<API>(context, listen: false);
                bool res = await api.deleteGroup(group);
                if (res) {
                  Navigator.pop(context);
                  return null;
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

  void showGroupAddDialog(BuildContext context, PasswordGroupModel group) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AddGroupForm();
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
                          showGroupAddDialog(context, group);
                        },
                        hoverColor: Theme.of(context).buttonColor,
                        color: Theme.of(context).primaryColor,
                        child: Row(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(Icons.edit,
                                color: Theme.of(context).iconTheme.color),
                          ),
                          Text("Add Group"),
                        ])),
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
                          showGroupDeleteDialog(context, this.widget.model);
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
                  Text(
                    this.widget.model.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
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