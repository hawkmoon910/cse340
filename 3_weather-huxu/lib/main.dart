import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/providers/weather_provider.dart';
import 'package:weather/views/live_weather.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  // Returns a widget tree with WeatherApp UI
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(), // Provides WeatherProvider to the widget tree
      child:  const MaterialApp(
        home: LiveWeather() // Set LiveWeather to home screen
      )
    );
  }
}
