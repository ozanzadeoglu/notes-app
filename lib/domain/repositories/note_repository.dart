import '../entities/note/note.dart';

abstract class NoteRepository {
  /// Creates a new note
  Future<Note> createNote(Note note);
  
  /// Updates an existing note
  Future<Note> editNote(Note note);
  
  /// Removes a note by its UUID
  Future<void> removeNote(String uuid);
  
  /// Gets all notes
  Future<List<Note>> getAllNotes();
}