import '../../../core/utils/result.dart';
import '../../entities/note/note.dart';

abstract class NoteRepository {
  /// Creates a new note
  Future<Result<void>> createNote(Note note);
  
  /// Updates an existing note
  Future<Result<void>> editNote(Note note);
  
  /// Removes a note
  Future<Result<void>> removeNote(Note note);
  
  /// Gets all notes
  Future<Result<List<Note>>> getAllNotes();
  
  /// Enhances a note using AI
  Future<Result<Note>> enhanceNote(String noteUuid);
}