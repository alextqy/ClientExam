// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:client/public/lang.dart';
import 'package:client/public/tools.dart';
import 'package:client/Views/common/toast.dart';
import 'package:client/Views/common/menu.dart';

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

  basicListener() async {
    if (sysConfNotifier.operationStatus.value == OperationStatus.loading) {
      Toast().show(context, message: Lang().loading);
    } else if (sysConfNotifier.operationStatus.value == OperationStatus.success) {
      Toast().show(context, message: Lang().theOperationCompletes);
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
                  SizedBox(
                    height: 45,
                    child: ElevatedButton(
                      child: Text(Lang().reviewTheInstalledProgrammingEnvironment),
                      onPressed: () {
                        imagesAlertDialog(context);
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
                                  message: Lang().copyID,
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
      appBar: AppBar(title: Text(Lang().systemSettings)),
      body: mainWidget(context),
    );
  }
}
