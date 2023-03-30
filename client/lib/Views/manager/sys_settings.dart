// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:client/public/lang.dart';
import 'package:client/public/tools.dart';
import 'package:client/Views/common/toast.dart';
import 'package:client/Views/common/menu.dart';

import 'package:client/providers/base_notifier.dart';
import 'package:client/providers/manager_notifier.dart';

import 'package:client/models/manager_model.dart';

// ignore: must_be_immutable
class SysSettings extends StatefulWidget {
  late String headline;
  SysSettings({super.key, required this.headline});

  @override
  State<SysSettings> createState() => SysSettingsState();
}

class SysSettingsState extends State<SysSettings> {
  Widget mainWidget(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.all(0),
      color: Colors.grey,
      child: Container(
        margin: const EdgeInsets.all(10),
        color: Colors.white70,
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          child: const Column(
            children: [],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ManagerMenu().drawer(context, headline: widget.headline),
      appBar: AppBar(title: Text(Lang().systemSettings)),
      body: mainWidget(context),
    );
  }
}
