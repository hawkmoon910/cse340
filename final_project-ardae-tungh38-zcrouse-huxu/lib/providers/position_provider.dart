import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

/// A provider class that providers the position of the current device. Defaults to have
/// positionIsKnown to false until it is updated.
class PositionProvider extends ChangeNotifier {
  PositionProvider() {
    print('Making position provider');
    _timerUpdate();
    // Initializes timer to update location
    _updateTimer = Timer.periodic(
      const Duration(seconds: 30), 
      (_) => _timerUpdate()
      );
  }

  @override
  void dispose() {
    _updateTimer.cancel();
    super.dispose();
  }

  late Timer _updateTimer;
  double latitude = 0.0;
  double longitude = 0.0;
  bool positionIsKnown = false;
  
  Placemark? address;
  bool addressIsKnown = false;

  /// Updates position of provider and notifies listerns once updated.
  void _updatePosition(double newLatitude, double newLongitude) {
    latitude = newLatitude;
    longitude = newLongitude;
    positionIsKnown = true;
    notifyListeners();
  }

  /// Updates the position to the state of being unknown. This is used in case of the
  /// user's location being turned off or if there was an error.
  void updatePositionUnknown() {
    latitude = 0;
    longitude = 0;
    positionIsKnown = false;
    notifyListeners();
  }

  /// Updates the current address and notifies listeners. Also updates addressIsKnown
  /// to be true if it was false.
  /// Parameters:
  ///   newAddress - A placemark to update the address of the provider to
  void _updateAddress(Placemark newAddress) {
    address = newAddress;
    addressIsKnown = true;
    notifyListeners();
  }

  /// Callback function for timer. Gets current position asynchronously and then updates 
  /// provider's position.
  void _timerUpdate() async {
    print('Updating Position');
    _determinePosition().then(
      (position) async { 
        _updatePosition(position.latitude, position.longitude);
        List<Placemark> addresses = await placemarkFromCoordinates(latitude, longitude);
        if (addresses.isNotEmpty) {
          print('Updating Address');
          _updateAddress(addresses[0]);
        }
      }
    ).onError(
      (error, stackTrace) => null
    );
    
  }

  /// Determine the latitude and longitude current position of the device.
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the 
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale 
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately. 
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    } 

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

}