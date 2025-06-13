import 'package:flutter/material.dart';
import 'big_temp.dart';
import 'weather_condition_widget.dart';
import 'space_needle_in_a_circle.dart';
import '../weather_conditions.dart';

// Current weather stateless
class CurrentWeather extends StatelessWidget {
  const CurrentWeather({super.key, this.tempInFarenheit=42, this.condition=WeatherCondition.rainy});

  final WeatherCondition condition; // Current weather condition
  final int tempInFarenheit; // Current temperature

  // Builds a widget tree for current weather
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColorForCondition(condition), // Sets background color based on weather condition
      body: SingleChildScrollView(child:
        Center(child: 
          Column(
            children: [
              Container(height: 16),
              const Padding(
                padding:  EdgeInsets.all(16.0) // Padding
              ),
              const SpaceNeedleInACircle(), // Show Space Needle image
              BigTemp(tempInFarenheit), // Show current temperature
              WeatherConditionWidget(condition), // Show current weather condition
            ]
          )
        )
      )
    );
  }

  // Returns color based on the weather condition
  Color _backgroundColorForCondition(WeatherCondition condition){
    switch (condition) {
      case WeatherCondition.sunny: // When sunny
        return Color.fromARGB(255, 255, 225, 52); // Yellow
      case WeatherCondition.gloomy: // When gloomy/cloudy
        return Color.fromARGB(159, 255, 255, 255); // Grey
      case WeatherCondition.rainy: // When rainy
        return Color.fromARGB(255, 113, 172, 255); // Blue
    }
  }

}
