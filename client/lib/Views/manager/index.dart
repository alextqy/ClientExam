import 'package:client/Views/common/error_page.dart';
import 'package:client/public/lang.dart';
import 'package:flutter/material.dart';
import 'package:client/Views/common/menu.dart';
import 'package:client/models/route_args.dart';

class Index extends StatefulWidget {
  const Index({super.key, dynamic routeArgs});

  @override
  // ignore: no_logic_in_create_state
  State<Index> createState() => IndexState(args: routeArgs);
}

class IndexState extends State<Index> {
  var args = routeArgs;
  IndexState({args});

  mainWidget(BuildContext context, {dynamic data}) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.all(0),
      color: Colors.grey,
      child: Center(
        child: Text(
          data,
          style: const TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Lang().menu)),
      body: FutureBuilder(
        future: futureTest,
        builder: (context, snapshot) {
          Widget widget;
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              widget = errorPage();
            } else {
              widget = mainWidget(context, data: snapshot.data);
            }
          } else {
            widget = const Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            );
          }
          return Center(child: widget);
        },
      ),
      drawer: Menu().drawer(context, headline: args['headline']),
    );
  }
}
