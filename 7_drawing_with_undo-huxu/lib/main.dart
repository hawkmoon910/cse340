import 'package:drawing_with_undo/providers/drawing_provider.dart';
import 'package:drawing_with_undo/views/draw_area.dart';
import 'package:drawing_with_undo/views/palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  const drawAreaWidth = 400.0;
  const drawAreaHeight = 400.00;
  runApp(
    ChangeNotifierProvider(
      create: (context) => DrawingProvider(width: drawAreaWidth, height: drawAreaHeight) , 
      child: const MainApp(width: drawAreaWidth, height: drawAreaHeight)
    )
  );
}


class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.width, required this.height});

  final double width;
  final double height; 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Drawing App'),
          actions: <Widget>[
            Semantics(
              label: 'undo',
              child: IconButton(
                icon: const Icon(Icons.undo),
                onPressed: () {
                  final provider = Provider.of<DrawingProvider>(context, listen: false);
                  provider.undo();
                },
              ),
            ),
            Semantics(
              label: 'redo',
              child: IconButton(
                icon: const Icon(Icons.redo),
                onPressed: () {
                  final provider = Provider.of<DrawingProvider>(context, listen: false);
                  provider.redo();
                }
              ),
            ),
            Semantics(
              label: 'clear',
              child: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  final provider = Provider.of<DrawingProvider>(context, listen: false);
                  provider.clear();
                }
              ),
            )
          ]
        ),
        drawer: Drawer(
          child: Palette(context),
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: DrawArea(width: width, height: height),
          ),
        ),
      ),
    );
  }


}
