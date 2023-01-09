import 'package:client/public/lang.dart';
import 'package:flutter/material.dart';

const List<int> perPageDropList = <int>[10, 50, 100];

// 每页展示数据量
// ignore: must_be_immutable
class PerPageDataDropdownButton extends StatefulWidget {
  int perPageDropdownValue = perPageDropList.first;
  PerPageDataDropdownButton({super.key});

  @override
  State<PerPageDataDropdownButton> createState() =>
      _PerPageDataDropdownButton();
}

class _PerPageDataDropdownButton extends State<PerPageDataDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: widget.perPageDropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      style: const TextStyle(color: Colors.black),
      // elevation: 16,
      underline: Container(
        height: 0,
        // color: Colors.deepPurpleAccent,
      ),
      onChanged: (int? value) {
        setState(() {
          widget.perPageDropdownValue = value!;
        });
      },
      items: perPageDropList.map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
    );
  }
}

List<String> stateDropList = <String>[Lang().normal, Lang().disable];

// ignore: must_be_immutable
class StateDataDropdownButton extends StatefulWidget {
  String stateDropdownValue = stateDropList.first;
  StateDataDropdownButton({super.key});

  @override
  State<StateDataDropdownButton> createState() => _StateDataDropdownButton();
}

class _StateDataDropdownButton extends State<StateDataDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.stateDropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      style: const TextStyle(color: Colors.black),
      // elevation: 16,
      underline: Container(
        height: 0,
        // color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        setState(() {
          widget.stateDropdownValue = value!;
        });
      },
      items: stateDropList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
