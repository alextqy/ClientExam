import 'dart:io';
import 'package:flutter/material.dart';

import 'package:client/public/lang.dart';
import 'package:client/Views/common/toast.dart';
import 'package:client/models/route_args.dart';
import 'package:client/routes.dart';
import 'package:client/requests/manager_api.dart';
import 'package:client/public/file.dart';

class Common {
  var lang = Lang();
  var route = RouteHelper();
  String headline = '';
  var fileHelper = FileHelper();
  var managerApi = ManagerApi();

  dynamic menuHeader(BuildContext context) {
    return SizedBox(
      height: 80,
      width: double.infinity, // 占满父级元素宽度
      child: DrawerHeader(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        decoration: const BoxDecoration(color: Colors.black38),
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              height: 40,
              width: 55,
              // child: CircleAvatar(
              //   backgroundColor: Colors.white,
              //   child: SizedBox(
              //     height: 43,
              //     width: 43,
              //     child: CircleAvatar(
              //       backgroundColor: Colors.blueGrey,
              //       child: Text(
              //         this.headline.substring(0, 1),
              //         style: const TextStyle(
              //           color: Colors.white,
              //           fontWeight: FontWeight.w600,
              //           fontSize: 30,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              child: ElevatedButton(
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                    const BorderSide(width: 1, color: Colors.white),
                  ),
                  shape: MaterialStateProperty.all(
                    BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                child: Text(
                  headline,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                  ),
                ),
                onPressed: () {
                  routeArgs['headline'] = headline;
                  Navigator.of(context).push(
                      route.generate('/manager/personal/settings', routeArgs));
                },
              ),
            ),
            // const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  dynamic menuFooter(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              return Colors.black38;
            },
          ),
        ),
        child: Row(
          children: [
            const Expanded(child: SizedBox()),
            Text(lang.exit),
            const SizedBox(width: 10),
            const Icon(size: 18, Icons.exit_to_app),
          ],
        ),
        onLongPress: () {
          try {
            var token = fileHelper.readFile('token');
            managerApi.managerSignOut(token);
            fileHelper.delFile('token');
            exit(0);
          } catch (e) {
            exit(0);
          }
        },
        onPressed: () {
          Toast().show(context, message: lang.longPressToExit);
        },
      ),
    );
  }

  Drawer drawer(BuildContext context, {String headline = ''}) {
    if (headline != '') {
      this.headline = headline.substring(0, 1).toUpperCase();
    }
    return Drawer(
      width: 235,
      backgroundColor: Colors.blueGrey,
      child: Column(
        children: [
          menuHeader(context),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                ListTile(
                  horizontalTitleGap: 25,
                  leading: const Icon(size: 30, Icons.manage_accounts),
                  title: Text(
                    lang.managers,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    routeArgs['headline'] = headline;
                    Navigator.of(context).push(
                      route.generate('/manager/manager', routeArgs),
                    );
                  },
                ),
                ListTile(
                  horizontalTitleGap: 25,
                  leading: const Icon(size: 30, Icons.abc),
                  title: Text(
                    lang.teachers,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () => print(lang.teachers),
                ),
                ListTile(
                  horizontalTitleGap: 25,
                  leading: const Icon(size: 30, Icons.class_),
                  title: Text(
                    lang.classes,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () => print(lang.classes),
                ),
                ListTile(
                  horizontalTitleGap: 25,
                  leading: const Icon(size: 30, Icons.school),
                  title: Text(
                    lang.examinee,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () => print(lang.examinee),
                ),
                ListTile(
                  horizontalTitleGap: 25,
                  leading: const Icon(size: 30, Icons.sign_language),
                  title: Text(
                    lang.examRegistrations,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () => print(lang.examRegistrations),
                ),
                ListTile(
                  horizontalTitleGap: 25,
                  leading: const Icon(size: 30, Icons.history_edu),
                  title: Text(
                    lang.oldExamRegistrations,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () => print(lang.oldExamRegistrations),
                ),
                ListTile(
                  horizontalTitleGap: 25,
                  leading: const Icon(size: 30, Icons.subject),
                  title: Text(
                    lang.examSubjects,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () => print(lang.examSubjects),
                ),
                ListTile(
                  horizontalTitleGap: 25,
                  leading: const Icon(size: 30, Icons.grid_4x4),
                  title: Text(
                    lang.knowledgePoints,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () => print(lang.knowledgePoints),
                ),
                ListTile(
                  horizontalTitleGap: 25,
                  leading: const Icon(size: 30, Icons.title),
                  title: Text(
                    lang.topTitle,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () => print(lang.topTitle),
                ),
                ListTile(
                  horizontalTitleGap: 25,
                  leading: const Icon(size: 30, Icons.question_answer),
                  title: Text(
                    lang.questions,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () => print(lang.questions),
                ),
                ListTile(
                  horizontalTitleGap: 25,
                  leading: const Icon(size: 30, Icons.file_present),
                  title: Text(
                    lang.paper,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () => print(lang.paper),
                ),
                ListTile(
                  horizontalTitleGap: 25,
                  leading: const Icon(size: 30, Icons.card_membership),
                  title: Text(
                    lang.answerCards,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () => print(lang.answerCards),
                ),
                ListTile(
                  horizontalTitleGap: 25,
                  leading: const Icon(size: 30, Icons.history),
                  title: Text(
                    lang.oldAnswerCards,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () => print(lang.oldAnswerCards),
                ),
                ListTile(
                  horizontalTitleGap: 25,
                  leading: const Icon(size: 30, Icons.cast_for_education),
                  title: Text(
                    lang.examLogs,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () => print(lang.examLogs),
                ),
                ListTile(
                  horizontalTitleGap: 25,
                  leading: const Icon(size: 30, Icons.system_update_tv),
                  title: Text(
                    lang.systemLogs,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () => print(lang.systemLogs),
                ),
              ],
            ),
          ),
          menuFooter(context),
        ],
      ),
    );
  }
}
