import 'dart:async';
import 'package:connectinno_case_client/core/connectivity/i_connectivity_service.dart';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

/// An implementation of [IConnectivityService] that uses the `connectivity_plus` package.
class ConnectivityServiceImpl extends ChangeNotifier implements IConnectivityService {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  bool _isOnline = false; // Assume offline by default until the first check.

  @override
  bool get isOnline => _isOnline;

  ConnectivityServiceImpl() {
    // Listen to connectivity changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  Future<void> initialize() async {
    final result = await _connectivity.checkConnectivity();
    await _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    final hasConnection =
        result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi);

    // If device is connected to mobile or wifi, double check with actual internet connectivity
    final newIsOnline = hasConnection
        ? await _checkInternetConnectivity()
        : false;
    
    // Only notify listeners if the connectivity status has actually changed
    if (newIsOnline != _isOnline) {
      _isOnline = newIsOnline;
      notifyListeners();
    }
  }

  /// Performs an actual internet connectivity check using HTTP request.
  Future<bool> _checkInternetConnectivity() async {
    try {
      final response = await http
          .get(Uri.parse("https://clients3.google.com/generate_204"))
          .timeout(const Duration(seconds: 5));

      // Check for the expected 204 status code and an empty body
      return response.statusCode == 204 && response.body.isEmpty;
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}