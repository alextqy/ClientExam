import 'package:flutter/material.dart';
import 'package:client/routes.dart';
import 'package:client/public/lang.dart';
import 'package:client/public/file.dart';
import 'package:client/udp_set.dart';

void main() {
  FileHelper().jsonWrite(key: 'lang', value: 'en');
  runApp(
    MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: const Scaffold(body: Entrance()),
    ),
  );
}

// ignore: must_be_immutable
class Entrance extends StatefulWidget {
  const Entrance({super.key});

  @override
  State<Entrance> createState() => EntranceState();
}

class EntranceState extends State<Entrance> {
  int groupValue = 1;

  void checkLang() {
    if (FileHelper().jsonRead(key: 'lang') == 'en') {
      setState(() {
        groupValue = 1;
      });
    } else if (FileHelper().jsonRead(key: 'lang') == 'cn') {
      setState(() {
        groupValue = 2;
      });
    } else {
      setState(() {
        groupValue = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    checkLang();

    Container managerButton = Container(
      margin: const EdgeInsets.all(10),
      child: Tooltip(
        message: Lang().administratorLoginEntry,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(220, 45),
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
            fixedSize: const Size(220, 45),
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

    Row selectLang = Row(
      children: [
        const Expanded(child: SizedBox()),
        const SizedBox(width: 80),
        Radio(
          activeColor: Colors.white,
          value: 1,
          groupValue: groupValue,
          onChanged: (int? v) {
            setState(() {
              groupValue = v ?? 0;
              FileHelper().jsonWrite(key: 'lang', value: 'en');
            });
          },
        ),
        const Text('English', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        // const SizedBox(width: 20),
        Radio(
          activeColor: Colors.white,
          value: 2,
          groupValue: groupValue,
          onChanged: (int? v) {
            setState(() {
              groupValue = v ?? 0;
              FileHelper().jsonWrite(key: 'lang', value: 'cn');
            });
          },
        ),
        const Text('中文', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        const Expanded(child: SizedBox()),
      ],
    );

    Widget mainWidget(BuildContext context) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.all(0),
        color: Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [managerButton, teacherButton, selectLang],
        ),
      );
    }

    return Scaffold(body: mainWidget(context));
  }
}
