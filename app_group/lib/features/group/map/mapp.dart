import 'package:app_group/features/group/map/a.dart';
import 'package:app_group/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen(
      {super.key,
      this.add = true,
      this.latitude = 0,
      this.longitude = 0,
      this.myLocation = false});
  @override
  State<MapScreen> createState() => _MapScreenState();
  final bool? add;
  final double? latitude;
  final double? longitude;
  final bool? myLocation;
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  final MapController _mapController = MapController();
  LatLng? selectedLocation;
  late LatLng _selectedLocationinit;
  LatLng? _currentLocation;
  AnimationController? _animationController;
  Dio dio = Dio();
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // تحقق من تفعيل خدمة الموقع
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // إذا لم يتم تفعيل الخدمة، اطلب من المستخدم تفعيلها
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      // _mapController.move(_currentLocation!, 15.0);
      _animateMapMove(_currentLocation!, 15.0);
      prefs.setString("latitude", _currentLocation!.latitude.toString());
      prefs.setString("longitude", _currentLocation!.longitude.toString());
    });
  }

  void _animateMapMove(LatLng destLocation, double destZoom) {
    final latTween = Tween<double>(
        // ignore: deprecated_member_use
        begin: _mapController.center.latitude,
        end: destLocation.latitude);
    final lngTween = Tween<double>(
        // ignore: deprecated_member_use
        begin: _mapController.center.longitude,
        end: destLocation.longitude);
    // ignore: deprecated_member_use
    final zoomTween = Tween<double>(begin: _mapController.zoom, end: destZoom);
    _animationController?.dispose();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500), // مدة الحركة
      vsync: this,
    );

    Animation<double> animation =
        CurvedAnimation(parent: _animationController!, curve: Curves.easeInOut);

    _animationController!.addListener(() {
      _mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
      );
    });

    _animationController!.forward().then((_) {
      _animationController?.dispose();
      _animationController = null;
    });
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.myLocation == true) {
      _getCurrentLocation();
    }
    print(widget.latitude!);
    print(widget.longitude!);
    super.initState();
    if (widget.latitude == 0 || widget.longitude == 0) {
      _selectedLocationinit = const LatLng(32.472954, 44.434316);
    } else {
      _selectedLocationinit = LatLng(widget.latitude!, widget.longitude!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            DetailsFlutterMap(
              selectedLocationinit: _selectedLocationinit,
              add: widget.add,
              currentLocation: _currentLocation,
              mapController: _mapController,
              selectedLocation: selectedLocation,
            ),
            // widget.myLocation == true
            //     ? FloatingButtonAddlocationMap(
            //         add: widget.add,
            //         getCurrentLocation: _getCurrentLocation,
            //       )
            //     : const SizedBox(),
            // FloatingButtonAddlocationMap(
            //   add: false,
            //   getCurrentLocation: () {
            //     print(selectedLocation);
            //   },
            // ),

            // SearchBarMap(
            //   getSuggestions: _getSuggestions,
            //   onSuggestionSelected: _onSuggestionSelected,
            //   typeAheadController: _typeAheadController,
            // )
          ],
        ),
      ),
      // floatingActionButton: widget.add == false
      //     ? FloatingActionButton(
      //         heroTag: "btn1",
      //         onPressed: () {},
      //         child: const Icon(Icons.check),
      //       )
      //     : const SizedBox.shrink(),
    );
  }
}
