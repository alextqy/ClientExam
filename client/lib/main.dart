import 'package:flutter/material.dart';
import 'package:client/requests/manager_api.dart';
import 'package:client/public/lang.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.blueGrey),
    home: Scaffold(
      body: Index(),
    ),
  ));
}

class Index extends StatelessWidget {
  final managerApi = ManagerApi();
  final lang = Lang();
  Index({super.key});

  test() {
    managerApi.test().then((res) {
      print(res.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    var managerButton = Container(
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(180, 50),
              shadowColor: Colors.grey,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )),
          child: Text(
            lang.manager,
            style: const TextStyle(fontSize: 18),
          ),
          onPressed: () => {
            test(),
          },
        ));

    var teacherButton = Container(
        margin: const EdgeInsets.all(20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(180, 50),
              shadowColor: Colors.grey,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )),
          child: Text(
            lang.teacher,
            style: const TextStyle(fontSize: 18),
          ),
          onPressed: () => {
            showAlertDialog(context),
          },
        ));

    return Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
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
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(lang.confirm)),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(lang.cancel)),
            ],
          );
        });
  }
}
