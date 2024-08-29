import 'package:flutter_application_1/core/api/end_points.dart';

class ErrorModel {
  final int success;
  final String message;

  ErrorModel({required this.success, required this.message});
  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    return ErrorModel(
        success: jsonData[ApiKey.success],
         message: jsonData[ApiKey.message]);
  }
}
