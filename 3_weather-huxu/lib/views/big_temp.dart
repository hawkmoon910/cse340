import 'package:flutter/material.dart';

class BigTemp extends StatelessWidget {
  final int tempInFarenheit;
  const BigTemp(this.tempInFarenheit, {super.key });

  // Returns a widget tree for temperature
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$tempInFarenheit degrees Farenheit', // Accessibility label for temperature
      child: Text( // Text
        '$tempInFarenheit°F', // Shows temperature with farenheit symbol
        style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold), // Adjusts font size and boldness
      ),
    );
  }
}