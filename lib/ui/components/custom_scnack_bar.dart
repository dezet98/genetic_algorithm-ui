import 'package:flutter/material.dart';

class CustomSnackBar {
  static simpleShow(
      BuildContext context, String contentText, String actionLabel) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(contentText),
        action: SnackBarAction(
          label: actionLabel,
          onPressed: () {
            // TODO
          },
        ),
      ),
    );
  }
}
