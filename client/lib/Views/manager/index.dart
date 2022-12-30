import 'package:client/public/lang.dart';
import 'package:flutter/material.dart';
import 'package:client/Views/common/menu.dart';

class Index extends StatefulWidget {
  final String arg;
  const Index({super.key, this.arg = ''});

  @override
  // ignore: no_logic_in_create_state
  State<Index> createState() => IndexState(arg: arg);
}

class IndexState extends State<Index> {
  var lang = Lang();
  var common = Common();
  dynamic arg;
  IndexState({this.arg});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.menu),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.all(0),
        color: Colors.grey,
      ),
      drawer: common.drawer(headline: arg),
    );
  }
}
