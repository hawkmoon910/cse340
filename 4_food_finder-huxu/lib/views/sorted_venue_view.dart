import 'package:flutter/material.dart';
import 'package:food_finder/models/venue.dart';
import 'package:food_finder/models/venues_db.dart';
import 'package:food_finder/providers/position_provider.dart';
import 'package:food_finder/providers/weather_provider.dart';
import 'package:food_finder/views/venue_grid_view.dart';

class SortedVenueView extends StatelessWidget {
  final VenuesDB venues;
  final PositionProvider positionProvider;
  final WeatherProvider weatherProvider;
  final Color backgroundColor;

  SortedVenueView({
    required this.venues,
    required this.positionProvider,
    required this.weatherProvider,
    required this.backgroundColor
  });

  @override
  Widget build(BuildContext context) {
    // Get the user's latitude and longitude from the PositionProvider
    double userLatitude = positionProvider.latitude ?? 0.0;
    double userLongitude = positionProvider.longitude ?? 0.0;

    // Get the list of venues sorted by distance from user's location
    List<Venue> sortedVenues = venues.nearestTo(
      latitude: userLatitude,
      longitude: userLongitude,
    );

    return Semantics(
      label: 'Sorted Venue View',
      child: VenueGridView(
        venues: sortedVenues,
        userLatitude: userLatitude,
        userLongitude: userLongitude,
        weatherProvider: weatherProvider,
        backgroundColor: backgroundColor,
      ),
    );
  }
}
