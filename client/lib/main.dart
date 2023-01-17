import 'package:client/Views/common/show_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:client/routes.dart';
import 'package:client/public/lang.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.blueGrey),
    home: const Scaffold(
      body: Entrance(),
    ),
  ));
}

class Entrance extends StatelessWidget {
  const Entrance({super.key});

  // test() {
  //   managerApi.test().then((res) {
  //     print(res.data);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Container managerButton = Container(
      margin: const EdgeInsets.all(10),
      child: Tooltip(
        message: Lang().administratorLoginEntry,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(180, 50),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          child: Text(
            Lang().managers,
            style: const TextStyle(fontSize: 18),
          ),
          onPressed: () => {
            Navigator.of(context)
                .push(RouteHelper().generate('/manager/login')),
          },
        ),
      ),
    );

    Container teacherButton = Container(
      margin: const EdgeInsets.all(10),
      child: Tooltip(
        message: Lang().teacherLoginPortal,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(180, 50),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          child: Text(
            Lang().teachers,
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

  // void showAlertDialog(BuildContext context) {
  //   showDialog(
  //       context: context,
  //       barrierDismissible: true,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           content: const Text('Under development'),
  //           title: Text(Lang().title),
  //           actions: [
  //             // TextButton(
  //             //   onPressed: () {
  //             //     Navigator.of(context).pop();
  //             //   },
  //             //   child: Text(Lang().confirm),
  //             // ),
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: Text(Lang().cancel),
  //             ),
  //           ],
  //         );
  //       });
  // }
}
