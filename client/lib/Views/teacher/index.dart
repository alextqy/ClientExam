import 'package:client/public/lang.dart';
import 'package:flutter/material.dart';
import 'package:client/Views/common/menu.dart';

class Index extends StatefulWidget {
  final String headline;
  const Index({super.key, this.headline = ''});

  @override
  State<Index> createState() => IndexState();
}

class IndexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu().drawer(context, headline: widget.headline),
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
    );
  }
}
