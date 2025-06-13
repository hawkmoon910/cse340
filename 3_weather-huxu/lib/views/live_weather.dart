import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/helpers/weather_checker.dart';
import 'package:weather/providers/weather_provider.dart';
import 'package:weather/views/big_temp.dart';
import 'package:weather/views/space_needle_in_a_circle.dart';
import 'package:weather/views/weather_condition_widget.dart';
import 'package:weather/weather_conditions.dart';

// Live weather stateful
class LiveWeather extends StatefulWidget {
  const LiveWeather({super.key});

  @override
  State<LiveWeather> createState() => _LiveWeatherState();
}

class _LiveWeatherState extends State<LiveWeather> {
  late WeatherChecker _weatherChecker;
  late Timer _weatherCheckerTimer;
  
  // Returns a widget tree for Live Weather at location
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, child){
        if(!weatherProvider.weatherUpdate) { // Checks if weather is being updated
          return Center(
            child: CircularProgressIndicator(), // Show a loading screen
          );
        } else { // Weather isn't being updated
          final currentTempInFarenheit = weatherProvider.tempInFarenheit; // Sets to current temperature
          final currentCondition = weatherProvider.condition; // Sets to current weather condition
          return Scaffold(
            backgroundColor: _backgroundColorForCondition(currentCondition), // Sets background color based on weather condition
            body: SingleChildScrollView(child:
              Center(child: 
                Column(
                  children: [
                    Container(height: 16),
                    const Padding(
                      padding:  EdgeInsets.all(16.0) //Padding
                    ),
                    const SpaceNeedleInACircle(), // Show Space Needle image
                    BigTemp(currentTempInFarenheit), // Show current temperature
                    WeatherConditionWidget(currentCondition), // Show current weather condition
                  ]
                )
              )
            )
          );
        }
      }
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

  // Initstate
  @override
  initState(){
    super.initState();

    // Weather provider
    final singleUseWeatherProvider = Provider.of<WeatherProvider>(context, listen: false);
    _weatherChecker = WeatherChecker(singleUseWeatherProvider);

    // Fetch and update the current weather
    _weatherChecker.fetchAndUpdateCurrentSeattleWeather();

    // Setup a timer to periodically check the weather every minute
    _weatherCheckerTimer = Timer.periodic(Duration(minutes: 1), (Timer timer) {
      _weatherChecker.fetchAndUpdateCurrentSeattleWeather();
    });
  }

  // Ends time to prevent memory leaks
  @override
  void dispose() {
    _weatherCheckerTimer.cancel(); // Cancels the timer
    super.dispose();
  }
}