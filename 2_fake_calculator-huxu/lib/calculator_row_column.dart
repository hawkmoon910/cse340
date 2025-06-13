import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CalculatorRowColumn extends StatelessWidget {
  CalculatorRowColumn({super.key}): _darkGreyBackgroundColor = const Color.fromARGB(255, 51, 51, 51);
  final Color _darkGreyBackgroundColor;

  final _buttonSpecification = [
    ['AC', Icons.exposure, '%', '÷'],
    [7, 8, 9, 'x'],
    [4, 5, 6, '-'],
    [1, 2, 3, '+'],
    [0, '.', '=']
  ];

  @override
  Widget build(BuildContext context) {
    //debugPaintSizeEnabled = true;
    return Container( 
      color: Colors.black,
      width: 305,
      height: 675,
      child: Column(
          children: [
            Container(
              height: 100,
            ),
            _makeNumberDisplay(),
            _makeInputUIFromData(),
          ],
        ),
    );
  }

  _makeNumberDisplay(){
    return Semantics(
      label: '0',
      child: const Align(
        alignment: Alignment.centerRight, 
        child: Text(
          '0  ',
          style: TextStyle(fontSize: 64, color: Colors.white),
        ),
      ),
    );
  }

  _makeInputUIFromData(){
    return Column(
      children: _makeButtonRows()
    );
  }

  _makeButtonRows(){
    return _buttonSpecification.map((row) {
      return Row(
        children: row.map<Widget>((entry) {
          if (entry == 0) {
            return _makeExpandedButton(
              _makeWideButton(
                child: const Text(
                  '0',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: _darkGreyBackgroundColor,
              ). child,
              2,
            );
          } else {
            return _makeButtonFromSpecificationEntry(entry);
          }
        }).toList(),
      );
    }).toList();
  }

  Widget _makeButtonFromSpecificationEntry(entry){
    final rightColumnSymbols = ['÷', 'x', '-', '+', '='];

    if (entry is int){
      return _makeCircularButton(
        child: Semantics(
          label: entry.toString(),
          child: Text(
            entry.toString(),
            style: const TextStyle(fontSize: 24 , color: Colors.white)
          ),
        ),
        backgroundColor: _darkGreyBackgroundColor
      );
    } else if ( entry is IconData){
      return _makeCircularButton(
        child: Semantics(
          label: 'Negative',
          child: Icon(
            entry,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.grey
      );
    } else if ( entry is String){
      if (entry == 'AC' || entry == '%') {
        return _makeCircularButton(
          child: Semantics(
            label: entry,
            child: Text(
              entry,
              style: const TextStyle(fontSize: 24, color: Colors.black,)
            ),
          ),
          backgroundColor: Colors.grey
        );
      } else if (entry == '.') {
        return _makeCircularButton(
          child: Semantics(
            label: 'Decimal Point',
            child: Text(
              entry,
              style: const TextStyle(fontSize: 24, color: Colors.white,)
            ),
          ),
          backgroundColor: _darkGreyBackgroundColor
        );
      } else {
        return _makeCircularButton(
          child: Semantics(
            label: entry,
            child: Text(
              entry,
              style: const TextStyle(fontSize: 24, color: Colors.white,)
            ),
          ),
          backgroundColor: Colors.orange
        );
      }
    } else { // This should never be used, but makes sure we always return a widget, even if our _buttonSpecification includes something we didn't anticipate
      return const Placeholder();
    }
  }

  _makeExpandedButton(ElevatedButton button, int flex){
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: button,
      ),
    );
  }

  _makeCircularButton({required Widget child, required Color backgroundColor}){
     return Container(
      margin: const EdgeInsets.all(3),
      width: 70,
      height: 70,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: const CircleBorder(),
        ),
        child: child,
      ),
    );
  }

  _makeWideButton({required Widget child, required Color backgroundColor}){
    // return ElevatedButton(
    //   onPressed: () {},
    //   style: ElevatedButton.styleFrom(
    //     backgroundColor: _darkGreyBackgroundColor,
    //     shape: StadiumBorder(),
    //   ),
    //   child: child,
    // );
    return SizedBox(
      width: 70,
      height: 70,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: const StadiumBorder(),
        ),
        child: child,
      ),
    );
  }



}