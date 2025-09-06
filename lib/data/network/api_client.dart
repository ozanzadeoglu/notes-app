import 'package:connectinno_case_client/data/network/models/notes/note_api_model.dart';
import 'package:connectinno_case_client/data/network/models/notes/notes_response.dart';
import 'package:dio/dio.dart';
import '../../core/utils/result.dart';
import '../../domain/repositories/auth/auth_token_provider.dart';
import '../models/note/note_model.dart';

class ApiClient {
  final AuthTokenProvider _tokenProvider;
  final Dio _dio;
  
  ApiClient({
    required Dio dio,
    required AuthTokenProvider tokenProvider,
  }) : _dio = dio,
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
            handler.reject(DioException(
              requestOptions: options,
              message: 'Failed to get auth token: $e',
            ));
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

      final response = await _dio.get(
        'notes',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final notesJson = data['notes'] as List<dynamic>;
        final notes = notesJson
            .map((noteJson) => NoteApiModel.fromJson(noteJson as Map<String, dynamic>))
            .toList();
        
        final serverLastSyncDate = data['lastSyncDate'] as String;
        
        final notesResponse = NotesResponse(
          notes: notes,
          lastSyncDate: serverLastSyncDate,
        );
        
        return Result.ok(notesResponse);
      } else {
        return Result.error(null);
      }
    } on DioException catch (_) {
      return Result.error(null);
    } catch (e) {
      return Result.error(null);
    }
  }

  /// Create a new note
  Future<Result<void>> createNote(NoteModel note) async {
    try {
      final response = await _dio.post(
        'notes',
        data: note.toJson(),
      );
      if (response.statusCode == 201) {
        return Result.ok(null);
      } else {
        return Result.error(null);
      }
    } on DioException catch (_) {
      return Result.error(null);
    } catch (e) {
      return Result.error(null);
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
        return Result.error(null);
      }
    } on DioException catch (_) {
      return Result.error(null);
    } catch (e) {
      return Result.error(null);
    }
  }

  /// Delete a note
  Future<Result<void>> deleteNote(NoteModel note) async {
    try {
      final response = await _dio.delete('notes/${note.uuid}');

      if (response.statusCode == 200) {
        return Result.ok(null);
      } else {
        return Result.error(null);
      }
    } on DioException catch (_) {
      return Result.error(null);
    } catch (e) {
      return Result.error(null);
    }
  }

  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout';
      case DioExceptionType.sendTimeout:
        return 'Send timeout';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout';
      case DioExceptionType.connectionError:
        return 'No internet connection';
      case DioExceptionType.badResponse:
        if (e.response?.data is Map) {
          final error = e.response?.data['error'];
          if (error != null) return error.toString();
        }
        return 'Server error: ${e.response?.statusCode}';
      case DioExceptionType.cancel:
        return 'Request cancelled';
      default:
        return 'Network error: ${e.message}';
    }
  }
}
