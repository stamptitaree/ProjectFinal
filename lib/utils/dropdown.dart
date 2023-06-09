import 'package:flutter/material.dart';

class Dropdowndisease extends StatefulWidget {
  const Dropdowndisease({Key? key}) : super(key: key);

  @override
  State<Dropdowndisease> createState() => _DropdowndiseaseState();
}

class _DropdowndiseaseState extends State<Dropdowndisease> {
  String? item = 'item';
  List<String> items = ['item1', 'item2', 'item3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DropdownButton<String>(
          value: item,
          items: items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          onChanged: (String? newvalue) => setState(() => item = newvalue),
        ),
      ),
    );
  }
}
