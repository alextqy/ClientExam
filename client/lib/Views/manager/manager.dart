import 'package:flutter/material.dart';
import 'package:client/public/lang.dart';
import 'package:client/Views/common/menu.dart';

// ignore: must_be_immutable
class Manager extends StatefulWidget {
  late String headline;
  Manager({super.key, required this.headline});

  @override
  // ignore: no_logic_in_create_state
  State<Manager> createState() => ManagerState(headline: headline);
}

class ManagerState extends State<Manager> {
  late String headline;
  ManagerState({this.headline = ''});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Lang().managers),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.all(0),
        color: Colors.grey,
      ),
      drawer: Menu().drawer(context, headline: headline),
    );
  }
}
