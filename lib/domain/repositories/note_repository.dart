import '../../core/utils/result.dart';
import '../entities/note/note.dart';

abstract class NoteRepository {
  /// Creates a new note
  Future<Result<Note>> createNote(Note note);
  
  /// Updates an existing note
  Future<Result<Note>> editNote(Note note);
  
  /// Removes a note by its UUID
  Future<Result<void>> removeNote(String uuid);
  
  /// Gets all notes
  Future<Result<List<Note>>> getAllNotes();
}