import 'package:client/Views/common/error_page.dart';
import 'package:client/Views/common/toast.dart';
import 'package:client/models/base.dart';
import 'package:client/models/manager_model.dart';
import 'package:client/public/file.dart';
import 'package:client/public/tools.dart';
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
  final args = routeArgs;
  PersonalSettingsState({args});

  mainWidget(BuildContext context, ManagerModel data) {
    var nameController = TextEditingController(text: data.name);
    var passwordController = TextEditingController();

    return Container(
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
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: Lang().name,
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return Lang().incorrectInput;
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 45,
                    child: ElevatedButton(
                      child: Text(
                        Lang().submit,
                      ),
                      onPressed: () {
                        print(nameController.text);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  SizedBox(
                    height: 45,
                    width: 300,
                    child: TextFormField(
                      readOnly: true,
                      onTap: () => Toast().show(context,
                          message: Lang().thisItemCannotBeModified),
                      controller: TextEditingController(text: data.account),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: Lang().account,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  SizedBox(
                    height: 45,
                    width: 300,
                    child: TextFormField(
                      readOnly: true,
                      onTap: () => Toast().show(context,
                          message: Lang().thisItemCannotBeModified),
                      controller: TextEditingController(
                          text: Tools().timestampToStr(data.createTime)),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: Lang().createtime,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  SizedBox(
                    height: 45,
                    width: 300,
                    child: TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: Lang().password,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 45,
                    child: ElevatedButton(
                      child: Text(
                        Lang().submit,
                      ),
                      onPressed: () {
                        print(passwordController.text);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var result = ManagerApi().managerInfo();

    return Scaffold(
      appBar: AppBar(
        title: Text(Lang().personalSettings),
      ),
      body: FutureBuilder(
        future: result,
        builder: (context, snapshot) {
          Widget widget;
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError || snapshot.data?.state != true) {
              widget = errorPage();
            } else {
              var basicData = snapshot.data as BaseModel;
              var managerData = ManagerModel.fromJson(basicData.data);
              widget = mainWidget(context, managerData);
            }
          } else {
            widget = const Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: widget,
          );
        },
      ),
      drawer: Menu().drawer(context, headline: args['headline']),
    );
  }
}
