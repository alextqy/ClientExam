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
class PersonalSettings extends StatefulWidget {
  late String headline;
  PersonalSettings({super.key, required this.headline});

  @override
  State<PersonalSettings> createState() => PersonalSettingsState();
}

class PersonalSettingsState extends State<PersonalSettings> {
  ManagerNotifier managerNotifier = ManagerNotifier();

  basicListener() async {
    if (managerNotifier.operationStatus.value == OperationStatus.loading) {
      Toast().show(context, message: Lang().loading);
    } else if (managerNotifier.operationStatus.value == OperationStatus.success) {
      Toast().show(context, message: Lang().theOperationCompletes);
    } else {
      Toast().show(context, message: managerNotifier.operationMemo);
    }
  }

  @override
  void initState() {
    super.initState();
    managerNotifier.managerInfo().then((value) {
      setState(() {
        managerNotifier.managerModel = ManagerModel.fromJson(value.data);
      });
    });
    managerNotifier.addListener(basicListener);
  }

  @override
  void dispose() {
    managerNotifier.removeListener(basicListener);
    managerNotifier.dispose();
    super.dispose();
  }

  Widget mainWidget(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: managerNotifier.managerModel.name);
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
                        if (nameController.text.isNotEmpty && nameController.text != managerNotifier.managerModel.name) {
                          managerNotifier.updateManagerInfo(
                            name: nameController.text,
                            permission: managerNotifier.managerModel.permission,
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
                      onTap: () => Toast().show(context, message: Lang().thisItemCannotBeModified),
                      controller: TextEditingController(text: managerNotifier.managerModel.account),
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
                      onTap: () => Toast().show(context, message: Lang().thisItemCannotBeModified),
                      controller: TextEditingController(
                        text: Tools().timestampToStr(managerNotifier.managerModel.createTime),
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
                          ManagerNotifier().managerChangePassword(newPassword: passwordController.text);
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
      drawer: ManagerMenu().drawer(context, headline: widget.headline),
      appBar: AppBar(
          title: Text(
        Lang().personalSettings,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      )),
      body: mainWidget(context),
    );
  }
}
