import 'package:geolocator/geolocator.dart';

abstract class LocationService {
  Future<Position> getCurrentPosition();
}

class LocationServiceImpl implements LocationService {
  @override
  Future<Position> getCurrentPosition() async {
    final permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      final requested = await Geolocator.requestPermission();
      if (requested == LocationPermission.denied ||
          requested == LocationPermission.deniedForever) {
        throw Exception('Location permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permission is permanently denied');
    }

    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.low,
      ),
    );

    return position;
  }
}
