import 'package:client/public/lang.dart';
import 'package:flutter/material.dart';

dynamic showAlertDialog(BuildContext context, [String memo = '']) {
  var lang = Lang();
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(memo),
          title: Text(lang.title),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(lang.cancel),
            ),
          ],
        );
      });
}
