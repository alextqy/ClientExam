import 'package:flutter/material.dart';
import 'package:client/routes.dart';
import 'package:client/public/lang.dart';
import 'package:client/public/file.dart';
import 'package:client/udp_set.dart';

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
            style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            if (FileHelper().fileExists('ServerAddress') == true && FileHelper().readFile('ServerAddress').isNotEmpty == true) {
              Navigator.of(context).push(RouteHelper().generate('/manager/login'));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    Lang().theServerAddressIsNotSet,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  action: SnackBarAction(
                    label: Lang().goToSetServerAddress,
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UdpSet())),
                  ),
                ),
              );
            }
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
            style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            if (FileHelper().fileExists('ServerAddress') == true && FileHelper().readFile('ServerAddress').isNotEmpty == true) {
              Navigator.of(context).push(RouteHelper().generate('/teacher/login'));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    Lang().theServerAddressIsNotSet,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  action: SnackBarAction(
                    label: Lang().goToSetServerAddress,
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UdpSet())),
                  ),
                ),
              );
            }
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
      ),
    );
  }
}
