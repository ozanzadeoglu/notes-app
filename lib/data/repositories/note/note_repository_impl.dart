import 'package:connectinno_case_client/core/errors/app_errors.dart';
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
          return Result.error(localNotes.error);
      }
    } catch (e) {
      return Result.error(AppError.unknown);
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
            await _localDataSource.updateNote(noteModel);
            return Result.ok(null);
          // If result is Error, save it to both notes and queues

          case Error():
            final localResult = await _localDataSource.updateNote(noteModel);
            if (localResult is Error) {
              return Result.error(AppError.noteCreationFailed);
            }
            final queueResult = await _queueDataSource.addToQueue(queueModel);
            if (queueResult is Error) {
              return Result.error(AppError.noteCreationFailed);
            }
            return Result.ok(null);
        }
      } else {
        // Offline: Save locally + add to queue
        final localResult = await _localDataSource.updateNote(noteModel);
        if (localResult is Error) {
          return Result.error(AppError.noteCreationFailed);
        }
        final queueResult = await _queueDataSource.addToQueue(queueModel);
        if (queueResult is Error) {
          return Result.error(AppError.noteCreationFailed);
        }
        return Result.ok(null);
      }
    } catch (e) {
      return Result.error(AppError.noteCreationFailed);
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
            // Offline: Save locally + add to queue
            final localResult = await _localDataSource.updateNote(noteModel);
            if (localResult is Error) {
              return Result.error(AppError.noteUpdateFailed);
            }
            final queueResult = await _queueDataSource.addToQueue(queueModel);
            if (queueResult is Error) {
              return Result.error(AppError.noteUpdateFailed);
            }
            return Result.ok(null);
        }
      } else {
        // Offline: Update locally + add to queue
        final localResult = await _localDataSource.updateNote(noteModel);
        if (localResult is Error) {
          return Result.error(AppError.noteUpdateFailed);
        }
        final queueResult = await _queueDataSource.addToQueue(queueModel);
        if (queueResult is Error) {
          return Result.error(AppError.noteUpdateFailed);
        }
        return Result.ok(null);
      }
    } catch (e) {
      return Result.error(AppError.noteUpdateFailed);
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
            final localResult = await _localDataSource.deleteNote(
              noteModel.uuid,
            );
            if (localResult is Error) {
              return Result.error(AppError.noteDeletionFailed);
            }
            final queueResult = await _queueDataSource.addToQueue(queueModel);
            if (queueResult is Error) {
              return Result.error(AppError.noteDeletionFailed);
            }
            return Result.ok(null);
        }
      } else {
        // Offline: Remove locally + add to queue
        final localResult = await _localDataSource.deleteNote(noteModel.uuid);
        if (localResult is Error) {
          return Result.error(AppError.noteDeletionFailed);
        }
        final queueResult = await _queueDataSource.addToQueue(queueModel);
        if (queueResult is Error) {
          return Result.error(AppError.noteDeletionFailed);
        }
        return Result.ok(null);
      }
    } catch (e) {
      return Result.error(AppError.noteDeletionFailed);
    }
  }
}
