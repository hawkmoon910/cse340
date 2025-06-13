import 'package:flutter/material.dart';
import 'package:food_finder/providers/weather_conditions.dart';

// Weather provider
class WeatherProvider extends ChangeNotifier {
  int _tempInFarenheit = 0; // Default temperature
  WeatherCondition _condition = WeatherCondition.unknown; // Default weather condition
  bool _weatherUpdate = false; // Weather update status

  int get tempInFarenheit => _tempInFarenheit; // Getter for temperature
  WeatherCondition get condition => _condition; // Getter for weather condition
  bool get weatherUpdate => _weatherUpdate; // Getter for weather update staus

  // Updates the weather
  updateWeather(int newTempFarenheit, WeatherCondition newCondition){
    _tempInFarenheit = newTempFarenheit; // Updates temperature
    _condition = newCondition; // Updates weather condition
    _weatherUpdate = true; // Set weather update status to true
    notifyListeners(); // Tells listeners that UI will update
  }
}