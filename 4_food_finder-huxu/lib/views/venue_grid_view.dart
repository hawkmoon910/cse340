import 'package:flutter/material.dart';
import 'package:food_finder/models/venue.dart';
import 'package:food_finder/providers/weather_conditions.dart';
import 'package:food_finder/providers/weather_provider.dart';
import 'package:food_finder/views/venue_card.dart';

class VenueGridView extends StatelessWidget {
  final List<Venue> venues;
  final double userLatitude;
  final double userLongitude;
  final WeatherProvider weatherProvider;
  final Color backgroundColor;

  VenueGridView({
    required this.venues,
    required this.userLatitude,
    required this.userLongitude,
    required this.weatherProvider,
    required this.backgroundColor
  });

  @override
  Widget build(BuildContext context) {
    List<Venue> sortedVenues = venues..sort((a, b) {
      // If it's sunny, prioritize venues with patios
      if (weatherProvider.condition == WeatherCondition.sunny) {
        if (a.hasPatio && !b.hasPatio) {
          return -1;
        } else if (!a.hasPatio && b.hasPatio) {
          return 1;
        } else {
          return 0;
        }
      } else {
        // For other weather conditions, prioritize based on distance only
        double distanceA = a.distanceInMeters(latitude: userLatitude, longitude: userLongitude);
        double distanceB = b.distanceInMeters(latitude: userLatitude, longitude: userLongitude);
        return distanceA.compareTo(distanceB);
      }
    });

    return Semantics(
      label: 'Venue Grid View', // Provide a label for the entire grid view
      child: Container(
        color: backgroundColor,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns
            crossAxisSpacing: 8.0, // Spacing between columns
            mainAxisSpacing: 8.0, // Spacing between rows
            childAspectRatio: 1.1,
          ),
          itemCount: sortedVenues.length,
          itemBuilder: (context, index) {
            return Semantics(
              label: 'Venue Card ${sortedVenues[index].name}', // Provide a label for each venue card
              child: VenueCard(
                venue: sortedVenues[index],
                userLatitude: userLatitude,
                userLongitude: userLongitude,
                backgroundColor: backgroundColor,
              ),
            );
          },
        ),
      ),
    );
  }

}
