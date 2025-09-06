import 'package:connectinno_case_client/core/cache/i_cache_service.dart';
import 'package:connectinno_case_client/core/utils/result.dart';
import 'package:connectinno_case_client/data/models/note/note_model.dart';


abstract class LocalNoteDataSource {
  Future<Result<List<NoteModel>>> getAllNotes();
  Future<Result<void>> saveNote(NoteModel note);
  Future<Result<void>> updateNote(NoteModel note);
  Future<Result<void>> deleteNote(String uuid);
}

class LocalNoteDataSourceImpl implements LocalNoteDataSource {
  final ICacheService<NoteCache> _cacheService;

  LocalNoteDataSourceImpl(this._cacheService);

  @override
  Future<Result<List<NoteModel>>> getAllNotes() async {
    return _cacheService.getAll();
  }

  @override
  Future<Result<void>> saveNote(NoteModel note) async {
    return await _cacheService.put(note.uuid, note);
  }

  @override
  Future<Result<void>>  updateNote(NoteModel note) async {
    return await _cacheService.put(note.uuid, note);
  }

  @override
  Future<Result<void>>  deleteNote(String uuid) async {
    return await _cacheService.delete(uuid);
  }
}