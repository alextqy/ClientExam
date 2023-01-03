import 'package:flutter/material.dart';
import 'package:client/routes.dart';
import 'package:client/requests/manager_api.dart';
import 'package:client/public/lang.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.blueGrey),
    home: Scaffold(
      body: Entrance(),
    ),
  ));
}

class Entrance extends StatelessWidget {
  final managerApi = ManagerApi();
  final lang = Lang();
  final route = RouteHelper();
  Entrance({super.key});

  // test() {
  //   managerApi.test().then((res) {
  //     print(res.data);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var managerButton = Container(
      margin: const EdgeInsets.all(10),
      child: Tooltip(
        message: lang.administratorLoginEntry,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(180, 50),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          child: Text(
            lang.managers,
            style: const TextStyle(fontSize: 18),
          ),
          onPressed: () => {
            Navigator.of(context).push(route.generate('/manager/login')),
          },
        ),
      ),
    );

    var teacherButton = Container(
      margin: const EdgeInsets.all(10),
      child: Tooltip(
        message: lang.teacherLoginPortal,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(180, 50),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          child: Text(
            lang.teachers,
            style: const TextStyle(fontSize: 18),
          ),
          onPressed: () => {
            showAlertDialog(context),
          },
        ),
      ),
    );

    return Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.all(0),
        color: Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            managerButton,
            teacherButton,
          ],
        ));
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text('Under development'),
            title: Text(lang.title),
            actions: [
              // TextButton(
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              //   child: Text(lang.confirm),
              // ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(lang.cancel),
              ),
            ],
          );
        });
  }
}
