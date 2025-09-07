import 'package:connectinno_case_client/core/errors/app_errors.dart';
import 'package:connectinno_case_client/data/network/models/notes/note_api_model.dart';
import 'package:connectinno_case_client/data/network/models/notes/notes_response.dart';
import 'package:dio/dio.dart';
import '../../core/utils/result.dart';
import '../../domain/repositories/auth/auth_token_provider.dart';
import '../models/note/note_model.dart';

class ApiClient {
  final AuthTokenProvider _tokenProvider;
  final Dio _dio;

  ApiClient({required Dio dio, required AuthTokenProvider tokenProvider})
    : _dio = dio,
      _tokenProvider = tokenProvider {
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          try {
            // Get ID token from auth provider
            final token = await _tokenProvider.getIdToken();
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
            handler.next(options);
          } catch (e) {
            handler.reject(DioException(requestOptions: options));
          }
        },
      ),
    );
  }

  /// Get notes with optional lastSyncDate
  /// Returns both notes and the new lastSyncDate from server
  Future<Result<NotesResponse>> getNotes({String? lastSyncDate}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (lastSyncDate != null) {
        queryParams['lastSyncDate'] = lastSyncDate;
      }

      final response = await _dio.get('notes', queryParameters: queryParams);

      if (response.statusCode == 200) {
        final data = response.data;
        final notesJson = data['notes'] as List<dynamic>;
        final notes = notesJson
            .map(
              (noteJson) =>
                  NoteApiModel.fromJson(noteJson as Map<String, dynamic>),
            )
            .toList();

        final serverLastSyncDate = data['lastSyncDate'] as String;

        final notesResponse = NotesResponse(
          notes: notes,
          lastSyncDate: serverLastSyncDate,
        );

        return Result.ok(notesResponse);
      } else {
        return Result.error(AppError.syncFailed);
      }
    } on DioException catch (e) {
      return Result.error(_handleDioException(e));
    } catch (e) {
      return Result.error(AppError.unknown);
    }
  }

  /// Create a new note
  Future<Result<void>> createNote(NoteModel note) async {
    try {
      final response = await _dio.post('notes', data: note.toJson());
      if (response.statusCode == 201) {
        return Result.ok(null);
      } else {
        return Result.error(AppError.noteCreationFailed);
      }
    } on DioException catch (e) {
      return Result.error(_handleDioException(e));
    } catch (e) {
      return Result.error(AppError.unknown);
    }
  }

  /// Update an existing note
  Future<Result<void>> updateNote(NoteModel note) async {
    try {
      final response = await _dio.put(
        'notes/${note.uuid}',
        data: note.toJson(),
      );

      if (response.statusCode == 200) {
        return Result.ok(null);
      } else {
        return Result.error(AppError.noteUpdateFailed);
      }
    } on DioException catch (e) {
      return Result.error(_handleDioException(e));
    } catch (e) {
      return Result.error(AppError.unknown);
    }
  }

  /// Delete a note
  Future<Result<void>> deleteNote(NoteModel note) async {
    try {
      final response = await _dio.delete('notes/${note.uuid}');

      if (response.statusCode == 200) {
        return Result.ok(null);
      } else {
        return Result.error(AppError.noteDeletionFailed);
      }
    } on DioException catch (e) {
      return Result.error(_handleDioException(e));
    } catch (e) {
      return Result.error(AppError.unknown);
    }
  }

  AppError _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return AppError.noNetworkConnection;

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 404) {
          return AppError.notFound;
        }
        if (statusCode == 401 || statusCode == 403) {
          return AppError.unauthorized;
        }
        if (statusCode != null && statusCode >= 500) {
          return AppError.serverUnavailable;
        }
        return AppError.unknown;
      case DioExceptionType.cancel:
        return AppError.requestCancelled;
      case DioExceptionType.unknown:
      default:
        return AppError.unknown;
    }
  }

}
