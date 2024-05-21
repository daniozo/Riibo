import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:geocode/geocode.dart';
import 'package:geodesy/geodesy.dart' as geo;
import 'package:latlong2/latlong.dart';

class LocationService {

  Future<Position> getCurrentLocation() async {
    try {
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
    } catch (e) {
      return getCurrentLocation();
    }
  }

  Future<Map<String, String>> getAddress(Position position) async {
    final geoCode = GeoCode();
    final address = await geoCode.reverseGeocoding(
        latitude: position.latitude, longitude: position.longitude);

    final street = address.streetAddress ?? '';
    final city = address.city ?? '';
    final country = address.countryName ?? '';

    return {
      'street': street,
      'city': city,
      'country': country
    };
  }

  Future<bool> hasLocationPermission() async {
    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  void requestLocationPermission() async {
    final permission = await Geolocator.checkPermission();
    print('Permission: \n${permission}');
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
    else if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
    }
  }

  Future<LocationPermission> permissionStatus() async {
    return await Geolocator.checkPermission();
  }

  double calculateDistance(LatLng point1, LatLng point2) {
    const geo.Distance distance = geo.Distance();

    return distance(
      geo.LatLng(point1.latitude, point1.longitude),
      geo.LatLng(point2.latitude, point2.longitude),
    );
  }
}
