import 'package:flutter/material.dart';
import 'package:client/public/lang.dart';
import 'package:client/Views/common/menu.dart';
import 'package:client/models/route_args.dart';

class PersonalSettings extends StatefulWidget {
  const PersonalSettings({super.key, dynamic routeArgs});

  @override
  State<PersonalSettings> createState() =>
      // ignore: no_logic_in_create_state
      PersonalSettingsState(args: routeArgs);
}

class PersonalSettingsState extends State<PersonalSettings> {
  var lang = Lang();
  var common = Common();
  final args = routeArgs;
  PersonalSettingsState({args});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.personalSettings),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.all(0),
        color: Colors.grey,
        child: Container(
          margin: const EdgeInsets.all(10),
          color: Colors.white30,
        ),
      ),
      drawer: common.drawer(context, headline: args['headline']),
    );
  }
}
