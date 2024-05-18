import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riibo/services/location_service.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  MapViewState createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  late MapController controller;
  LatLng _currentPosition = const LatLng(0, 0);
  List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    controller = MapController();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await LocationService().getCurrentLocation();
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _updateMarkers();
        controller.move(_currentPosition, 15.75);
      });
    } catch (e) {
      print("Erreur lors de l'obtention de la position: $e");
    }
  }

  void _updateMarkers() {
    print(_currentPosition);
    final Marker userLocationIcon = Marker(
      point: _currentPosition,
      width: 100,
      height: 12,
      child: const Icon(
        CupertinoIcons.location_solid,
        color: CupertinoColors.systemOrange,
        size: 48,
      ),
    );

    setState(() {
      _markers = [userLocationIcon];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: controller,
          options: MapOptions(
            initialCenter: _currentPosition,
            initialZoom: 14.5,
            interactionOptions: const InteractionOptions(
              enableMultiFingerGestureRace: true,
            ),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
              subdomains: const ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: _markers,
            ),
          ],
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(
              top: 0,
              bottom: 0,
              left: 15,
              right: 5,
            ),
            decoration: const BoxDecoration(
              color: CupertinoColors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Carte",
                  style: TextStyle(
                    color: CupertinoColors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
                CupertinoButton(
                  child: const Text(
                    "Fermer",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: CupertinoColors.systemOrange,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: CupertinoButton(
            onPressed: _getCurrentLocation,
            child: Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                color: CupertinoColors.systemOrange,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                CupertinoIcons.location_fill,
                color: CupertinoColors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
