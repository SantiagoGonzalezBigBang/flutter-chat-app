import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

showCustomDialog({
  required BuildContext context,
  required String title,
  required String subtitle,
}) async {

  if (Platform.isAndroid) {
    return showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(subtitle),
        actions: [
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            elevation: 5.0,
            textColor: Colors.blue,
            child: const Text('Ok'),
          )
        ],
      )
    );
  } else {
    return showCupertinoDialog(
      context: context, 
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(subtitle),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Ok'),
            onPressed: () => Navigator.pop(context),
          )
        ],
      )
    );
  }
}