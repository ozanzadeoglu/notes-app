import '../../../core/connectivity/i_connectivity_service.dart';
import '../../../core/utils/result.dart';
import '../../../domain/entities/note/note.dart';
import '../../../domain/repositories/note/note_repository.dart';
import '../../datasources/note/local_note_datasource.dart';
import '../../datasources/note/remote_note_datasource.dart';
import '../../datasources/queue/queue_datasource.dart';
import '../../models/note/note_model.dart';
import '../../models/queue/queue_model.dart';

class NoteRepositoryImpl implements NoteRepository {
  final LocalNoteDataSource _localDataSource;
  final RemoteNoteDataSource _remoteDataSource;
  final QueueDataSource _queueDataSource;
  final IConnectivityService _connectivityService;

  NoteRepositoryImpl({
    required LocalNoteDataSource localDataSource,
    required RemoteNoteDataSource remoteDataSource,
    required QueueDataSource queueDataSource,
    required IConnectivityService connectivityService,
  }) : _localDataSource = localDataSource,
       _remoteDataSource = remoteDataSource,
       _queueDataSource = queueDataSource,
       _connectivityService = connectivityService;

  @override
  Future<Result<List<Note>>> getAllNotes() async {
    try {
      final localNotes = await _localDataSource.getAllNotes();

      switch (localNotes) {
        case Ok():
          final notes = localNotes.value
              .map((noteModel) => noteModel.toEntity())
              .toList();
          return Result.ok(notes);
        case Error():
          return Result.error(null);
      }
    } catch (e) {
      return Result.error(null);
    }
  }

  @override
  Future<Result<void>> createNote(Note note) async {
    try {
      final noteModel = NoteModel.fromEntity(note);
      final queueModel = QueueModel(note: noteModel, operationType: "post");
      if (_connectivityService.isOnline) {
        // Online: API call first
        final result = await _remoteDataSource.createNote(noteModel);

        // If result is Ok, only save to notes
        switch (result) {
          case Ok():
            await _localDataSource.saveNote(noteModel);
            return Result.ok(null);
          // If result is Error, save it to both notes and queues
          case Error():
            await _localDataSource.saveNote(noteModel);
            await _queueDataSource.addToQueue(queueModel);
            return Result.ok(null);
        }
      } else {
        // Offline: Save locally + add to queue
        await _localDataSource.saveNote(noteModel);
        await _queueDataSource.addToQueue(queueModel);
        return Result.ok(null);
      }
    } catch (e) {
      return Result.error(null);
    }
  }

  @override
  Future<Result<void>> editNote(Note note) async {
    try {
      final noteModel = NoteModel.fromEntity(note);
      final queueModel = QueueModel(note: noteModel, operationType: "put");

      if (_connectivityService.isOnline) {
        // Online: API call first
        final result = await _remoteDataSource.updateNote(noteModel);

        switch (result) {
          // If resutl it Ok, only add to notes
          case Ok():
            await _localDataSource.updateNote(noteModel);
            return Result.ok(null);
          // If result is Error, add both to notes and queue
          case Error():
            await _localDataSource.updateNote(noteModel);
            await _queueDataSource.addToQueue(queueModel);
            return Result.error(null);
        }
      } else {
        // Offline: Update locally + add to queue
        await _localDataSource.updateNote(noteModel);
        await _queueDataSource.addToQueue(queueModel);
        return Result.ok(null);
      }
    } catch (e) {
      return Result.error(null);
    }
  }

  @override
  Future<Result<void>> removeNote(Note note) async {
    final noteModel = NoteModel.fromEntity(note);
    final queueModel = QueueModel(note: noteModel, operationType: "delete");

    try {
      if (_connectivityService.isOnline) {
        // Online: API call first
        final result = await _remoteDataSource.deleteNote(noteModel);

        switch (result) {
          case Ok():
            await _localDataSource.deleteNote(noteModel.uuid);
            return Result.ok(null);
          case Error():
            await _localDataSource.deleteNote(noteModel.uuid);
            await _queueDataSource.addToQueue(queueModel);
            // Shouldn't care.
            return Result.ok(null);
        }
      } else {
        // Offline: Remove locally + add to queue
        await _localDataSource.deleteNote(noteModel.uuid);
        await _queueDataSource.addToQueue(queueModel);
        return Result.ok(null);
      }
    } catch (e) {
      return Result.error(null);
    }
  }
}
