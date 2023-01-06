import 'package:client/Views/common/error_page.dart';
import 'package:client/Views/common/show_alert_dialog.dart';
import 'package:client/Views/common/toast.dart';
import 'package:client/models/base.dart';
import 'package:client/models/manager_model.dart';
import 'package:client/public/tools.dart';
import 'package:client/requests/manager_api.dart';
import 'package:flutter/material.dart';
import 'package:client/public/lang.dart';
import 'package:client/Views/common/menu.dart';

// ignore: must_be_immutable
class PersonalSettings extends StatefulWidget {
  late String headline;
  PersonalSettings({super.key, required this.headline});

  @override
  State<PersonalSettings> createState() =>
      // ignore: no_logic_in_create_state
      PersonalSettingsState(headline: headline);
}

class PersonalSettingsState extends State<PersonalSettings> {
  late String headline;
  PersonalSettingsState({this.headline = ''});

  mainWidget(BuildContext context, {dynamic data}) {
    data as ManagerModel;
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
                        if (nameController.text.isNotEmpty &&
                            nameController.text.trim() != data.name) {
                          var result = ManagerApi().updateManagerInfo(
                              name: nameController.text,
                              permission: data.permission);
                          result.then((value) {
                            if (value.state == true) {
                              Toast().show(context,
                                  message: Lang().theOperationCompletes);
                            } else {
                              showAlertDialog(context, Lang().theRequestFailed);
                            }
                          });
                        }
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
      appBar: AppBar(title: Text(Lang().personalSettings)),
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
              widget = mainWidget(context, data: managerData);
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
