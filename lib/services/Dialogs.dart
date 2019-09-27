import 'package:flutter/material.dart';


class Dialogs{

  _confirmResult(bool isYes, BuildContext context) {
    if (isYes) {
    } else {}
  }

  confirm(BuildContext context, String title, String description) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text(description)],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => _confirmResult(false,context),
              child: Text('Cancel'),
            ),
            FlatButton(
              onPressed: () => _confirmResult(true, context),
              child: Text('Accept'),
            ),
          ],
        );
      },
    );
  }

}