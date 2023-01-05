import 'package:client/Views/common/show_alert_dialog.dart';
import 'package:client/public/file.dart';
import 'package:client/requests/manager_api.dart';
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
  var fileHelper = FileHelper();
  var menu = Menu();
  final args = routeArgs;
  var managerApi = ManagerApi();
  PersonalSettingsState({args});

  @override
  Widget build(BuildContext context) {
    var result = managerApi.managerInfo(fileHelper.readFile('token'));

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
          color: Colors.white54,
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 45,
                      width: 300,
                      child: TextField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: lang.name,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        child: Text(
                          lang.submit,
                        ),
                        onPressed: () {
                          print('name');
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: menu.drawer(context, headline: args['headline']),
    );
  }
}
