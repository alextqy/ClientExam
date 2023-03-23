import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:client/public/lang.dart';
import 'package:client/public/tools.dart';

class UdpSet extends StatefulWidget {
  const UdpSet({super.key});

  @override
  State<UdpSet> createState() => UdpSetState();
}

class UdpSetState extends State<UdpSet> {
  Widget mainWidget(BuildContext context) {
    TextEditingController udpController = TextEditingController();
    TextEditingController portController = TextEditingController();
    udpController.text = '';
    portController.text = '60000';
    String udpData = '';

    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.all(0),
      color: Colors.grey,
      child: Container(
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.all(10),
        color: Colors.white70,
        child: Column(
          children: [
            const Expanded(child: SizedBox()),
            SizedBox(
              width: 280,
              child: TextField(
                maxLines: 1,
                controller: udpController,
                decoration: InputDecoration(
                  hintText: Lang().serverAddress,
                  suffixIcon: IconButton(
                    iconSize: 20,
                    onPressed: () => udpController.clear(),
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 280,
              child: Tooltip(
                message: Lang().serverPort,
                child: TextField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(5),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  maxLines: 1,
                  controller: portController,
                  decoration: InputDecoration(
                    hintText: Lang().serverPort,
                    suffixIcon: IconButton(
                      iconSize: 20,
                      onPressed: () => portController.clear(),
                      icon: const Icon(Icons.clear),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Tooltip(
              message: Lang().longPressToGetAutomatically,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(280, 35),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                child: Text(Lang().confirm),
                onLongPress: () {
                  Tools().clentUDP(int.parse(portController.text)).then((String value) {
                    if (value.isNotEmpty) {
                      udpController.text = value.split(':')[0];
                      udpData = value;
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(Lang().theRequestFailed)),
                      );
                    }
                  });
                },
                onPressed: () {
                  print(udpData);
                },
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Lang().serverAddress)),
      body: mainWidget(context),
    );
  }
}
