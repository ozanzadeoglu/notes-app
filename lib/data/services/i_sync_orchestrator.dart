import 'package:flutter/foundation.dart';

abstract class ISyncOrchestrator {
  /// Triggers UI refresh when sync operations complete
  /// ViewModels listen to this and call getAllNotes() when it changes
  ValueNotifier<bool> get syncTrigger;
  
  /// Initialize the orchestrator and start monitoring
  Future<void> initialize();
  
  /// Manually trigger a sync operation (for pull-to-refresh, etc.)
  Future<void> triggerSync();
  
  /// Dispose resources and stop monitoring
  void dispose();
}