import 'package:flutter/material.dart';
import 'package:client/Views/common/menu.dart';

class Index extends StatelessWidget {
  final common = Common();
  Index({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.all(0),
        color: Colors.grey,
      ),
      drawer: common.drawer(),
    );
  }
}
