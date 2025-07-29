import 'package:geolocator/geolocator.dart';

abstract class AppLocation {
  Future<Position?> determinePosition();
}

class AppLocationImpl implements AppLocation {
  @override
  Future<Position?> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      permission = await Geolocator.requestPermission();
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      return null;
    }
    final lastLocation = await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.best));
    return lastLocation;
  }
}
