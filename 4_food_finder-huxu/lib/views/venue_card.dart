import 'package:flutter/material.dart';
import 'package:food_finder/models/venue.dart';
import 'package:food_finder/views/venue_details.dart';

class VenueCard extends StatelessWidget {
  final Venue venue;
  final double userLatitude;
  final double userLongitude;
  final Color backgroundColor;

  VenueCard({
    required this.venue,
    required this.userLatitude,
    required this.userLongitude,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate distance from the user's location to the venue
    double distanceInMeters = venue.distanceInMeters(
      latitude: userLatitude,
      longitude: userLongitude,
    );

    // Determine if the venue has outdoor dining based on weather condition
    bool hasPatio =  venue.hasPatio;

    double distanceInKm = distanceInMeters / 1000;

    return GestureDetector(
      onTap: () {
        // Navigate to the venue details view
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VenueDetails(venue: venue, distanceInKm: distanceInKm, hasPatio: hasPatio, backgroundColor: backgroundColor, venueURL: venue.url),
          ),
        );
      },
      child: Semantics(
        label: venue.name,
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black, width: 2), // Set the border side and color
            borderRadius: BorderRadius.circular(10), // Set the border radius
          ),
          child: ListTile(
            tileColor: backgroundColor, // Set the background color
            title: Text(venue.name, style: TextStyle(color: Colors.black, fontSize: 20)),
            subtitle: Text('${distanceInKm.toStringAsFixed(2)} KM away', style: TextStyle(color: Colors.black, fontSize: 20)),
            trailing: hasPatio ? Icon(Icons.deck_sharp, color: Colors.black) : null,
          ),
        ),
      ),
    );
  }
}
