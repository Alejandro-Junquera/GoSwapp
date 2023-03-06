import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geocoding/geocoding.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late MapController mapController;
  String location = '';
  List<Location> locations = [];
  getLocation(String direccion) async {
    locations = await locationFromAddress(direccion);
  }

  getRuta() {
    Timer timer = Timer(const Duration(seconds: 2), () async {
      GeoPoint geoPoint = await mapController.myLocation();
      RoadInfo roadInfo = await mapController.drawRoad(
        geoPoint,
        GeoPoint(
            latitude: locations[0].latitude, longitude: locations[0].longitude),
        roadType: RoadType.car,
        intersectPoint: [
          geoPoint,
          GeoPoint(
              latitude: locations[0].latitude,
              longitude: locations[0].longitude),
        ],
        roadOption: RoadOption(
          roadWidth: 10,
          roadColor: Colors.blue,
          zoomInto: true,
        ),
      );
      print("${roadInfo.distance}km");
      print("${roadInfo.duration}sec");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mapController = MapController(
      initMapWithUserPosition: true,
    );

    getRuta();
  }

  @override
  Widget build(BuildContext context) {
    final direccion = ModalRoute.of(context)!.settings.arguments as String;
    getLocation(direccion);
    return Scaffold(
        appBar: AppBar(title: Text('Mapa')),
        body: OSMFlutter(
          controller: mapController,
          trackMyPosition: true,
          initZoom: 15,
          minZoomLevel: 8,
          maxZoomLevel: 19,
          stepZoom: 1.0,
          userLocationMarker: UserLocationMaker(
            personMarker: MarkerIcon(
              icon: Icon(
                Icons.location_history_rounded,
                color: Colors.green,
                size: 48,
              ),
            ),
            directionArrowMarker: MarkerIcon(
              icon: Icon(
                Icons.double_arrow,
                size: 48,
              ),
            ),
          ),
          roadConfiguration: RoadOption(
            roadColor: Colors.yellowAccent,
          ),
          markerOption: MarkerOption(
              defaultMarker: MarkerIcon(
            icon: Icon(
              Icons.person_pin_circle,
              color: Colors.blue,
              size: 56,
            ),
          )),
        ));
  }
}
