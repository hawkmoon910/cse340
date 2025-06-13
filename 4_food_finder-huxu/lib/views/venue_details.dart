import 'package:flutter/material.dart';
import 'package:food_finder/models/venue.dart';

class VenueDetails extends StatelessWidget {
  final Venue venue;
  final double distanceInKm;
  final bool hasPatio;
  final Color backgroundColor;
  final String venueURL;

  VenueDetails({
    required this.venue,
    required this.distanceInKm,
    required this.hasPatio,
    required this.backgroundColor,
    required this.venueURL
  });

  @override
  Widget build(BuildContext context) {
    String patio;
    if (hasPatio) {
      patio = 'Yes';
    } else {
      patio = 'No';
    }
    return Semantics(
    label: 'Venue Details: ${venue.name}',
      child: Scaffold(
        appBar: AppBar(
          title: Text(venue.name, style: TextStyle(color: Colors.black)),
          automaticallyImplyLeading: true, // Ensures the leading back button is announced
          backgroundColor: backgroundColor,
        ),
        backgroundColor: backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Venue Details:',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 8),
              Semantics(
                label: 'Name: ${venue.name}',
                child: Text(' Name: ${venue.name}', style: TextStyle(fontSize: 18, color: Colors.black)),
              ),
              Semantics(
                label: 'Distance: $distanceInKm kilometers away',
                child: Text(' Distance: $distanceInKm KM', style: TextStyle(fontSize: 18, color: Colors.black)),
              ),
              Semantics(
                label: 'Patio available: $patio',
                child: Text(' Patio: $patio', style: TextStyle(fontSize: 18, color: Colors.black)),
              ),
              Semantics(
                label: 'URL: $venueURL',
                child: Text(' URL: $venueURL', style: TextStyle(fontSize: 18, color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
