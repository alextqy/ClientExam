import 'package:client/public/lang.dart';
import 'package:flutter/material.dart';

var futureTest = Future.delayed(const Duration(seconds: 3), () {
  return 'this is data';
});

errorPage() {
  var lang = Lang();
  Container(
    width: double.infinity,
    height: double.infinity,
    padding: const EdgeInsets.all(0),
    margin: const EdgeInsets.all(0),
    color: Colors.grey,
    child: Center(
      child: Text(
        lang.theRequestFailed,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
      ),
    ),
  );
}
