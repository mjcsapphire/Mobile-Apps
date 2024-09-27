import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class NetworkController extends GetxController {
  final _connectionStatus = RxList<ConnectivityResult>();

  final localDirectory = Directory('').obs;

  Stream<List<ConnectivityResult>> get connectionStatusStream =>
      _connectionStatus.stream;

  @override
  void onInit() {
    super.onInit();
    fetchLocal();

    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      _connectionStatus.value = result;
    });

    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {});
  }

  Future<void> fetchLocal() async {
    localDirectory.value = await getApplicationDocumentsDirectory();
  }

  List<ConnectivityResult> get connectionStatus => _connectionStatus;
  bool get isOnline => _connectionStatus.first != ConnectivityResult.none;
}
