import 'package:json_annotation/json_annotation.dart';
import 'dart:math';

part 'venue.g.dart';

// See documentation here https://docs.flutter.dev/data-and-backend/serialization/json#creating-model-classes-the-json_serializable-way
// After changing this class, it is essential to run `dart run build_runner build --delete-conflicting-outputs` from the root of the project.


@JsonSerializable()
class Venue{
  Venue({required this.name, 
         required this.latitude, 
         required this.longitude, 
         required this.hasPatio,
         required this.url});
  
  final String name;
  final double latitude;
  final double longitude;
  final String url;

  @JsonKey(name: 'has_patio')
  final bool hasPatio;

  factory Venue.fromJson(Map<String, dynamic> json) => _$VenueFromJson(json);
  Map<String, dynamic> toJson() => _$VenueToJson(this);

  double distanceFrom({required double latitude, required double longitude}) {
    // Pythagorean theorem
    double x = this.latitude - latitude;
    double y = this.longitude - longitude;
    return sqrt(_squared(x) + _squared(y));
  }

  double distanceInMeters({required double latitude, required double longitude}){
    return 111139 * distanceFrom(latitude: latitude, longitude: longitude);
  }

  num _squared(num x) { return x * x; }
}