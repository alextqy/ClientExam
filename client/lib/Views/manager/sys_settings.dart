// ignore_for_file: file_names
import 'package:flutter/material.dart';

import 'package:client/public/lang.dart';
import 'package:client/Views/common/toast.dart';
import 'package:client/Views/common/menu.dart';
import 'package:client/Views/common/basic_info.dart';
import 'package:client/Views/common/show_alert_dialog.dart';

import 'package:client/providers/base_notifier.dart';
import 'package:client/providers/sys_conf_notifier.dart';

// ignore: must_be_immutable
class SysSettings extends StatefulWidget {
  late String headline;
  SysSettings({super.key, required this.headline});

  @override
  State<SysSettings> createState() => SysSettingsState();
}

class SysSettingsState extends State<SysSettings> {
  SysConfNotifier sysConfNotifier = SysConfNotifier();
  String languageMemo = Lang().notSelected;
  TextEditingController languageVersionController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  String codeLanguageMemo = Lang().notSelected;
  TextEditingController codeLanguageVersionController = TextEditingController();
  bool showImages = true;

  basicListener() async {
    if (sysConfNotifier.operationStatus.value == OperationStatus.loading) {
      Toast().show(context, message: Lang().loading);
    } else if (sysConfNotifier.operationStatus.value == OperationStatus.success) {
      Toast().show(context, message: Lang().theOperationCompletes);
      showImages = true;
    } else {
      Toast().show(context, message: sysConfNotifier.operationMemo);
    }
  }

  @override
  void initState() {
    super.initState();
    sysConfNotifier.addListener(basicListener);
  }

  @override
  void dispose() {
    sysConfNotifier.dispose();
    sysConfNotifier.removeListener(basicListener);
    super.dispose();
  }

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
          child: Column(
            children: [
              Row(
                children: [
                  DropdownButton<String>(
                    value: languageMemo.isNotEmpty ? languageMemo : Lang().notSelected,
                    icon: const Icon(Icons.arrow_drop_down),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    // elevation: 16,
                    underline: Container(
                      height: 0,
                      // color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        if (value != null && languageMemo != value) {
                          languageMemo = value;
                        }
                      });
                    },
                    items: languageList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 45,
                    width: 150,
                    child: TextFormField(
                      controller: languageVersionController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: Lang().languageVersion,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 45,
                    child: Tooltip(
                      message: Lang().add,
                      child: IconButton(
                        icon: const Icon(Icons.add, size: 30),
                        onPressed: () {
                          showImages = false;
                          Toast().show(context, message: Lang().loading, seconds: 30);
                          if (languageMemo != Lang().notSelected && languageVersionController.text.isNotEmpty) {
                            sysConfNotifier.buildEnvironment(language: languageMemo, version: languageVersionController.text);
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 15,
                    width: 15,
                    child: questionMark(context, languageMemo),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    height: 45,
                    child: ElevatedButton(
                      child: Text(Lang().reviewTheInstalledProgrammingEnvironment),
                      onPressed: () {
                        if (showImages == true) {
                          Toast().show(context, message: Lang().loading);
                          imagesAlertDialog(context);
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Text(Lang().codeTesting,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: TextField(
                  minLines: 10,
                  maxLines: null,
                  controller: codeController,
                  decoration: InputDecoration(
                    hintText: Lang().content,
                    hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                    suffixIcon: IconButton(
                      iconSize: 20,
                      onPressed: () => codeController.clear(),
                      icon: const Icon(Icons.clear),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Expanded(child: SizedBox()),
                  DropdownButton<String>(
                    value: codeLanguageMemo.isNotEmpty ? codeLanguageMemo : Lang().notSelected,
                    icon: const Icon(Icons.arrow_drop_down),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    // elevation: 16,
                    underline: Container(
                      height: 0,
                      // color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        if (value != null && codeLanguageMemo != value) {
                          codeLanguageMemo = value;
                        }
                      });
                    },
                    items: languageList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 45,
                    width: 150,
                    child: TextField(
                      controller: codeLanguageVersionController,
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: Lang().languageVersion,
                        hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 45,
                    child: ElevatedButton(
                      child: Text(Lang().submit),
                      onPressed: () {
                        if (codeController.text.isNotEmpty && codeLanguageMemo != Lang().notSelected && codeLanguageVersionController.text.isNotEmpty) {
                          sysConfNotifier
                              .codeExecTest(
                            language: codeLanguageMemo,
                            version: codeLanguageVersionController.text,
                            codeStr: codeController.text,
                          )
                              .then((value) {
                            if (value.state == false) {
                              Toast().show(context, message: value.memo);
                            } else {
                              showAlertDialog(context, memo: value.data);
                            }
                          });
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

  void imagesAlertDialog(BuildContext context) {
    sysConfNotifier.imageList().then((value) {
      if (value.state == true) {
        List<String> imageList = (value.data as List).map((i) => i.toString()).toList();
        for (int i = 0; i < imageList.length; i++) {
          List imageInfoArr = imageList[i].split('#');
          Map<String, String> dataInfo = {
            'Lang': imageInfoArr[0],
            'Ver': imageInfoArr[1],
            'ID': imageInfoArr[2],
          };
          sysConfNotifier.imageDict.add(dataInfo);
        }
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (BuildContext context, Function state) {
                return AlertDialog(
                  title: Text(Lang().title),
                  content: SizedBox(
                    width: 400,
                    height: 300,
                    child: ListView.separated(
                      padding: const EdgeInsets.all(0),
                      itemCount: sysConfNotifier.imageDict.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              SizedBox(
                                child: Text(
                                  sysConfNotifier.imageDict[index]['Lang'] ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              SizedBox(
                                child: Text(
                                  sysConfNotifier.imageDict[index]['Ver'] ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              SizedBox(
                                child: Tooltip(
                                  message: Lang().remove,
                                  child: IconButton(
                                    icon: const Icon(Icons.delete_outline),
                                    onPressed: () {
                                      state(() {
                                        sysConfNotifier.imageRemove(imageID: sysConfNotifier.imageDict[index]['ID'] ?? '');
                                        sysConfNotifier.imageDict.removeAt(index);
                                      });
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.5, color: Colors.black12),
                    ),
                  ),
                );
              },
            );
          },
        );
      } else {
        Toast().show(context, message: Lang().theRequestFailed);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ManagerMenu().drawer(context, headline: widget.headline),
      appBar: AppBar(
          title: Text(
        Lang().systemSettings,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      )),
      body: mainWidget(context),
    );
  }
}
