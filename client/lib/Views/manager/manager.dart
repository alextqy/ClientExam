import 'package:flutter/material.dart';
import 'package:client/public/lang.dart';
import 'package:client/Views/common/menu.dart';
import 'package:client/models/route_args.dart';

class Manager extends StatefulWidget {
  const Manager({super.key, dynamic routeArgs});

  @override
  // ignore: no_logic_in_create_state
  State<Manager> createState() => ManagerState(args: routeArgs);
}

class ManagerState extends State<Manager> {
  var lang = Lang();
  var common = Common();
  final args = routeArgs;
  ManagerState({args});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.managers),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.all(0),
        color: Colors.grey,
      ),
      drawer: common.drawer(context, headline: args['headline']),
    );
  }
}
