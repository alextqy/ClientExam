import 'package:flutter/material.dart';
import 'package:client/public/lang.dart';
import 'package:client/Views/common/menu.dart';

class PersonalSettings extends StatefulWidget {
  final String headline;
  const PersonalSettings({super.key, this.headline = ''});

  @override
  State<PersonalSettings> createState() =>
      // ignore: no_logic_in_create_state
      PersonalSettingsState(headline: headline);
}

class PersonalSettingsState extends State<PersonalSettings> {
  var lang = Lang();
  var common = Common();
  String headline;
  PersonalSettingsState({this.headline = ''});

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
      drawer: common.drawer(headline: headline),
    );
  }
}
