import 'package:geolocator/geolocator.dart';

abstract class AppLocation {
  Future<AppLatLong> getCurrentLocation();

  Future<bool> requestPermission();

  Future<bool> checkPermission();
}

class LocationService implements AppLocation {
  final defLocation = const BishkekLocation();

  @override
  Future<AppLatLong> getCurrentLocation() async {
    return Geolocator.getCurrentPosition().then((value) {
      return AppLatLong(lat: value.latitude, long: value.longitude);
    }).catchError(
      (_) => defLocation,
    );
  }

  @override
  Future<bool> requestPermission() {
    return Geolocator.requestPermission()
        .then((value) =>
            value == LocationPermission.always ||
            value == LocationPermission.whileInUse)
        .catchError((_) => false);
  }

  @override
  Future<bool> checkPermission() {
    return Geolocator.checkPermission()
        .then((value) =>
            value == LocationPermission.always ||
            value == LocationPermission.whileInUse)
        .catchError((_) => false);
  }
}

class AppLatLong {
  final double lat;
  final double long;

  const AppLatLong({
    required this.lat,
    required this.long,
  });
}

class BishkekLocation extends AppLatLong {
  const BishkekLocation({
    super.lat = 42.882004,
    super.long = 74.582748,
  });
}
