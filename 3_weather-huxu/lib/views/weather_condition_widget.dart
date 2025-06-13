import 'package:flutter/material.dart';
import 'package:weather/weather_conditions.dart';

class WeatherConditionWidget extends StatelessWidget {
  const WeatherConditionWidget(this.condition, {super.key });

  final WeatherCondition condition; // Current weather condition

  // Builds a widget tree for possible weather conditions
  @override
  Widget build(BuildContext context) {
    final IconData iconToShow; // The icon to show
    final String textToShow; // The text to show

    switch (condition) {
      case WeatherCondition.sunny: // When sunny
        iconToShow = Icons.sunny; // Set icon to sun
        textToShow = 'Sunny'; // Set text to sunny
      case WeatherCondition.gloomy: // When gloomy/cloudy
        iconToShow = Icons.cloud; // Set icon to cloud
        textToShow = 'Gloomy'; // Set text to gloomy
      case WeatherCondition.rainy: // When rainy
        iconToShow = Icons.water_drop; // Set icon to water droplet
        textToShow = 'Rainy'; // Set text to rainy
    }
    return Semantics(
      label: textToShow, // Accessibility label for text
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconToShow), // Shows icon based on weather condition
          Text( // Text
            textToShow, // Shows text based on weather condition
            style: TextStyle(fontSize: 48) // Adjusts font size
          ),
        ]
      ),
    );
  }
}