import 'package:connectinno_case_client/core/errors/app_errors.dart';
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
    final result = await _apiClient.getNotes(lastSyncDate: lastSyncDate);
    switch (result) {
      case Ok<NotesResponse>():
        return result;
      case Error():
        return Result.error(AppError.syncFailed);
    }
  }

  @override
  Future<Result<void>> createNote(NoteModel note) async {
    final result = await _apiClient.createNote(note);
    switch (result) {
      case Ok<void>():
        return result;
      case Error():
        return Result.error(AppError.noteCreationFailed);
    }
  }

  @override
  Future<Result<void>> updateNote(NoteModel note) async {
    final result = await _apiClient.updateNote(note);
    switch (result) {
      case Ok<void>():
        return result;
      case Error():
        return Result.error(AppError.noteUpdateFailed);
    }
  }

  @override
  Future<Result<void>> deleteNote(NoteModel note) async {
    final result = await _apiClient.deleteNote(note);
    switch (result) {
      case Ok<void>():
        return result;
      case Error():
        return Result.error(AppError.noteDeletionFailed);
    }
  }
}