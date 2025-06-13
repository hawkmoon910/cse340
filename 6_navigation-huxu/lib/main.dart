import 'package:flutter/material.dart';
import 'package:navigation/views/custom_widget1.dart';
import 'package:navigation/views/custom_widget2.dart';
import 'package:navigation/views/custom_widget3.dart';
import 'package:navigation/views/custom_widget4.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const NavDemo(title: 'Navigation Demo for 340'),
    );
  }
}

class NavDemo extends StatefulWidget {
  const NavDemo({super.key, required this.title});
  final String title;

  @override
  State<NavDemo> createState() => _NavDemoState();
}

class _NavDemoState extends State<NavDemo> {
  
  // We will use this to keep track of what tab is selected
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index){
          setState((){ // Executes code and then causes widget to re-build()
            _currentTabIndex = index;
          });
        },
        indicatorColor: theme.primaryColor,
        selectedIndex: _currentTabIndex,

        // This defines what is in the nav bar 
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.alarm), label: 'Widget 1' ),
          NavigationDestination(icon: Icon(Icons.phone), label: 'Widget 2'),
          NavigationDestination(icon: Icon(Icons.donut_large_outlined), label: 'Widget 3'),
          NavigationDestination(icon: Icon(Icons.safety_check), label: 'Widget 4'),
        ],
      ),
      
      // Here we choose how to populate the body using the current value of _currentTabIndex
      body: Center(child: 
        switch (_currentTabIndex) {
          0 => const CustomWidget1(),
          1 => const CustomWidget2(),
          2 => const CustomWidget3(),
          3 => const CustomWidget4(),
          _ => const Placeholder(),
        }
      )
    );
  }
}