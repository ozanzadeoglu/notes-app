import 'package:flutter/foundation.dart';
import '../../../../domain/entities/note/note.dart';
import '../../../../domain/repositories/note/note_repository.dart';
import '../../../../data/services/i_sync_orchestrator.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/errors/app_errors.dart';

class HomeViewModel extends ChangeNotifier {
  final NoteRepository _noteRepository;
  final ISyncOrchestrator _syncOrchestrator;

  List<Note> _notes = [];
  bool _isLoading = false;
  AppError? _error;
  bool _isInitialized = false;

  HomeViewModel({
    required NoteRepository noteRepository,
    required ISyncOrchestrator syncOrchestrator,
  })  : _noteRepository = noteRepository,
        _syncOrchestrator = syncOrchestrator
         {
    _initialize();
  }

  // Getters
  List<Note> get notes => _notes;
  bool get isLoading => _isLoading;
  AppError? get error => _error;
  bool get isInitialized => _isInitialized;

  Future<void> _initialize() async {
    // Listen to sync changes
    _syncOrchestrator.syncTrigger.addListener(_onSyncTriggered);
    // Load initial notes
    await _loadNotes();
    _isInitialized = true;
    notifyListeners();
  }

  void _onSyncTriggered() {
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final result = await _noteRepository.getAllNotes();
    
    switch (result) {
      case Ok():
        _notes = result.value;
        // Sort by updatedAt in historical order.
        _notes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
        _error = null;
        break;
      case Error():
        _error = result.error;
        break;
    }
    notifyListeners();
  }

  Future<void> triggerManualSync() async {
    _setLoading(true);
    _error = null; // Clear any existing errors
    
    try {
      await _syncOrchestrator.triggerSync();
    } catch (e) {
      _error = AppError.syncFailed;
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  Future<void> refreshNotes() async {
    await _loadNotes();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _syncOrchestrator.syncTrigger.removeListener(_onSyncTriggered);
    super.dispose();
  }


}