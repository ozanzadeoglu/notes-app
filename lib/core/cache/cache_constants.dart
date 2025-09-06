/// Contains the names of all Hive boxes used in the application.
abstract final class CacheBoxNames {
  /// The box for storing notes.
  static const String notes = 'notesBox';
  static const String queue = 'queueBox';
  static const String lastSyncDate = 'lastSyncDateBox';
}

/// Contains the type id's of all Hive classes used in application.
abstract final class HiveTypeIds {
  static const int note = 1;
  static const int queue = 2;
}
