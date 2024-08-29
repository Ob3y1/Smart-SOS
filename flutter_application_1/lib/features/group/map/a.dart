import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// ignore: must_be_immutable
class DetailsFlutterMap extends StatefulWidget {
  DetailsFlutterMap({
    super.key,
    this.mapController,
    required this.selectedLocationinit,
    this.currentLocation,
    this.selectedLocation,
    this.add,
  });

  final MapController? mapController;
  final LatLng selectedLocationinit;
  final LatLng? currentLocation;
  LatLng? selectedLocation;

  final bool? add;

  @override
  State<DetailsFlutterMap> createState() => _DetailsFlutterMapState();
}

class _DetailsFlutterMapState extends State<DetailsFlutterMap> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: widget.mapController,
      options: MapOptions(
        initialCenter: widget.selectedLocationinit,
        initialZoom: 10.0,
        onTap: widget.add!
            ? (tapPosition, point) {
                setState(() {
                  widget.selectedLocation = point;
                });
              }
            : null,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        ),
        MarkerLayer(
          markers: [
            if (widget.currentLocation != null)
              Marker(
                width: 80.0,
                height: 80.0,
                point: widget.currentLocation!,
                child: const Icon(
                  Icons.my_location,
                  color: Colors.blue,
                  size: 32.0,
                ),
              ),
            Marker(
              width: 80.0,
              height: 80.0,
              point: widget.selectedLocationinit,
              child: const Icon(
                Icons.location_pin,
                color: Colors.green,
                size: 40.0,
              ),
            ),
            if (widget.selectedLocation != null && widget.add == true)
              Marker(
                width: 80.0,
                height: 80.0,
                point: widget.selectedLocation!,
                child: const Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 40.0,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
