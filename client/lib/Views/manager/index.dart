import 'package:client/Views/common/error_page.dart';
import 'package:client/public/lang.dart';
import 'package:flutter/material.dart';
import 'package:client/Views/common/menu.dart';

// ignore: must_be_immutable
class Index extends StatefulWidget {
  late String headline;
  Index({super.key, required this.headline});

  @override
  // ignore: no_logic_in_create_state
  State<Index> createState() => IndexState(headline: headline);
}

class IndexState extends State<Index> {
  late String headline;
  IndexState({this.headline = ''});

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
      drawer: Menu().drawer(context, headline: headline),
    );
  }
}
