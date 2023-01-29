import 'package:client/Views/common/toast.dart';
import 'package:client/models/base.dart';
import 'package:client/models/manager_model.dart';
import 'package:client/providers/base_notifier.dart';
import 'package:client/providers/personal_settings_notifier.dart';
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
  State<PersonalSettings> createState() => PersonalSettingsState();
}

class PersonalSettingsState extends State<PersonalSettings> {
  PersonalSettingsNotifier personalSettingsNotifier =
      PersonalSettingsNotifier();

  basicListener() async {
    if (personalSettingsNotifier.operationStatus.value ==
        OperationStatus.loading) {
      Toast().show(context, message: Lang().loading);
    } else if (personalSettingsNotifier.operationStatus.value ==
        OperationStatus.success) {
      Toast().show(context, message: Lang().theOperationCompletes);
    } else {
      Toast().show(context, message: personalSettingsNotifier.operationMemo);
    }
  }

  @override
  void initState() {
    super.initState();
    personalSettingsNotifier.fetchManager().then((value) {
      setState(() {
        personalSettingsNotifier.managerModel =
            ManagerModel.fromJson(value.data);
      });
    });
    personalSettingsNotifier.addListener(basicListener);
  }

  @override
  void dispose() {
    personalSettingsNotifier.removeListener(basicListener);
    personalSettingsNotifier.dispose();
    super.dispose();
  }

  mainWidget(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: personalSettingsNotifier.managerModel.name);
    TextEditingController passwordController = TextEditingController();

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
                            nameController.text !=
                                personalSettingsNotifier.managerModel.name) {
                          personalSettingsNotifier.updatePersonalData(
                            name: nameController.text,
                            permission: personalSettingsNotifier
                                .managerModel.permission,
                          );
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
                      controller: TextEditingController(
                          text: personalSettingsNotifier.managerModel.account),
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
                        text: Tools().timestampToStr(
                            personalSettingsNotifier.managerModel.createTime),
                      ),
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
                      obscureText: true,
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
                        if (passwordController.text.isNotEmpty) {
                          Future<BaseModel> result = ManagerApi()
                              .managerChangePassword(
                                  newPassword: passwordController.text);
                          result.then(
                            (value) {
                              if (value.state == true) {
                                passwordController.clear();
                                Toast().show(context,
                                    message: Lang().theOperationCompletes);
                              } else {
                                Toast().show(context, message: value.memo);
                              }
                            },
                          );
                        }
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
    return Scaffold(
      drawer: Menu().drawer(context, headline: widget.headline),
      appBar: AppBar(title: Text(Lang().personalSettings)),
      body: mainWidget(context),
    );
  }
}
