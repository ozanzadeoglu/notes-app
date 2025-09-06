import 'package:connectinno_case_client/core/cache/i_cache_service.dart';
import 'package:connectinno_case_client/data/models/queue/queue_model.dart';
import 'package:connectinno_case_client/data/network/models/notes/notes_response.dart';
import 'package:flutter/foundation.dart';
import '../../core/connectivity/i_connectivity_service.dart';
import '../../core/utils/result.dart';
import '../../domain/repositories/auth/auth_repository.dart';
import '../datasources/note/local_note_datasource.dart';
import '../datasources/note/remote_note_datasource.dart';
import '../datasources/queue/queue_datasource.dart';
import 'i_sync_orchestrator.dart';

class SyncOrchestratorImpl implements ISyncOrchestrator {
  final IConnectivityService _connectivityService;
  final AuthRepository _authRepository;
  final QueueDataSource _queueDataSource;
  final RemoteNoteDataSource _remoteDataSource;
  final LocalNoteDataSource _localNoteDataSource;
  final ICacheService _lastSyncCache;

  final ValueNotifier<bool> _syncTrigger = ValueNotifier<bool>(false);
  bool _isInitialized = false;
  bool _isSyncing = false;
  late String? _lastSyncDate;
  final String _lastSyncKey = "lastSync";

  SyncOrchestratorImpl({
    required IConnectivityService connectivityService,
    required AuthRepository authRepository,
    required QueueDataSource queueDataSource,
    required RemoteNoteDataSource remoteDataSource,
    required LocalNoteDataSource localNoteDataSource,
    required ICacheService lastSyncCache,
  }) : _connectivityService = connectivityService,
       _authRepository = authRepository,
       _queueDataSource = queueDataSource,
       _remoteDataSource = remoteDataSource,
       _localNoteDataSource = localNoteDataSource,
       _lastSyncCache = lastSyncCache;

  @override
  ValueNotifier<bool> get syncTrigger => _syncTrigger;

  @override
  Future<void> initialize() async {
    if (_isInitialized) return;
    // Listen to connectivity changes
    _connectivityService.addListener(_onStateChanged);

    // Listen to auth changes
    _authRepository.addListener(_onStateChanged);

    final result = await _lastSyncCache.get<String?>(_lastSyncKey);

    switch (result) {
      case Ok():
        _lastSyncDate = result.value;
        break;
      case Error():
        _lastSyncDate = null;
    }

    _isInitialized = true;

    // Trigger initial sync if conditions are met
    _onStateChanged();
  }

  @override
  Future<void> triggerSync() async {
    if (!_canSync()) return;
    await _performSync();
  }

  @override
  void dispose() {
    if (!_isInitialized) return;

    _connectivityService.removeListener(_onStateChanged);
    _authRepository.removeListener(_onStateChanged);
    _syncTrigger.dispose();
    _isInitialized = false;
  }

  void _onStateChanged() {
    if (!_canSync() || _isSyncing) return;

    // Perform sync in background
    _performSync();
  }

  bool _canSync() {
    return _connectivityService.isOnline &&
        _authRepository.isAuthenticated &&
        _isInitialized;
  }

  Future<void> _performSync() async {
    if (_isSyncing) return;

    _isSyncing = true;

    try {
      bool shouldTriggerSync = false;

      // 1. Process pending queue operations
      await _processQueue();
      
      // 2. Fetch latest notes from server
      final notesUpdated = await _syncNotesFromServer();

      shouldTriggerSync = notesUpdated;

      // 3. Notify UI to refresh only if changes occurred
      if (shouldTriggerSync) {
        _notifySync();
      }
    } catch (e) {
      debugPrint('Sync failed: $e');
    } finally {
      _isSyncing = false;
    }
  }

  Future<bool> _processQueue() async {
    final queueResult = await _queueDataSource.getAllQueueItems();
    bool hasProcessedItems = false;

    switch (queueResult) {
      case Ok<List<QueueModel>>():
        final queueItems = queueResult.value;

        // If no queue items, return false
        if (queueItems.isEmpty) return false;

        // Optimize queue items before processing
        final optimizedQueue = _optimizeQueueItems(queueItems);

        // Remove redundant items from actual queue before processing
        for (final originalItem in queueItems) {
          if (!optimizedQueue.contains(originalItem)) {
            await _queueDataSource.removeFromQueue(originalItem.queueKey);
            hasProcessedItems = true; // Removing redundant items counts as processing
          }
        }

        // Process the optimized queue
        for (final queueItem in optimizedQueue) {
          bool success = false;

          switch (queueItem.operationType) {
            case 'post':
              final result = await _remoteDataSource.createNote(queueItem.note);
              success = result is Ok;
              break;

            case 'put':
              final result = await _remoteDataSource.updateNote(queueItem.note);
              success = result is Ok;
              break;

            case 'delete':
              final result = await _remoteDataSource.deleteNote(queueItem.note);
              success = result is Ok;
              break;
          }

          // Remove from queue if successful
          if (success) {
            await _queueDataSource.removeFromQueue(queueItem.queueKey);
            hasProcessedItems = true;
          } else {
          }
        }
        break;

      case Error<List<QueueModel>>():
        debugPrint('Failed to get queue items: ${queueResult.error}');
        return false;
    }

    return hasProcessedItems;
  }

  /// Optimizes queue items to avoid redundant operations
  /// Rules:
  /// 1. If delete exists for a note, remove all previous operations for that note
  /// 2. If both post and put exist for same note, keep first post and latest put
  /// 3. Keep latest operation if multiple of same type exist for same note
  List<QueueModel> _optimizeQueueItems(List<QueueModel> queueItems) {
    // Group by note UUID
    final Map<String, List<QueueModel>> noteOperations = {};

    for (final item in queueItems) {
      final noteId = item.note.uuid;
      noteOperations.putIfAbsent(noteId, () => []).add(item);
    }

    final List<QueueModel> optimizedQueue = [];

    for (final noteId in noteOperations.keys) {
      final operations = noteOperations[noteId]!;

      // Sort by note updatedAt to get chronological order
      operations.sort((a, b) => a.note.updatedAt.compareTo(b.note.updatedAt));

      // Check if there's a delete operation
      final hasDelete = operations.any((op) => op.operationType == 'delete');

      if (hasDelete) {
        // If delete exists, only keep the latest delete operation
        final deleteOp = operations.lastWhere(
          (op) => op.operationType == 'delete',
        );
        optimizedQueue.add(deleteOp);
      } else {
        // No delete operation, optimize create/update operations
        final hasPost = operations.any((op) => op.operationType == 'post');
        final hasPut = operations.any((op) => op.operationType == 'put');

        if (hasPost && hasPut) {
          // Both post and put exist, keep POST first then latest PUT (server needs creation before update)
          final postOp = operations.firstWhere((op) => op.operationType == 'post');
          final putOp = operations.lastWhere((op) => op.operationType == 'put');
          optimizedQueue.add(postOp);
          optimizedQueue.add(putOp);
        } else if (hasPost) {
          // Only post operations, keep the latest
          final postOp = operations.lastWhere(
            (op) => op.operationType == 'post',
          );
          optimizedQueue.add(postOp);
        } else if (hasPut) {
          // Only put operations, keep the latest
          final putOp = operations.lastWhere((op) => op.operationType == 'put');
          optimizedQueue.add(putOp);
        }
      }
    }

    // Sort final queue by note updatedAt to maintain chronological processing order
    optimizedQueue.sort((a, b) => a.note.updatedAt.compareTo(b.note.updatedAt));

    return optimizedQueue;
  }

  Future<bool> _syncNotesFromServer() async {
    final result = await _remoteDataSource.getAllNotes(lastSyncDate: _lastSyncDate);
    bool hasUpdatedNotes = false;

    switch (result) {
      case Ok<NotesResponse>():
        final serverNotes = result.value.notes;
        
        // Always update lastSyncDate on successful response
        try {
          await _lastSyncCache.put(_lastSyncKey, result.value.lastSyncDate);
          _lastSyncDate = result.value.lastSyncDate;
        } catch (e) {
          debugPrint("Sync unsuccessful");
          return false;
        }

        // If no server notes, device is already synced - return false (no UI update needed)
        if (serverNotes.isEmpty) return false;

        // Update local cache with server notes
        for (final serverNote in serverNotes) {
          switch (serverNote.isDeleted) {
            case true:
              await _localNoteDataSource.deleteNote(serverNote.uuid);
              hasUpdatedNotes = true;
              break;
            case false:
              await _localNoteDataSource.updateNote(serverNote.toModel());
              hasUpdatedNotes = true;
              break;
          }
        }
        break;

      case Error<NotesResponse>():
        debugPrint('Failed to sync notes from server: ${result.error}');
        return false;
    }

    return hasUpdatedNotes;
  }

  void _notifySync() {
    // Toggle the boolean to trigger UI refresh
    _syncTrigger.value = !_syncTrigger.value;
  }
}
