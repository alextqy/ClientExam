import 'package:client/public/lang.dart';
import 'package:flutter/material.dart';
import 'package:client/Views/common/menu.dart';
import 'package:client/models/route_args.dart';

class Index extends StatefulWidget {
  const Index({super.key, routeArgs});

  @override
  // ignore: no_logic_in_create_state
  State<Index> createState() => IndexState(args: routeArgs);
}

class IndexState extends State<Index> {
  var args = routeArgs;
  IndexState({args});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Lang().menu),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.all(0),
        color: Colors.grey,
      ),
      drawer: Menu().drawer(context, headline: args['headline']),
    );
  }
}
