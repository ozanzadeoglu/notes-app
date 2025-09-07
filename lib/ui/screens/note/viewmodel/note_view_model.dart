import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../../domain/entities/note/note.dart';
import '../../../../domain/repositories/note/note_repository.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/errors/app_errors.dart';

class NoteViewModel extends ChangeNotifier {
  final NoteRepository _noteRepository;
  late final Note _originalNote;
  final bool _isNewNote;

  late TextEditingController _titleController;
  late TextEditingController _contentController;

  bool _isLoading = false;
  AppError? _errorMessage;

  NoteViewModel({
    required NoteRepository noteRepository,
    required Note? note,
    required bool isNewNote,
  }) : _noteRepository = noteRepository,
       _isNewNote = isNewNote {
    _originalNote = note ?? _createEmptyNote();
    _initializeControllers();
  }

  Note _createEmptyNote() {
    final now = DateTime.now();
    return Note(
      uuid: const Uuid().v4(),
      title: '',
      content: '',
      createdAt: now,
      updatedAt: now,
    );
  }

  // Getters
  TextEditingController get titleController => _titleController;
  TextEditingController get contentController => _contentController;
  bool get isLoading => _isLoading;
  AppError? get errorMessage => _errorMessage;
  Note get originalNote => _originalNote;
  bool get isNewNote => _isNewNote;
  bool get hasUnsavedChanges => _hasChanges();

  void _initializeControllers() {
    _titleController = TextEditingController(text: _originalNote.title);
    _contentController = TextEditingController(text: _originalNote.content);
  }

  bool _hasChanges() {
    // Cache the result to avoid repeated string comparisons
    final titleChanged = _titleController.text != _originalNote.title;
    final contentChanged = _contentController.text != _originalNote.content;
    return titleChanged || contentChanged;
  }

  Note _buildUpdatedNote() {
    return _originalNote.copyWith(
      title: _titleController.text.trim(),
      content: _contentController.text.trim(),
      updatedAt: DateTime.now(),
    );
  }

  Future<bool> saveNote() async {
    _setLoading(true);
    _clearError();

    try {
      final updatedNote = _buildUpdatedNote();

      // Don't save if note is empty
      if (updatedNote.title.isEmpty && updatedNote.content.isEmpty) {
        _setLoading(false);
        return false;
      }

      final result = _isNewNote || _originalNote.uuid.isEmpty
          ? await _createNewNote(updatedNote)
          : await _updateExistingNote(updatedNote);

      return result;
    } catch (e) {
      _setError(AppError.noteUpdateFailed);
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> _createNewNote(Note note) async {
    if (note.title.isEmpty) {
      _setError(AppError.noteMustHaveTitle);
      return false;
    }
    final result = await _noteRepository.createNote(note);

    switch (result) {
      case Ok():
        return true;
      case Error():
        _setError(AppError.noteCreationFailed);
        return false;
    }
  }

  Future<bool> _updateExistingNote(Note note) async {
    if (note.title.isEmpty) {
      _setError(AppError.noteMustHaveTitle);
      return false;
    }
    final result = await _noteRepository.editNote(note);

    switch (result) {
      case Ok():
        return true;
      case Error():
        _setError(AppError.noteUpdateFailed);
        return false;
    }
  }

  Future<bool> deleteNote() async {
    if (_isNewNote || _originalNote.uuid.isEmpty) {
      return false;
    }

    _setLoading(true);
    _clearError();

    try {
      final result = await _noteRepository.removeNote(_originalNote);

      switch (result) {
        case Ok():
          return true;
        case Error():
          _setError(AppError.noteDeletionFailed);
          return false;
      }
    } catch (e) {
      _setError(AppError.noteDeletionFailed);
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(AppError error) {
    _errorMessage = error;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<bool> enhanceNote() async {
    if (_originalNote.title.isEmpty || _originalNote.content.isEmpty) {
      // Dont have time to create a specific error.
      _setError(AppError.noteMustHaveTitle);
      return false;
    }

    _setLoading(true);
    _clearError();

    try {
      final result = await _noteRepository.enhanceNote(_originalNote.uuid);

      switch (result) {
        case Ok():
          // Update controllers with enhanced content
          final enhancedNote = result.value;
          _titleController.text = enhancedNote.title;
          _contentController.text = enhancedNote.content;
          return true;
        case Error():
          _setError(result.error ?? AppError.noteEnhanceFailed);
          return false;
      }
    } catch (e) {
      _setError(AppError.noteEnhanceFailed);
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void _clearError() {
    clearError();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
