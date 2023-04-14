import 'dart:io';
import 'package:flutter/material.dart';
import 'package:client/public/lang.dart';
import 'package:client/public/file.dart';
import 'package:client/Views/common/toast.dart';
import 'package:client/routes.dart';
import 'package:client/requests/manager_api.dart';
import 'package:client/requests/teacher_api.dart';

import 'package:client/main.dart';

class ManagerMenu {
  String headline = '';

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
                  Navigator.of(context).push(RouteHelper().generate('/manager/personal/settings', headline: headline));
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
    return Tooltip(
      message: Lang().longPressToExit,
      child: SizedBox(
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
              Text(Lang().exit),
              const SizedBox(width: 10),
              const Icon(size: 18, Icons.exit_to_app),
            ],
          ),
          onLongPress: () {
            try {
              ManagerApi().managerSignOut().then((value) {
                if (value.state == true) {
                  if (FileHelper().delFile('token')) {
                    exit(0);
                  }
                } else {
                  Toast().show(context, message: value.memo);
                }
              });
            } catch (e) {
              Toast().show(context, message: e.toString());
            }
          },
          onPressed: () {
            try {
              ManagerApi().managerSignOut().then((value) {
                if (value.state == true) {
                  if (FileHelper().delFile('token')) {
                    // 返回到首页并清理路由节点
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const Entrance()), (Route<dynamic> route) {
                      return route.isFirst;
                    });
                  }
                } else {
                  Toast().show(context, message: value.memo);
                }
              });
            } catch (e) {
              Toast().show(context, message: e.toString());
            }
          },
        ),
      ),
    );
  }

  Drawer drawer(BuildContext context, {String headline = ''}) {
    if (headline.isNotEmpty) {
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
                    Lang().managers,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      RouteHelper().generate('/manager/manager', headline: headline),
                    );
                  },
                ),
                ListTile(
                  horizontalTitleGap: 25,
                  leading: const Icon(size: 30, Icons.book_outlined),
                  title: Text(
                    Lang().teachers,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      RouteHelper().generate('/manager/teacher', headline: headline),
                    );
                  },
                ),
                ListTile(
                  horizontalTitleGap: 25,
                  leading: const Icon(size: 30, Icons.cast_for_education_outlined),
                  title: Text(
                    Lang().classes,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      RouteHelper().generate('/manager/class', headline: headline),
                    );
                  },
                ),
                ListTile(
                  horizontalTitleGap: 25,
                  leading: const Icon(size: 30, Icons.school),
                  title: Text(
                    Lang().examinee,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      RouteHelper().generate('/manager/examinee', headline: headline),
                    );
                  },
                ),
                ListTile(
                  horizontalTitleGap: 25,
                  leading: const Icon(size: 30, Icons.card_membership),
                  title: Text(
                    Lang().examRegistrations,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      RouteHelper().generate('/manager/examInfo', headline: headline),
                    );
                  },
                ),
                ListTile(
                  horizontalTitleGap: 25,
                  leading: const Icon(size: 30, Icons.history),
                  title: Text(
                    Lang().oldExamRegistrations,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      RouteHelper().generate('/manager/old/examInfo', headline: headline),
                    );
                  },
                ),
                ListTile(
                  horizontalTitleGap: 25,
                  leading: const Icon(size: 30, Icons.subject),
                  title: Text(
                    Lang().examSubjects,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      RouteHelper().generate('/manager/subject', headline: headline),
                    );
                  },
                ),
                ListTile(
                  horizontalTitleGap: 25,
                  leading: const Icon(size: 30, Icons.grid_4x4),
                  title: Text(
                    Lang().knowledgePoints,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      RouteHelper().generate('/manager/knowledge/point', headline: headline),
                    );
                  },
                ),
                ListTile(
                  horizontalTitleGap: 25,
                  leading: const Icon(size: 30, Icons.title),
                  title: Text(
                    Lang().topTitle,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      RouteHelper().generate('/manager/top/title', headline: headline),
                    );
                  },
                ),
                ListTile(
                  horizontalTitleGap: 25,
                  leading: const Icon(size: 30, Icons.question_answer),
                  title: Text(
                    Lang().questions,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      RouteHelper().generate('/manager/question', headline: headline),
                    );
                  },
                ),
                ListTile(
                  horizontalTitleGap: 25,
                  leading: const Icon(size: 30, Icons.file_open_outlined),
                  title: Text(
                    Lang().paper,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      RouteHelper().generate('/manager/paper', headline: headline),
                    );
                  },
                ),
                ListTile(
                  horizontalTitleGap: 25,
                  leading: const Icon(size: 30, Icons.timer),
                  title: Text(
                    Lang().examLogs,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      RouteHelper().generate('/manager/exam/logs', headline: headline),
                    );
                  },
                ),
                ListTile(
                  horizontalTitleGap: 25,
                  leading: const Icon(size: 30, Icons.timeline),
                  title: Text(
                    Lang().systemLogs,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      RouteHelper().generate('/manager/sys/logs', headline: headline),
                    );
                  },
                ),
                ListTile(
                  horizontalTitleGap: 25,
                  leading: const Icon(size: 30, Icons.settings),
                  title: Text(
                    Lang().systemSettings,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      RouteHelper().generate('/manager/sys/settings', headline: headline),
                    );
                  },
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

class TeacherMenu {
  String headline = '';

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
                  Navigator.of(context).push(RouteHelper().generate('/teacher/personal/settings', headline: headline));
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
    return Tooltip(
      message: Lang().longPressToExit,
      child: SizedBox(
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
              Text(Lang().exit),
              const SizedBox(width: 10),
              const Icon(size: 18, Icons.exit_to_app),
            ],
          ),
          onLongPress: () {
            try {
              TeacherApi().teacherSignOut().then((value) {
                if (value.state == true) {
                  if (FileHelper().delFile('token')) {
                    exit(0);
                  }
                } else {
                  Toast().show(context, message: value.memo);
                }
              });
            } catch (e) {
              Toast().show(context, message: e.toString());
            }
          },
          onPressed: () {
            try {
              TeacherApi().teacherSignOut().then((value) {
                if (value.state == true) {
                  if (FileHelper().delFile('token')) {
                    // 返回到首页并清理路由节点
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const Entrance()), (Route<dynamic> route) {
                      return route.isFirst;
                    });
                  } else {
                    Toast().show(context, message: value.memo);
                  }
                }
              });
            } catch (e) {
              Toast().show(context, message: e.toString());
            }
          },
        ),
      ),
    );
  }

  Drawer drawer(BuildContext context, {String headline = ''}) {
    if (headline.isNotEmpty) {
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
                  leading: const Icon(size: 30, Icons.cast_for_education_outlined),
                  title: Text(
                    Lang().classes,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      RouteHelper().generate('/teacher/class', headline: headline),
                    );
                  },
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
