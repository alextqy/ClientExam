import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.blueGrey),
    home: const Scaffold(
      body: Index(),
    ),
  ));
}

class Index extends StatelessWidget {
  const Index({super.key});

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
        child: const Text(
          "Manager",
          style: TextStyle(fontSize: 18),
        ),
        onPressed: () => {print("manager go")},
      ),
    );

    var teacherButton = Container(
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(180, 50),
            shadowColor: Colors.grey,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )),
        child: const Text(
          "Teacher",
          style: TextStyle(fontSize: 18),
        ),
        onPressed: () => {print("manager go")},
      ),
    );

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
      ),
    );
  }
}
