import 'package:flutter/material.dart';

// Shows a snackbar in the provided context with the provided message.
// By default the snackbar is dismissable but this can be disabled by
// providing dismiss: false;
void showSnackbar(String message, BuildContext context, {dismiss: true}) {
  dismiss == true
      ? Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(message),
          action: SnackBarAction(
            label: "X",
            onPressed: () {
              Scaffold.of(context).hideCurrentSnackBar();
            },
          ),
        ))
      : Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
}
