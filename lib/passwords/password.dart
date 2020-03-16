import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Password extends StatefulWidget {
  final String encPassword;
  final String name;
  final String userName;
  final String description;
  final String imgURL;

  Password({
    Key key,
    this.encPassword,
    this.name,
    this.userName,
    this.description,
    this.imgURL,
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

  showOverlay(BuildContext context) async {
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
                  children: <Widget>[
                    FlatButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        onPressed: () {
                          print("Copy Password");
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
                          print("Edit Password");
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
                          print("Delete Password");
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
                  Image.network(this.widget.imgURL, height: 100),
                  Text(
                    this.widget.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(this.widget.userName),
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
                            showOverlay(context);
                          }))
                ],
              )
            ],
          )),
    );
  }
}
