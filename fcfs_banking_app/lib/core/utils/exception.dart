import 'package:flutter/cupertino.dart';

class ServerException implements Exception {
  final int? code;
  final String? message;

  ServerException({
    this.code = 404,
    this.message = 'Could not process your request at the moment.',
  });

  @override
  String toString() {
    debugPrint(message);
    return super.toString();
  }
}

class ClientException implements Exception {
  final int? code;
  final String? message;

  ClientException({
    this.code = 400,
    this.message = 'Could not process your request at the moment.',
  });

  @override
  String toString() {
    debugPrint(message);
    return super.toString();
  }
}
