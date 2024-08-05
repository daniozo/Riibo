import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  bool _isLocationChanged = false;
  late StreamSubscription<Position> _positionStreamSubscription;

  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  LocationProvider() {
    // Écouter les changements de cycle de vie de l'application
    WidgetsBinding.instance?.addObserver(AppLifecycleObserver(this));
  }

  bool get isLocationChanged => _isLocationChanged;

  // Méthode pour démarrer l'écoute de la position
  void _startListening() async {
    _positionStreamSubscription =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      print(position == null
          ? 'Unknown'
          : '${position.latitude.toString()}, ${position.longitude.toString()}');

      _isLocationChanged = true;
      notifyListeners();
    });
  }

  // Méthode pour arrêter l'écoute de la position
  void _stopListening() {
    _positionStreamSubscription.cancel();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(AppLifecycleObserver(this));
    _stopListening();
    super.dispose();
  }
}

// Observer du cycle de vie de l'application
class AppLifecycleObserver extends WidgetsBindingObserver {
  final LocationProvider locationProvider;

  AppLifecycleObserver(this.locationProvider);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        // L'application est active, démarrer l'écoute
        locationProvider._startListening();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        // L'application est en arrière-plan ou fermée, arrêter l'écoute
        locationProvider._stopListening();
        break;
      default:
        break;
    }
  }
}
