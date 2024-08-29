import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';


class SearchBarMap extends StatelessWidget {
  const SearchBarMap(
      {super.key,
      this.onSuggestionSelected,
      this.typeAheadController,
      required this.getSuggestions});
  final TextEditingController? typeAheadController;
  final void Function(String)? onSuggestionSelected;

  final FutureOr<List<String>?> Function(String) getSuggestions;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      child: TypeAheadField<String>(
        animationDuration: Durations.extralong1,
        autoFlipMinHeight: 20,
        builder: (context, controller, focusNode) {
          return Container(
            width: 361,
            height: 50,
            margin: const EdgeInsets.only(left: 5, top: 10),
            padding: const EdgeInsets.only(left: 20, top: 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextField(
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              controller: typeAheadController,
              focusNode: focusNode,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'City',
                icon: Icon(Icons.search),
              ),
            ),
          );
        },
        controller: typeAheadController,
        debounceDuration: const Duration(milliseconds: 500),
        suggestionsCallback: getSuggestions,
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(suggestion),
          );
        },
        onSelected: onSuggestionSelected,
      ),
    );
  }
}