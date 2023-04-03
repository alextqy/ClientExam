// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:client/public/lang.dart';
import 'package:client/Views/common/menu.dart';
import 'package:client/Views/common/error_page.dart';

// ignore: must_be_immutable
class Index extends StatefulWidget {
  late String headline;
  Index({super.key, required this.headline});

  @override
  State<Index> createState() => IndexState();
}

class IndexState extends State<Index> {
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
      drawer: TeacherMenu().drawer(context, headline: widget.headline),
      appBar: AppBar(
        title: Text(
          Lang().menu,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
    );
  }
}
