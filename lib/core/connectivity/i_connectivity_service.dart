import 'package:flutter/material.dart';

/// Defines the contract for a service that monitors network connectivity.
abstract class IConnectivityService extends ChangeNotifier{
  /// A synchronous getter to check the current connectivity status.
  bool get isOnline;
  /// Performs an initial check of the connectivity status.
  /// This is called once at app startup.
  Future<void> initialize();

}