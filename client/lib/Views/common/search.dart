import 'package:flutter/cupertino.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key, required this.fieldValue});

  final ValueChanged<String> fieldValue;

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      // onChanged: (String value) {
      //   fieldValue(value);
      // },
      onSubmitted: (String value) {
        fieldValue(value);
      },
    );
  }
}
