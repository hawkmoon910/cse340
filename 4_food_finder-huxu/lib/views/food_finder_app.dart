import 'package:flutter/material.dart';
import 'package:food_finder/models/venues_db.dart';
import 'package:food_finder/helpers/weather_checker.dart';
import 'package:food_finder/providers/weather_conditions.dart';
import 'package:food_finder/views/sorted_venue_view.dart';
import 'package:provider/provider.dart';
import 'package:food_finder/providers/position_provider.dart';
import 'package:food_finder/providers/weather_provider.dart';
import 'dart:async';



class FoodFinderApp extends StatefulWidget {
  final VenuesDB venues;

  const FoodFinderApp({super.key, required this.venues});

  @override
  State<FoodFinderApp> createState() => _FoodFinderAppState();
}



class _FoodFinderAppState extends State<FoodFinderApp> {
  late final Timer _checkerTimer;
  late final WeatherChecker _weatherChecker;

  @override
  initState(){
    super.initState();

    // Weather provider
    final singleUseWeatherProvider = Provider.of<WeatherProvider>(context, listen: false);
    _weatherChecker = WeatherChecker(singleUseWeatherProvider);
    // Setup a timer to periodically check the weather every minute
    _checkerTimer = Timer.periodic(Duration(minutes: 1), (Timer timer) {
      _weatherChecker.fetchAndUpdateCurrentSeattleWeather();
    }); 

    // This way we don't have to wait a minute from after the app starts to first attempt a weather check.
    _weatherChecker.fetchAndUpdateCurrentSeattleWeather();


  }

  @override 
  dispose(){
    _checkerTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = _backgroundColorForCondition(context.watch<WeatherProvider>().condition);
    return  MaterialApp(
      home: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Semantics(
                label: 'Food Finder',
                child: Text('Food Finder', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              centerTitle: true,
              backgroundColor: backgroundColor,
            ),

          // This is how you can consume from two providers at once without 
          // needing to nest Consumers inside each other 
          body: Consumer2<PositionProvider, WeatherProvider>( 
            builder: (context, positionProvider, weatherProvider, child) {
              // If position is known, call weatherChecker.updateLocation with our current position
              if (positionProvider.positionKnown) {
                  _weatherChecker.updateLocation(
                    positionProvider.latitude!,
                    positionProvider.longitude!,
                  );
              }
              return Semantics(
                label: 'List of venues',
                child: SortedVenueView(
                  venues: widget.venues,
                  positionProvider: positionProvider,
                  weatherProvider: weatherProvider,
                  backgroundColor: backgroundColor,
                ),
              );
            },
          ),
        ),
      )
    );
  }

  // Returns color based on the weather condition
  Color _backgroundColorForCondition(WeatherCondition condition){
    switch (condition) {
      case WeatherCondition.sunny: // When sunny
        return Colors.yellow; // Yellow
      case WeatherCondition.gloomy: // When gloomy/cloudy
        return Color.fromARGB(120, 145, 130, 130); // Grey
      case WeatherCondition.rainy: // When rainy
        return Colors.lightBlue; // Blue
      case WeatherCondition.unknown: // When unknown
        return Color.fromARGB(255, 26, 165, 84); // Emerald green
    }
  }
}
