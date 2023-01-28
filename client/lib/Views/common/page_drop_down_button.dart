// import 'package:client/public/lang.dart';
// import 'package:flutter/material.dart';

// // 每页展示数据量
// // ignore: must_be_immutable
// class PerPageDataDropdownButton extends StatefulWidget {
//   List<int> perPageDropList = <int>[10, 50, 100];
//   late int perPageDropdownValue;
//   PerPageDataDropdownButton({super.key}) {
//     perPageDropdownValue = perPageDropList.first;
//   }

//   @override
//   State<PerPageDataDropdownButton> createState() =>
//       _PerPageDataDropdownButton();
// }

// class _PerPageDataDropdownButton extends State<PerPageDataDropdownButton> {
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<int>(
//       itemHeight: 50,
//       value: widget.perPageDropdownValue,
//       icon: const Icon(Icons.arrow_drop_down),
//       style: const TextStyle(color: Colors.black),
//       // elevation: 16,
//       underline: Container(
//         height: 0,
//         // color: Colors.deepPurpleAccent,
//       ),
//       onChanged: (int? value) {
//         setState(() {
//           widget.perPageDropdownValue = value!;
//         });
//       },
//       items: widget.perPageDropList.map<DropdownMenuItem<int>>((int value) {
//         return DropdownMenuItem<int>(
//           value: value,
//           child: Text(value.toString()),
//         );
//       }).toList(),
//     );
//   }
// }

// // ignore: must_be_immutable
// class StateDataDropdownButton extends StatefulWidget {
//   List<String> stateDropList = <String>[Lang().normal, Lang().disable];
//   late String stateDropdownValue;
//   StateDataDropdownButton({super.key}) {
//     stateDropdownValue = stateDropList.first;
//   }

//   @override
//   State<StateDataDropdownButton> createState() => _StateDataDropdownButton();
// }

// class _StateDataDropdownButton extends State<StateDataDropdownButton> {
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       itemHeight: 50,
//       value: widget.stateDropdownValue,
//       icon: const Icon(Icons.arrow_drop_down),
//       style: const TextStyle(color: Colors.black),
//       // elevation: 16,
//       underline: Container(
//         height: 0,
//         // color: Colors.deepPurpleAccent,
//       ),
//       onChanged: (String? value) {
//         setState(() {
//           widget.stateDropdownValue = value!;
//         });
//       },
//       items: widget.stateDropList.map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
// }
