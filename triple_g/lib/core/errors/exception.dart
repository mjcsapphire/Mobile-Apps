import 'package:flutter/material.dart';

class ServerException implements Exception {
  final int? code;
  final String? message;

  ServerException(
      {this.code = 404, this.message = "Could not process your request"});

  @override
  String toString() {
    debugPrint("$message,$code");
    return super.toString();
  }
}
