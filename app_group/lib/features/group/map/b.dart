import 'package:flutter/material.dart';

class FloatingButtonAddlocationMap extends StatelessWidget {
  const FloatingButtonAddlocationMap({super.key, this.add, this.getCurrentLocation});
  final bool? add;
  final void Function()? getCurrentLocation;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: add == false ? 100 : 40,
      right: 16.0,
      child: FloatingActionButton(
        onPressed: getCurrentLocation,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}