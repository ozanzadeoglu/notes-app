import 'package:connectinno_case_client/core/cache/i_cache_service.dart';
import 'package:connectinno_case_client/core/errors/app_errors.dart';
import 'package:connectinno_case_client/core/utils/result.dart';
import 'package:connectinno_case_client/data/models/note/note_model.dart';

abstract class LocalNoteDataSource {
  Future<Result<List<NoteModel>>> getAllNotes();
  Future<Result<void>> updateNote(NoteModel note);
  Future<Result<void>> deleteNote(String uuid);
}

class LocalNoteDataSourceImpl implements LocalNoteDataSource {
  final ICacheService<NoteCache> _cacheService;

  LocalNoteDataSourceImpl(this._cacheService);

  @override
  Future<Result<List<NoteModel>>> getAllNotes() async {
    final result = await _cacheService.getAll<NoteModel>();

    switch (result) {
      case Ok<List<NoteModel>>():
        return result;
      case Error():
        return Result.error(AppError.localNotesGetFailed);
    }
  }

  @override
  Future<Result<void>> updateNote(NoteModel note) async {
    final result = await _cacheService.put(note.uuid, note);

    switch (result) {
      case Ok<void>():
        return result;
      case Error():
        return Result.error(AppError.localNoteUpdateFailed);
    }
  }

  @override
  Future<Result<void>> deleteNote(String uuid) async {
    final result = await _cacheService.delete(uuid);
    switch (result) {
      case Ok<void>():
        return result;
      case Error():
        return Result.error(AppError.localNoteDeletionFailed);
    }
  }
}
