import 'package:connectinno_case_client/core/utils/result.dart';
import 'package:connectinno_case_client/data/models/note/note_model.dart';
import 'package:connectinno_case_client/data/network/api_client.dart';
import 'package:connectinno_case_client/data/network/models/notes/notes_response.dart';


abstract class RemoteNoteDataSource {
  Future<Result<NotesResponse>> getAllNotes({String? lastSyncDate});
  Future<Result<void>> createNote(NoteModel note);
  Future<Result<void>> updateNote(NoteModel note);
  Future<Result<void>> deleteNote(NoteModel note);
}

class RemoteNoteDataSourceImpl implements RemoteNoteDataSource {
  final ApiClient _apiClient;

  RemoteNoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<NotesResponse>> getAllNotes({String? lastSyncDate}) async {
    return _apiClient.getNotes(lastSyncDate: lastSyncDate);
  }

  @override
  Future<Result<void>> createNote(NoteModel note) async {
    return _apiClient.createNote(note);
  }

  @override
  Future<Result<void>> updateNote(NoteModel note) async {
    return _apiClient.updateNote( note);
  }

  @override
  Future<Result<void>> deleteNote(NoteModel note) async {
    return _apiClient.deleteNote(note);
  }
}